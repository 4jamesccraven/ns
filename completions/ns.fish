# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_ns_global_optspecs
    string join \n license h/help
end

function __fish_ns_needs_command
    # Figure out if the current invocation already has a command.
    set -l cmd (commandline -opc)
    set -e cmd[1]
    argparse -s (__fish_ns_global_optspecs) -- $cmd 2>/dev/null
    or return
    if set -q argv[1]
        # Also print the command, so this can be used to figure out what it is.
        echo $argv[1]
        return 1
    end
    return 0
end

function __fish_ns_using_subcommand
    set -l cmd (__fish_ns_needs_command)
    test -z "$cmd"
    and return 1
    contains -- $cmd[1] $argv
end

complete -c ns -n "__fish_ns_needs_command" -l license -d 'Print license info and exit'
complete -c ns -n "__fish_ns_needs_command" -s h -l help -d 'Print help'
complete -c ns -n "__fish_ns_needs_command" -f -a "shell" -d 'Start an interactive shell with some packages from nixpkgs'
complete -c ns -n "__fish_ns_needs_command" -f -a "run" -d 'Run a program from nixpkgs'
complete -c ns -n "__fish_ns_needs_command" -f -a "edit" -d 'Open the source code for a derivation from nixpkgs in $EDITOR'
complete -c ns -n "__fish_ns_needs_command" -f -a "homepage" -d 'Open the homepage for the selected package(s)'
complete -c ns -n "__fish_ns_needs_command" -f -a "source" -d 'Open the package\'s nix declaration'
complete -c ns -n "__fish_ns_needs_command" -f -a "search" -d 'Search options (prints to stdout on selection)'
complete -c ns -n "__fish_ns_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c ns -n "__fish_ns_using_subcommand shell" -s h -l help -d 'Print help'
complete -c ns -n "__fish_ns_using_subcommand run" -s h -l help -d 'Print help'
complete -c ns -n "__fish_ns_using_subcommand edit" -s h -l help -d 'Print help'
complete -c ns -n "__fish_ns_using_subcommand homepage" -s h -l help -d 'Print help'
complete -c ns -n "__fish_ns_using_subcommand source" -s h -l help -d 'Print help'
complete -c ns -n "__fish_ns_using_subcommand search" -s h -l help -d 'Print help'
complete -c ns -n "__fish_ns_using_subcommand help; and not __fish_seen_subcommand_from shell run edit homepage source search help" -f -a "shell" -d 'Start an interactive shell with some packages from nixpkgs'
complete -c ns -n "__fish_ns_using_subcommand help; and not __fish_seen_subcommand_from shell run edit homepage source search help" -f -a "run" -d 'Run a program from nixpkgs'
complete -c ns -n "__fish_ns_using_subcommand help; and not __fish_seen_subcommand_from shell run edit homepage source search help" -f -a "edit" -d 'Open the source code for a derivation from nixpkgs in $EDITOR'
complete -c ns -n "__fish_ns_using_subcommand help; and not __fish_seen_subcommand_from shell run edit homepage source search help" -f -a "homepage" -d 'Open the homepage for the selected package(s)'
complete -c ns -n "__fish_ns_using_subcommand help; and not __fish_seen_subcommand_from shell run edit homepage source search help" -f -a "source" -d 'Open the package\'s nix declaration'
complete -c ns -n "__fish_ns_using_subcommand help; and not __fish_seen_subcommand_from shell run edit homepage source search help" -f -a "search" -d 'Search options (prints to stdout on selection)'
complete -c ns -n "__fish_ns_using_subcommand help; and not __fish_seen_subcommand_from shell run edit homepage source search help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
