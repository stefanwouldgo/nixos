# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

   networking.hostName = "nixos"; # Define your hostname.
   networking.interfaces.eth0 = { ipAddress = "85.25.200.172"; prefixLength = 26; };
   networking.defaultGateway  = "85.25.200.129";
     networking.nameservers     = [ "85.25.128.10" "85.25.255.10" ];
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  services.postgresql.enable = true;
  services.postgresql.package = pkgs.postgresql94;
  
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ]; # for postgres

  nix.gc.automatic = true;
  nix.gc.dates = "03:15";

  environment.systemPackages = [
  pkgs.emacs
  pkgs.bitcoind
  pkgs.emacs-nox
  pkgs.git
  pkgs.htop
  pkgs.iotop
  pkgs.nix
  pkgs.sbt
  pkgs.tmux
  ] ;
  
  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
   time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = with pkgs; [
  #   wget
  # ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;


  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };

  security.sudo.wheelNeedsPassword = false;

  users.extraUsers.youruser =
      { createHome      = true;
            home            = "/home/youruser";
	          description     = "your name";
		        extraGroups     = [ "wheel" ];
			      useDefaultShell = true;
			            openssh.authorizedKeys.keys = [
				            "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCiAlE0jX4sWsQTaCn6XFCLkafAnfrEOkzRCyysM/j+QFwdsc2tBaTHIoiy32jV+WmUrpTxytwDzr9IxO5ncP3nFZklDxBwF/Edt6GFn8YuTPfyvYEqbTgeuSGlpceT3MYiyLnOJvtzEdJoBkiHCWgRaDriMCTRXrHT91YehEO/sYCY+EIUAQe2VlyKQY3Owt26fWRMvPzf8oSBA/YKvxQ3ORo3X8ZZ9AsFNqm3OR0FeSz0ADvi7rZr4us+H9yuIbFZnwj3mOUnrWhNL3sDi1PD7DePlJyqjXMc1I6DJdYbssV2UZGz4rcVnp6vOIAL/NBo5QuqVdZYICeVeCbSR55 yzark@yzark-Aspire-5750G"
					          ];
						      };
  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

}