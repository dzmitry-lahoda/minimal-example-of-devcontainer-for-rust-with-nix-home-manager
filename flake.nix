{
  description = "Home Manager for devcontainer";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
   rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, rust-overlay, ... }:
    let
      system = "x86_64-linux";
pkgs = import nixpkgs {
          inherit system;
          overlays = [ (import rust-overlay) ];
        };      
    in {
      packages.${system} = {
       activate = pkgs.writeShellApplication {
              name = "activate";
              runtimeInputs = with pkgs; [ home-manager ];

              text = "${pkgs.lib.getExe pkgs.home-manager} switch -b backup --flake . --extra-experimental-features nix-command --extra-experimental-features flakes";
            };
      };
      homeConfigurations.vscode = 
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
    };
}