# ns - Nix utilities
`ns` is a simple shell script that provides glue code for
[nix-search-tv](https://github.com/3timeslazy/nix-search-tv) and
[fzf](https://github.com/junegunn/fzf), with some add UI niceties using
[gum](https://github.com/charmbracelet/gum). There are dozens of other ways you
could set this up, this is just the way I like it personally.

## Supported Methods
You can use `ns` to do the following things:
- Start a shell script with one or more nixpkgs. Equivalent to running `nix
  shell nixpkgs#a [nixpkgs#b ...]`.
- Run a program from nixpkgs. Equivalent to running `nix run nixpkgs#a`
- Open a package's definition in your `$EDITOR` or browser. Equivalent to
  running `nix edit nixpkgs#a` or `xdg-open` on the link to its definition.
- Open the homepage for the package in your browser.
- Or just select some packages/nixos options/home-manager options and print them to stdout.

Example output of help:
```
Nix search utilities.

usage: ns [-h|--help] <SUBCOMMNAD>

Commands
  shell      Start an interactive shell with some packages from nixpkgs.
  run        Run a program from nixpkgs.
  edit       Open the source code for a derivation from nixpkgs in $EDITOR.
  homepage   Open the homepage for the selected package(s).
  source     Open the package's nix declaration.
  search     Search options (prints to stdout on selection).
  help       Print this help message and exit.

Options
  -h,--help  Print this help message and exit.
  --license  Print license info and exit.

Copyright (C) 2026  James C. Craven <4jamesccraven@gmail.com>
```

## Legal
ns is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute this software under certain conditions.
See LICENSE for more details.
