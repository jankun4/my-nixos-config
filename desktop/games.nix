{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lutris
    discord
    steam
  ];
}


