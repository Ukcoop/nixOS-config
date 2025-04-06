#!/bin/sh

sudo cp configuration.nix /etc/nixos/configuration.nix
sudo cp flatpak.nix /etc/nixos/flatpak.nix
stow .

sudo nix-channel --add https://nixos.org/channels/nixos-24.11 nixos
sudo nix-channel --update nixos
sudo nixos-generate-config

sudo nixos-rebuild switch

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
