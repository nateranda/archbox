#!/bin/bash
# PERSONAL ARCH INSTALL SCRIPT
# REMEMBER TO CHECK THIS SHIT IN CASE IT'S NOT UPDATED
# I AM ONE PERSON AND THERE WILL BE OVERSIGHTS IN THIS

# Sync packages & update system
sudo pacman -Syu

# Install spice-vdagent

# Install paru
echo "Installing Paru..."
read -p "Enter User:" user
sudo pacman -S base-devel git
cd /opt
sudo git clone https://aur.archlinux.org/paru.git
sudo chown -R $user:$user ./yay
cd yay
makepkg -si

# Install GNOME
echo "Installing GNOME..."
sudo pacman -S gnome xorg gnome-software-packagekit-plugin
# Commented by default just in case
# sudo systemctl enable gdm

# Install Qtile
echo "Installing Qtile..."
sudo pacman -S qtile kitty
