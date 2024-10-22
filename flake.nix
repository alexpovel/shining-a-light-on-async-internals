{
  description = "Development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShells.default = with pkgs; mkShell {
          packages = [
            cargo-watch
            gnumake
            pandoc
            qrencode
          ];

          shellHook = ''
            # Force Apple Clang over Nix-provided, which can fail compilations (`liconv` missing)
            export PATH="/usr/bin/:$PATH"
          '';
        };
      }
    );
}
