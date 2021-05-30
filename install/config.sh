#!/bin/bash
# Install GNOME and extensions
paru -S gnome-shell-extension-blur-my-shell-git gnome-shell-extension-audio-output-switcher-git gnome-shell-extension-arc-menu-git gnome-shell-extension-arch-update gnome-shell-extension-screenshot-git gnome-terminal-transparency --noconfirm
mkdir ~/.themes
cd ~/.themes
wget https://github.com/EliverLara/Nordic/releases/download/v1.9.0/Nordic-darker.tar.xz
tar xf Nordic-darker.tar.xz
rm Nordic-darker.tar.xz
gsettings set org.gnome.desktop.interface gtk-theme "Nordic"
gsettings set org.gnome.desktop.wm.preferences theme "Nordic"

# Config Qtile
paru -S nerd-fonts-anonymous-pro --noconfirm
cp ~/Downloads/archbox/qtile/config.py ~/.config/qtile/config.py
cp ~/Downloads/archbox/qtile/autostart.py ~/.config/qtile/autostart.py
chmod 700 ~/.config/qtile/config.py