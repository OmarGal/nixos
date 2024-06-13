{ pkgs, stylix, ... }:
{

  imports = [
    #stylix.homeManagerModules.stylix
    #stylix.nixosModules.stylix
  ];

  # Stylix
  stylix.image = /home/kiwi/Downloads/wall.png;
  stylix.base16Scheme = ./. + /themes/catppuccin-mocha.yaml;

  stylix.autoEnable = true;
  #stylix.targets.hyprland.enable = true;
  stylix.targets.kitty.enable = true;
  stylix.targets.rofi.enable = true;

  #stylix.targets = {
  #        waybar.enableLeftBackColors = true;
  #        waybar.enableRightBackColors = true;
  #    };

}
