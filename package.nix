{ pkgs, ... }:

let
  scriptPkg = pkgs.writeShellApplication {
    name = "ns";
    text = builtins.readFile ./ns;
    runtimeInputs = with pkgs; [
      fzf
      gum
      nix-search-tv
    ];

    meta = {
      license = pkgs.lib.licenses.gpl3Plus;
      mainProgram = "ns";
    };
  };
in
pkgs.symlinkJoin {
  name = "ns";
  paths = [ scriptPkg ];

  nativeBuildInputs = [ pkgs.installShellFiles ];
  postBuild = ''
    installShellCompletion --cmd ns \
      --bash ${./completions/ns.bash} \
      --zsh ${./completions/_ns} \
      --fish ${./completions/ns.fish}
  '';
}
