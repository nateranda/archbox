#!/bin/bash
# Install GNOME and extensions
mkdir ~/.themes
cd ~/.themes
wget https://github.com/EliverLara/Nordic/releases/download/v1.9.0/Nordic-darker.tar.xz
tar xf Nordic-darker.tar.xz
rm Nordic-darker.tar.xz
gsettings set org.gnome.desktop.interface gtk-theme "Nordic"
gsettings set org.gnome.desktop.wm.preferences theme "Nordic"
cd ~/Downloads
git clone https://github.com/pop-os/shell
cd shell
sudo pacman -S typescript --noconfirm
make
make install


# Config Qtile
paru -S nerd-fonts-anonymous-pro --noconfirm
cp ~/Downloads/archbox/qtile/config.py ~/.config/qtile/config.py
cp ~/Downloads/archbox/qtile/autostart.sh ~/.config/qtile/autostart.sh
chmod 700 ~/.config/qtile/config.py
feh --bg-fill ~/Downloads/archbox/wallpaper.jpeg
