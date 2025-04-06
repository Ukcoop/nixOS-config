{ config, pkgs, ... }:

let
  # Define the Flatpak applications you want to manage
  desiredFlatpaks = [
    "app.zen_browser.zen"
    # Add other Flatpak IDs as needed
  ];
in
{
  # Define a system activation script to manage Flatpak applications
  system.activationScripts.flatpakManagement = {
    text = ''
      # Ensure the Flathub repository is added
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub \
        https://flathub.org/repo/flathub.flatpakrepo

      # Get a list of currently installed Flatpak applications
      installedFlatpaks=$(${pkgs.flatpak}/bin/flatpak list --app --columns=application)

      # Remove any Flatpaks not in the desired list
      for installed in $installedFlatpaks; do
        if ! echo ${toString desiredFlatpaks} | grep -q $installed; then
          echo "Removing $installed because it's not in the desiredFlatpaks list."
          ${pkgs.flatpak}/bin/flatpak uninstall -y --noninteractive $installed
        fi
      done

      # Install or re-install the desired Flatpaks
      for app in ${toString desiredFlatpaks}; do
        echo "Ensuring $app is installed."
        ${pkgs.flatpak}/bin/flatpak install -y flathub $app
      done

      # Update all installed Flatpaks
      ${pkgs.flatpak}/bin/flatpak update -y
    '';
  };
}
