{
  description = "Home Manager NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };
  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    {
      homeConfigurations = {
        thiago = inputs.home-manager.lib.homeManagerConfiguration {
          system = "aarch64-darwin";
          homeDirectory = "/Users/thiago";
          username = "thiago";
          stateVersion = "21.11";
          configuration = { config, pkgs, ... }:
            let
              overlay-unstable = final: prev: {
                unstable = inputs.nixpkgs-unstable.legacyPackages.aarch64-darwin;
              };
            in
            {
              nixpkgs.overlays = [ overlay-unstable inputs.neovim-nightly-overlay.overlay ];
              nixpkgs.config = {
                allowUnfree = true;
                allowBroken = true;
              };

              imports = [
                ./users/thiago/home.nix
              ];
            };
        };

        "thiago.pontes" = inputs.home-manager.lib.homeManagerConfiguration {
            system = "aarch64-darwin";
            homeDirectory = "/Users/thiago.pontes";
            username = "thiago.pontes";
            stateVersion = "21.11";
            configuration = { config, pkgs, ... }:
              let
                overlay-unstable = final: prev: {
                  unstable = inputs.nixpkgs-unstable.legacyPackages.aarch64-darwin;
                };
              in
              {
                nixpkgs.overlays = [ overlay-unstable inputs.neovim-nightly-overlay.overlay ];
                nixpkgs.config = {
                  allowUnfree = true;
                  allowBroken = true;
                };

                imports = [
                  ./users/thiago/home.nix
                ];
              };
          };
      };
      defaultPackage.aarch64-darwin = self.thiago;
    };
}
