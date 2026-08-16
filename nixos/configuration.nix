{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # System
  networking.hostName = "nixos";
  networking.networkmanager.enable = false;
  networking.wireless.iwd.enable = true;

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Keyboard
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # User
  users.users.dibyanshu = {
    isNormalUser = true;
    description = "Dibyanshu Moura";
    extraGroups = [ "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Dconf / GTK
  programs.dconf.enable = true;

  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/desktop/interface" = {
          font-name = "Iosevka 11";
          document-font-name = "Iosevka 13";
          monospace-font-name = "Iosevka 13";
          color-scheme = "prefer-dark";
          gtk-theme = "Adwaita";
        };
      };
    }
  ];

  environment.pathsToLink = [
    "/share/gsettings-schemas"
  ];

  environment.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
  };

  # Applications
  environment.systemPackages = with pkgs; [
    swaybg
    vim
    wget
    git
    kitty
    waybar
    brightnessctl
    bluetui
    wiremix
    impala
    adwaita-icon-theme
    fuzzel
    gsettings-desktop-schemas
  ];

  # Fonts
  fonts.packages = with pkgs; [
    iosevka
  ];

  # Firefox
  programs.firefox.enable = true;

  # XDG Desktop Portals
  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];

    config = {
      common.default = "gtk";

      hyprland = {
        default = [ "gtk" ];
      };
    };
  };

  # Power management
  services.power-profiles-daemon.enable = true;

  # Graphics
  hardware.graphics.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;

  # NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  system.stateVersion = "26.05";
}
