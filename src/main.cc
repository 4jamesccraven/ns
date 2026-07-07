#include "cli.hh"
#include <print>

using namespace ns;
using cli::Command;
using cli::HELP;
using cli::LEGAL;

int main(int argc, char** argv) {
    auto args = cli::Options::from_args(argc, argv);

    if (args.command == Command::Help) {
        std::println("{}", HELP);
        return (args.help_is_error) ? 1 : 0;
    }

    if (args.command == Command::License) {
        std::println("{}", LEGAL);
        return 0;
    }

    std::println(stderr, "{}", args);

    return 0;
}
