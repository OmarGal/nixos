{
  description = "flake for nixos";
	
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs = {
	nixpkgs.follows = "nixpkgs";
	#home-manager.follows = "home-manager";
      };
    };
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
 	inherit system;
	modules = [ 
	  ./configuration.nix
	];
      };
    };
    homeConfigurations = {
      kiwi = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;	
	modules = [ 
	  ./home.nix
	];
	extraSpecialArgs = {
	  inherit (inputs) stylix;
	};
      };
    };
  };
}
