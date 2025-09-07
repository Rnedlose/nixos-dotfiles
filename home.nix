{ config, pkgs, ... }:

let
	dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
	create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

	configs = {
    hypr = "hypr";
    nvim = "nvim";
    wofi = "wofi";
    alacritty = "alacritty";
    fastfetch = "fastfetch";
    waybar = "waybar";
    bat = "bat";
    btop = "btop";
    mako = "mako";
    swayosd = "swayosd";
    tmux = "tmux";
	};
in

{
	home.username = "rodney";
	home.homeDirectory = "/home/rodney";
	home.stateVersion = "25.05";
	
	programs.git = {
    enable = true;
    userName = "Rodney Nedlose";
    userEmail = "nedloserodney@gmail.com";
  };
  programs.zsh.enable = true;

	home.sessionPath = [ "/home/rodney/.local/bin" ];
  
  # Zsh configuration - goes in home directory, not .config
  home.file.".zshrc" = {
    source = create_symlink "${dotfiles}/.zshrc";
  };

  # Combine all xdg.configFile entries
	xdg.configFile = (builtins.mapAttrs
		(name: subpath: {
			source = create_symlink "${dotfiles}/${subpath}";
			recursive = true;
		})
		configs) // {
    # Starship configuration
    "starship.toml" = {
      source = create_symlink "${dotfiles}/starship.toml";
      recursive = false;
    };
  };
	
	home.packages = with pkgs; [
		neovim
		ripgrep
		nil
		nixpkgs-fmt
		nodejs
		gcc
		wofi
		hyprlock
		hypridle
		hyprpaper
		hyprsunset
		hyprpicker
		hyprshot
		starship
		fastfetch
		btop
		bat
		mako
		swayosd
		waybar
		eza
		zoxide
		bluetui
		bluez
		tmux
		wl-clipboard
		cliphist
		gum
    rustc
    cargo
    python314
    pavucontrol
    pamixer
    nautilus
    imv
    mpd
    chromium
    warp-terminal
    unzip
    yaru-theme
    dconf-editor
    libnotify
    glib
    fzf
    spotify
    vesktop
    obsidian
    lazygit
    go
    docker
    lazydocker
    vlc
    luaformatter
    ruby-lsp
    vial
	];

}
