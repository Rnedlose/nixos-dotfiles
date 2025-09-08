# {
# 	description = "NixOS";
# 	inputs = {
# 		nixpkgs.url = "nixpkgs/nixos-25.05";
#     pyprland.url = "github:hyprland-community/pyprland";
# 		home-manager = {
# 			url = "github:nix-community/home-manager/release-25.05";
# 			inputs.nixpkgs.follows = "nixpkgs";
# 		};
# 	};
#
# 	outputs = { self, nixpkgs, nixpkgs-unstable, pyprland, home-manager, ... }: {
# 		nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
# 			system = "x86_64-linux";
# 			specialArgs = {
# 				pyprland = pyprland.packages."x86_64-linux".pyprland;
# 			};
# 			modules = [
# 				./configuration.nix
# 				home-manager.nixosModules.home-manager
# 				{
# 					home-manager = {
# 						useGlobalPkgs = true;
# 						useUserPackages = true;
# 						users.rodney = import ./home.nix;
# 						backupFileExtension = "backup";
# 					};
# 				}
# 			];
# 		};
# 	};
# }

{
	description = "NixOS";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.05";
    # Add the unstable channel as a new input
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    pyprland.url = "github:hyprland-community/pyprland";
		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	
	outputs = { self, nixpkgs, nixpkgs-unstable, pyprland, home-manager, ... }: {
		nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = {
				pyprland = pyprland.packages."x86_64-linux".pyprland;
        # Pass the unstable channel into the NixOS configuration
        inherit nixpkgs-unstable;
			};
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.rodney = import ./home.nix;
						backupFileExtension = "backup";
            # Pass the unstable channel into the Home Manager configuration
            extraSpecialArgs = { inherit nixpkgs-unstable; };
					};
				}
			];
		};
	};
}


