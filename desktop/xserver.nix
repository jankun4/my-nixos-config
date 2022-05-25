{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true; 
  services.xserver.displayManager.defaultSession = "gnome";
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "jankun";
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.layout = "pl";
  services.xserver.libinput.enable = true;
  
  #services.xrdp.enable = true;
  #services.xrdp.defaultWindowManager = "gnome-wayland";
  # networking.firewall.allowedTCPPorts = [ 3389 ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
    gnomeExtensions.appindicator
    gnome.gnome-remote-desktop
  ];

  services.udev.packages = with pkgs; [
    gnome3.gnome-settings-daemon
    gnome3.adwaita-icon-theme
    gnome.zenity
  ];

  hardware.opengl.enable = true;

}


