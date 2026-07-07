#pragma once
#include <format>
#include <optional>
#include <string>
#include <string_view>
#include <vector>

namespace ns::cli {

    /// The possible subcommands for `ns`
    enum class Command {
        Shell,
        Run,
        Edit,
        Homepage,
        Source,
        Search,
        Help,
        License
    };

    /// Data extracted from the command line interface of `ns`.
    struct Options {
        Command command = Command::Help;
        std::string_view query;
        std::vector<std::string_view> junk;

        bool allow_unfree = false;
        bool allow_insecure = false;
        bool help_is_error = false;

        static Options from_args(int argc, char** argv);
    };

    /// A helper function to parse text into a `Command`.
    std::optional<Command> command_from_string(const std::string_view input);


    constexpr std::string_view HELP = R"(Nix search utilities.

usage: ns [-h|--help] <SUBCOMMNAD>

Commands
  shell      Start an interactive shell with some packages from nixpkgs.
  run        Run a program from nixpkgs.
  edit       Open the source code for a derivation from nixpkgs in \$EDITOR.
  homepage   Open the homepage for the selected package(s).
  source     Open the package's nix declaration.
  search     Search options (prints to stdout on selection).
  help       Print this help message and exit.

Options
  -h,--help  Print this help message and exit.
  --license  Print license info and exit.

Copyright (C) 2026  James C. Craven <4jamesccraven@gmail.com>)";

    constexpr std::string_view LEGAL = R"(ns - Nix search utilities.
Copyright (C) 2026  James C. Craven <4jamesccraven@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.)";


} // ns::cli

template<>
struct std::formatter<ns::cli::Command> : std::formatter<std::string_view> {
    auto format(const ns::cli::Command cmd, format_context& ctx) const {
        using ns::cli::Command;

        std::string_view cmd_name = "UNKNOWN";

        switch (cmd) {
            case Command::Shell:    cmd_name = "shell";    break;
            case Command::Run:      cmd_name = "run";      break;
            case Command::Edit:     cmd_name = "edit";     break;
            case Command::Homepage: cmd_name = "homepage"; break;
            case Command::Source:   cmd_name = "source";   break;
            case Command::Search:   cmd_name = "search";   break;
            case Command::Help:     cmd_name = "help";     break;
            case Command::License:  cmd_name = "license";  break;
        }

        return std::formatter<std::string_view>::format(cmd_name, ctx);
    }
};

template<>
struct std::formatter<ns::cli::Options> : std::formatter<std::string_view> {
    auto format(const ns::cli::Options opts, format_context& ctx) const {
        std::string out = "{\n";
        out += std::format("  \"command\": \"{}\",\n", opts.command);
        out += std::format("  \"query\": \"{}\",\n", opts.query);
        out += std::format("  \"allow_unfree\": {},\n", opts.allow_unfree);
        out += std::format("  \"allow_insecure\": {},\n", opts.allow_insecure);
        out += std::format("  \"help_is_error\": {}\n", opts.help_is_error);
        out += "}";

        return std::formatter<std::string_view>::format(out, ctx);
    }
};
