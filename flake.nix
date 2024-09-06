{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nixvim = {
            url = "github:nix-community/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, ... }@inputs:
        let
        system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    in
    {
        # main PC configuration
        nixosConfigurations.workstation = nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs;}; # pass inputs to all modules
                modules = [ 
                ./hosts/workstation/configuration.nix
                inputs.home-manager.nixosModules.default
                ];
        };
        # hp envy laptop configuration 
        nixosConfigurations.hpenvy = nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs;}; # pass inputs to all modules
                modules = [ 
                ./hosts/hpenvy/configuration.nix
                inputs.home-manager.nixosModules.default
                ];
        };
        # dell funnel configuration 
        nixosConfigurations.dellfunnel = nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs;}; # pass inputs to all modules
                modules = [ 
                ./hosts/dellfunnel/configuration.nix
                inputs.home-manager.nixosModules.default
                ];
        };
    };
}
