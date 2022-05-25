{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.opengl.driSupport.enable = true;
  environment.systemPackages = with pkgs; [ vulkan-tools vulkan-loader ];
  hardware.nvidia.modesetting.enable = true;
}


