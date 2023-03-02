{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lutris
    discord
    steamcmd
    steam-tui
    (steam.override {
      extraLibraries = pkgs: with pkgs; [
        libxkbcommon
        mesa
        wayland

      ];
      extraPkgs = pkgs: with pkgs; [
        bumblebee
        glxinfo
        libgdiplus
      ];
    })
    gnome3.adwaita-icon-theme
  ];
  programs.steam.enable = true;
}


