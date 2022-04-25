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
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
    gnomeExtensions.appindicator
    gnome.gnome-tweaks
    plotinus
  ];

  services.udev.packages = with pkgs; [
    gnome3.gnome-settings-daemon
    gnome3.adwaita-icon-theme
    gnome.zenity
  ];

  hardware.opengl.enable = true;


  home-manager.users.jankun.gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
  };
  programs.plotinus.enable = true;
}


