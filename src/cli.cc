#include "cli.hh"
#include <optional>
#include <string_view>
#include <vector>

using ns::cli::Command;

namespace ns::cli {

    constexpr std::pair<std::string_view, Command> cmd_lookup[] = {
        {"shell",    Command::Shell },
        {"run",      Command::Run },
        {"edit",     Command::Edit },
        {"homepage", Command::Homepage },
        {"source",   Command::Source },
        {"search",   Command::Search },
        {"help",     Command::Help },
        {"license",  Command::License }
    };

    Options Options::from_args(int argc, char **argv) {
        Options opts{};

        std::vector<std::string_view> args(argv + 1, argv + argc);

        if (args.empty()) {
            opts.help_is_error = true;
            return opts;
        }

        for (auto arg : args) {
            if (arg == "-h" || arg == "--help") {
                return opts;
            }
            else if (arg == "--license") {
                opts.command = Command::License;
                return opts;
            }
        }

        bool subcommand_set = false;
        for (auto arg : args) {
            // Subcommands
            if (!subcommand_set) {
                auto cmd = ns::cli::command_from_string(arg);
                if (!cmd) continue;

                opts.command = cmd.value();
                subcommand_set = true;
                continue;
            }

            // Secondary Flags
            if (arg == "--unfree" || arg == "-u") {
                opts.allow_unfree = true;
            }
            else if (arg == "--no-unfree") {
                opts.allow_unfree = false;
            }
            else if (arg == "--allow-insecure") {
                opts.allow_insecure = true;
            }

            // Extra positionals
            else if (opts.query.empty() && subcommand_set) {
                opts.query = arg;
            }
            else {
                opts.junk.push_back(arg);
            }
        }

        return opts;
    }

    std::optional<Command> command_from_string(const std::string_view input) {
        for (auto [name, cmd] : cmd_lookup) {
            if (input == name) return cmd;
        }

        return std::nullopt;
    }
} // ns::cli
