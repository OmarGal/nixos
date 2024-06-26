# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs,  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./stylix.nix
    ];

  # AMD
  #boot.initrd.kernelModules = [ "amdgpu" ];
  #hardware.opengl.extraPackages = with pkgs; [
  #  rocmPackages.clr.icd
  #];
  #hardware.opengl.driSupport = true; # This is already enabled by default
  #hardware.opengl.driSupport32Bit = true; # For 32 bit applications

  # Hyprland
  #programs.hyprland = {
  #  enable = true;
  #  enableNvidiaPatches = true;
  #  xwayland.enable = true;
  #};
  environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    #  Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  # Unfree software
  nixpkgs.config.allowUnfree = true;

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  boot.loader = {
   efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
   };
   grub = {
     efiSupport = true;
     #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
     device = "nodev";
   };
  };

  # Resume
  security.protectKernelImage = false;
  boot.resumeDevice = "/dev/nvme0n1p4";
  boot.kernelParams = [ "resume_offset=16189440" ];

  # Swap file
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 10*1024;
  }];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Static ip address
  networking.interfaces.enp9s0.wakeOnLan.enable = true;
  networking.interfaces.enp9s0.ipv4.addresses = [ {
    address = "192.168.1.10";
    prefixLength = 24;
  } ];
  networking.useDHCP = lib.mkForce false;
  networking.dhcpcd.wait = "if-carrier-up";
  systemd.network.networks.enp9s0.DHCP = "no";
  networking.interfaces.enp9s0.useDHCP = false;
  networking.defaultGateway = "192.168.1.254";
  networking.nameservers = [ "1.1.1.1" ];

  # Bluetooth
  hardware.bluetooth.enable = true; 
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "America/Mexico_City";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Sound
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kiwi = {
    isNormalUser = true;
    description = "kiwi";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "kiwi";

  # Fonts
  fonts.packages = with pkgs; [
    font-awesome
    (nerdfonts.override { fonts = [
      "RobotoMono"
    ];})
  ];

  #services.xserver.enable = true;
  # SDDM
  #services.xserver.displayManager.sddm.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim    
    #kitty
    firefox
  ];

  # kde connect
  #programs.kdeconnect.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
