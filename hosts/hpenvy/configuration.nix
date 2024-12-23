# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];


  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;

  # keep only the last 10 generations
   boot.loader.grub.configurationLimit = 10;
  nix.gc.automatic = true;

  # graphics
  hardware.graphics = {
	enable = true;
	enable32Bit = true;
  };
#  services.xserver.videoDrivers = ["nvidia"];
#  hardware.nvidia = {
#	modesetting.enable = true;
#	powerManagement.enable = false;
#	powerManagement.finegrained = false;
#	open = false;
#	nvidiaSettings = true;
#	package = config.boot.kernelPackages.nvidiaPackages.stable;
#  };

  networking.hostName = "nixos-hpenvy"; # Define your hostname.
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # dual boot system time
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Enable KDE Plasma
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # services.avahi = {
  #   enable = true;
  #   nssmdns = true;
  #   openFirewall = true;
  # };

  hardware.pulseaudio.enable = false;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.syncthing = {
	  enable = true;
	  user = "aman";
	  dataDir = "/home/aman/syncthing";
	  configDir = "/home/aman/.config/syncthing";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aman = {
    isNormalUser = true;
    description = "aman";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  nix.settings.trusted-users = [ "aman" ];
  # home manager
  home-manager = {
	extraSpecialArgs = {inherit inputs; }; # pass inputs from flake.nix to module
	users = {
	  "aman" = import ./home.nix;
	};
  };

  # set zsh as default shell for all users
  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  xclip
  git
  htop
  vim
  neovim
  zsh
  meslo-lgs-nf
  timeshift
  distrobox
  gparted
  pciutils
  gcc
  qemu
  quickemu
  # for redirecting usb using spice-gtk when using quickemu
  spice-gtk
  ];

# for redirecting usb using spice-gtk when using quickemu
virtualisation.spiceUSBRedirection.enable = true;

# virtmanager
virtualisation.libvirtd.enable = true;
programs.virt-manager.enable = true;

  # enable kde connect
  programs.kdeconnect.enable = true;

  # enable zsh system wide
  programs.zsh.enable = true;

  # configure zsh
  programs.zsh = {
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      nixbuild = "sudo nixos-rebuild switch --flake ~/nixos#default";
      cdnix = "cd ~/nixos";
      nixman = "man configuration.nix";
      homemanager-man = "man home-configuration.nix";
    };
    ohMyZsh = {
	enable = true;
	plugins = [ "git" "sudo" "docker" ];
    };
  };

  # tailscale
  services.tailscale.enable = true;

  # flatpak
  services.flatpak.enable = true;

# enable docker
virtualisation.docker.enable = true;
virtualisation.docker.enableNvidia = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
