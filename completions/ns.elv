
use builtin;
use str;

set edit:completion:arg-completer[ns] = {|@words|
    fn spaces {|n|
        builtin:repeat $n ' ' | str:join ''
    }
    fn cand {|text desc|
        edit:complex-candidate $text &display=$text' '(spaces (- 14 (wcswidth $text)))$desc
    }
    var command = 'ns'
    for word $words[1..-1] {
        if (str:has-prefix $word '-') {
            break
        }
        set command = $command';'$word
    }
    var completions = [
        &'ns'= {
            cand --license 'Print license info and exit'
            cand -h 'Print help'
            cand --help 'Print help'
            cand shell 'Start an interactive shell with some packages from nixpkgs'
            cand run 'Run a program from nixpkgs'
            cand edit 'Open the source code for a derivation from nixpkgs in $EDITOR'
            cand homepage 'Open the homepage for the selected package(s)'
            cand source 'Open the package''s nix declaration'
            cand search 'Search options (prints to stdout on selection)'
            cand help 'Print this message or the help of the given subcommand(s)'
        }
        &'ns;shell'= {
            cand -h 'Print help'
            cand --help 'Print help'
        }
        &'ns;run'= {
            cand -h 'Print help'
            cand --help 'Print help'
        }
        &'ns;edit'= {
            cand -h 'Print help'
            cand --help 'Print help'
        }
        &'ns;homepage'= {
            cand -h 'Print help'
            cand --help 'Print help'
        }
        &'ns;source'= {
            cand -h 'Print help'
            cand --help 'Print help'
        }
        &'ns;search'= {
            cand -h 'Print help'
            cand --help 'Print help'
        }
        &'ns;help'= {
            cand shell 'Start an interactive shell with some packages from nixpkgs'
            cand run 'Run a program from nixpkgs'
            cand edit 'Open the source code for a derivation from nixpkgs in $EDITOR'
            cand homepage 'Open the homepage for the selected package(s)'
            cand source 'Open the package''s nix declaration'
            cand search 'Search options (prints to stdout on selection)'
            cand help 'Print this message or the help of the given subcommand(s)'
        }
        &'ns;help;shell'= {
        }
        &'ns;help;run'= {
        }
        &'ns;help;edit'= {
        }
        &'ns;help;homepage'= {
        }
        &'ns;help;source'= {
        }
        &'ns;help;search'= {
        }
        &'ns;help;help'= {
        }
    ]
    $completions[$command]
}
