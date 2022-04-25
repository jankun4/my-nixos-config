{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
      ./desktop/xserver.nix
      ./desktop/nvidia.nix
      ./desktop/64bit.nix
      ./desktop/games.nix
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
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9Ki+f7VsnlcohDCxOgvMi06KnABHymPqJZDiTmnU6H2Tp2UxMma6/wx+t9PkX6z+QkK+ReyAi8OvEJLxWmdRHHoyAVCNzxrs+yNDij7ByUdRCxKz2TCOwei3T8338nslLSIdGVgb9PshZQOcxO6Y1wPMpyPY9tTSEnWpUqv0k7bDOZXl/dW7K6bWGI1IlbM2JVW+i8YKGdQoZdRxbCW/X1DdrWT+QeoMvkhw36/RJ28DQKOirGdxtPpuWukRyFmahG5d+BX0vNY2x2JR0cwpAtFneKqo0qjAClC6N8KZt2nOUlUE/9zrmnu9ga/6IZc5nkrdKQzfIct6FCb8hAWN0o0UdlYN9PcoXgU32iW+6VLdqH7babKvGUImJqc8TvvThwpnEom3MrTXOU0tB1Ylg1fwJqDo1lgEDzwydtcLOGZv86gBpyrZ8kJ0LnfJ2I25jc+mK3nNFNTCYn4GReWSCl31AlFmxua4L7GSziJrZL9tueTWK7bRAtVJtAHOULnE= michaljankun@Michas-MacBook-Air.local" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git
    gh
    tmux
    htop
    lynx
    emacs-nox
    rnix-lsp
    silver-searcher
    tree
    ranger
    docker
    docker-compose
    oh-my-zsh
    python310
    openssl
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

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases.nsu = "NIXOS_INSTALL_BOOTLOADER=1 sudo --preserve-env=NIXOS_INSTALL_BOOTLOADER nixos-rebuild switch --upgrade";
    ohMyZsh = {
      enable = true;
      plugins = [ 
        "git" 
        "python" 
        "man"
        "ag"
        "aliases"
        "ansible"
        "sudo"
        "history"
      ];
      customPkgs = [
        pkgs.zsh-autocomplete
      ];
     theme = "awesomepanda";
    };
  };
  virtualisation.docker.enable = true;

}


