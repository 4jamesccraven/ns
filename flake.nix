{
  description = "A fuzzy search helper for various nix options (powered by nix-search-tv).";

  inputs.nixpkgs.url = "https://channels.nixos.org/nixos-25.11/nixexprs.tar.xz";

  outputs =
    { nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      eachDefaultSystem =
        function: lib.genAttrs lib.systems.flakeExposed (system: function nixpkgs.legacyPackages.${system});

      mkPackage =
        pkgs:
        pkgs.writeShellApplication {
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
    {
      packages = eachDefaultSystem (pkgs: {
        default = mkPackage pkgs;
      });

      overlays.default = final: prev: {
        ns = mkPackage prev;
      };

      devShells = eachDefaultSystem (pkgs: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            fzf
            gum
            nix-search-tv
          ];
        };
      });
    };
}
