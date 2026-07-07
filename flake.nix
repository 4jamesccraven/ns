{
  description = "A fuzzy search helper for various nix options (powered by nix-search-tv).";

  inputs.nixpkgs.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.xz";

  outputs =
    { nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      eachDefaultSystem =
        function: lib.genAttrs lib.systems.flakeExposed (system: function nixpkgs.legacyPackages.${system});

      mkPackage = pkgs: null;

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
            # Build deps
            gcc
            cmake
            ninja

            # Development tools
            clang-tools
            just
            cmake-language-server

            # Runtime deps
            fzf
            nix-search-tv
          ];
        };
      });
    };
}
