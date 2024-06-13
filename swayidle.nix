{ pkgs, config, lib, ...  }: {

  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    #systemdTarget = "xdg-desktop-portal-hyprland.service";
    events = [
    ];

    timeouts = [{
      timeout = 600; 
      command = "${pkgs.systemd}/bin/systemctl hibernate";
    }];
  };
}
