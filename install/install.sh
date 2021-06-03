#!/bin/bash
# Sync packages & update system
sudo pacman -Syu --noconfirm

# Install paru
sudo pacman -S base-devel --needed --noconfirm
cd /opt
sudo git clone https://aur.archlinux.org/paru.git
sudo chown -R $USER:$USER ./paru
cd paru
makepkg -si
read -p "Done installing paru - press Enter to continue"

# Install GNOME
sudo pacman -S gnome xorg gnome-software-packagekit-plugin gnome-shell-extensions gnome-tweaks wget pacman-contrib --noconfirm
sudo systemctl enable gdm
read -p "Done installing GNOME - press Enter to continue"

# Install Qtile
sudo pacman -S qtile kitty feh firefox --noconfirm
read -p "Done installing Qtile - press Enter to continue"

# Install misc programs
paru -S spotify-snap timeshift minecraft-launcher --noconfirm
sudo pacman -S discord vlc obs-studio neofetch youtube-dl code steam qbittorrent --noconfirm
read -p "Done installing misc programs - press Enter to continue"
