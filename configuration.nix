{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
      ./desktop/configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "pl_PL.UTF-8";

  users.mutableUsers = false;
  users.users.jankun = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" "docker"]; # Enable ‘sudo’ for the user.
    hashedPassword = "$6$KrwiYyPQDQC63BTb$I1kkwVvmDsT.yRqkMLR20i6GYdKAql0qFcrNGcGOmHlI7zU9iZdF21pDRw6CHS1V8w37IdrNf7pGO7.ooJ6rA.";
  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git
    gh
    tmux
    lynx
    emacs-nox
    rnix-lsp
    silver-searcher
    tree
    ranger
    docker
    docker-compose
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  system.stateVersion = "22.05"; # Did you read the comment?

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    useSandbox = false;
  };
  
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.checkJournalingFS = false;
  
  programs.bash.shellAliases = {
    nsu = "NIXOS_INSTALL_BOOTLOADER=1 sudo --preserve-env=NIXOS_INSTALL_BOOTLOADER nixos-rebuild switch --upgrade";
  };
  services.postgresql.enable = true;
  services.postgresql.package = pkgs.postgresql_11;
  
  environment.sessionVariables = {
    EDITOR = "vim";
  };
  home-manager.users.jankun = {
    programs.vim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [vim-elixir vim-nix];
    };
  };

  virtualisation.docker.enable = true;
}


