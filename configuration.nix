{ config, lib, pkgs, ... }:

{
  imports =
    [       
	./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos-btw";  
  # networking.wireless.enable = true; 
  networking.wireless.iwd.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  time.timeZone = "America/Chicago";

  services.printing.enable = true;
 
  security.rtkit.enable = true;
  nixpkgs.config.allowUnfree = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.libinput.enable = true;
  services.displayManager.ly.enable = true;
  programs.zsh.enable = true;
  users.users.rodney = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  programs.hyprland.enable = true;
 
  hardware.graphics.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    alacritty
    impala
  ];
 
  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05"; 
}

