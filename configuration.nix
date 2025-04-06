{ config, pkgs, ... }:

{
  imports =
    [
      # i needed to create a cuctom hardware config, if you have issues with waydroid file systems, you will know.
      ./custom-hc.nix
      ./flatpak.nix
    ];

# Bootloader configuration.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Uncomment to enable wireless support.

  # Network proxy configuration (if needed)
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;

  # Time zone and locale settings.
  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # X11 window system and GNOME desktop.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb = { layout = "us"; variant = ""; };

  # Printing service.
  services.printing.enable = true;

  # Sound configuration with Pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Uncomment to enable JACK applications.
    # jack.enable = true;
  };

  # User account setup.
  users.users.coop = {
    isNormalUser = true;
    description = "Alexander Cooper";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Enable Neovim.
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Enable Flatpak.
  services.flatpak.enable = true;

  # Enable Hyprland.
  programs.hyprland.enable = true;

  # Enable Zsh and set it as the default user shell.
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Enable docker
  virtualisation.docker.enable = true;

  # Enable waydroid
  virtualisation.waydroid.enable = true;

  # System packages.
  environment.systemPackages = with pkgs; [
    wl-clipboard
    xclip
    git
    gh
    rustup
    nodejs_22
    zip
    unzip
    gcc
    gnumake
    autoconf
    automake
    libtool
    lld
    openssl
    tmux
    stow
    kitty
    oh-my-posh
    lazygit
    fzf
    zoxide
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    neofetch
    hyprpaper
    hypridle
    hyprlock
    hyprshot
    nautilus
    waybar
    wofi
    lxappearance
    swaynotificationcenter
    kanata
  ];

  services.kanata = {
    enable = true;
    package = pkgs.kanata;
    keyboards = {
      laptop = {
        devices = ["/dev/input/by-path/pci-0000:00:14.0-usb-0:1:1.0-event-kbd"];
	extraDefCfg = "process-unmapped-keys yes";
        config = builtins.readFile /home/coop/.config/kanata/config.kbd;
      };
    };
  };

  systemd.services.game_monitor = {
    enable = true;
    path = with pkgs; [ coreutils procps gnugrep systemd ];
    serviceConfig = {
      Restart = "always";
      RestartSec = 3;
      ExecStart = "/home/coop/scripts/game_monitor.sh";
    };
    wantedBy = [ "multi-user.target" ];
  };

  # OpenSSH daemon (disabled by default).
  # services.openssh.enable = true;

  # Firewall configuration (customize as needed).
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  # System state version.
  system.stateVersion = "24.11"; # Keep this set to your initial release version.
}
