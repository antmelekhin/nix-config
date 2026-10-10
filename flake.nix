{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-darwin, nix-homebrew, home-manager, ... }: let
    username = "antmelekhin";
    hostname = "antmelekhin-mbp";
  in {
    darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit username;
      };

      system = "x86_64-darwin";

      modules = [
        {
          nixpkgs.config.allowUnfree = true;
        }

        ./configuration.nix

        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "${username}";
            mutableTaps = true;
            autoMigrate = true;
          };
        }

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home.nix;
        }
      ];
    };
  };
}
