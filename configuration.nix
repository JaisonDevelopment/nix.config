{ config, pkgs, lib, ... }:

{
  imports = 
    [
	./flake.nix
	./hardware-configuration.nix
	./module.nix
    ];

  # systemd-boot 
  boot.loader.systemd-boot.enable = true; 
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.consoleMode = "2"; 
  
  # Borrar /tmp durante el arranque
  boot.cleanTmpDir = true; 

  # Usar el kernel más reciente 
  nixpkgs.config.packageOverrides = in_pkgs : 
    {
	linuxPackages = in_pkgs.linuxPackages_latest; 
    };

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
  programs.vim.defaultEditor = true;

  networking.hostName = "jack";
  networking.networkmanager.enable = true;


  i18n = {
    consoleKeyMap = "la-latin1";
    defaultLocale = "es_CO.UTF-8";
  };

  time.timeZone = "America/Bogota";
  services.timesyncd.enable = true;
 

  # Activar Pulseaudio
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };


  nixpkgs.config.allowUnfree = true;
  virtualisation.libvirtd.enable = true;


  fonts = {
    enableDefaultFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fontconfig.ultimate.enable = true;
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk 
      noto-fonts-emoji
      noto-fonts-extra
      fira-code 
      hack-font 
      fira-mono 
      corefonts  
      roboto-mono
      roboto 
	dejavu_fonts
    ];
  };


  environment.systemPackages = with pkgs; [
	curl
	wget
	git
	neofetch
	micro
	pavucontrol
	networkmanager
      nix-du 
      common-updater-scripts
      nixops
      nix-review
      nix-universal-prefetch	
	google-chrome
	unzip 
	zip 
	vim 
  ];

  security.sudo = {
    enable = true; 
    wheelNeedsPassword = true; 
  };

  users.user.jack = {
    isNormalUser = true; 
    uid = 1000;
    group = "wheel";
    createHome = true;
    home = "/home/jack";
  }
  
  home.stateVersion = "22.05";

}

