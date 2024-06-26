{ config, pkgs, stylix, ... }:

{

  imports = [
    #stylix.homeManagerModules.stylix
    ./sh.nix
    ./swayidle.nix
    ./stylix.nix
    ./hyprland.nix
  ];

  # Stylix
  #stylix.image = /home/kiwi/Downloads/wall.png;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kiwi";
  home.homeDirectory = "/home/kiwi";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    xwayland.enable = true;
  };
  #environment.sessionVariables = {
  #  # If your cursor becomes invisible
  #  WLR_NO_HARDWARE_CURSORS = "1";
  #  #  Hint electron apps to use wayland
  #  NIXOS_OZONE_WL = "1";
  #};

  # idk
  gtk.enable = true;
  qt.enable = true;

  # KDE connect
  services.kdeconnect.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    google-chrome
    cinnamon.nemo
    floorp
    hyprpaper
    kitty
    pavucontrol
    rofi-wayland
    waybar
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Git
  programs.git = {
    enable = true;
    userName  = "omar";
    userEmail = "omargalindol.01@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kiwi/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
