{ pkgs, stylix, ... }:
{

  imports = [
    stylix.homeManagerModules.stylix
    #stylix.nixosModules.stylix
  ];

  # Stylix
  stylix.image = /home/kiwi/Downloads/wall.png;

}
