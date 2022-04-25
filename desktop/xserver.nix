{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.layout = "pl";
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
    gnomeExtensions.appindicator
  ];

  services.udev.packages = with pkgs; [
    gnome3.gnome-settings-daemon
  ];

  hardware.opengl.enable = true;
}


