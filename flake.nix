{
  description = "A fuzzy search helper for various nix options (powered by nix-search-tv).";

  inputs.nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";

  outputs =
    { nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      eachDefaultSystem =
        function: lib.genAttrs lib.systems.flakeExposed (system: function nixpkgs.legacyPackages.${system});
    in
    {
      packages = eachDefaultSystem (pkgs: {
        default = import ./package.nix { inherit pkgs; };
      });

      overlays.default = final: prev: {
        ns = import ./package.nix { pkgs = prev; };
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
