#!/bin/bash
# PERSONAL ARCH INSTALL SCRIPT
# REMEMBER TO CHECK THIS SHIT IN CASE IT'S NOT UPDATED
# I AM ONE PERSON AND THERE WILL BE OVERSIGHTS IN THIS

# Sync packages & update system
sudo pacman -Syu --noconfirm

# Install paru
sudo pacman -S base-devel git --noconfirm
cd /opt
sudo git clone https://aur.archlinux.org/paru.git
sudo chown -R $USER:$USER ./paru
cd paru
makepkg -si

# Install GNOME
sudo pacman -S gnome xorg gnome-software-packagekit-plugin gnome-shell-extensions gnome-tweaks wget pacman-contrib --noconfirm
sudo systemctl enable gdm
# Install theme and extensions
paru -S gnome-shell-extension-blur-my-shell-git gnome-shell-extension-audio-output-switcher-git gnome-shell-extension-arc-menu-git gnome-shell-extension-arch-update gnome-shell-extension-screenshot-git gnome-terminal-transparency --noconfirm
mkdir ~/.themes
cd ~/.themes
wget https://github.com/EliverLara/Nordic/releases/download/v1.9.0/Nordic-darker.tar.xz
tar xf Nordic-darker.tar.xz
rm Nordic-darker.tar.xz
gsettings set org.gnome.desktop.interface gtk-theme "Nordic"
gsettings set org.gnome.desktop.wm.preferences theme "Nordic"
echo "Done installing gnome" read _

# Install Qtile
sudo pacman -S qtile kitty firefox -noconfirm
cp ~/Downloads/archbox/qtile/config.py ~/.config/qtile/config.py
cp ~/Downloads/archbox/qtile/autostart.py ~/.config/qtile/autostart.py
chmod 700 ~/.config/qtile/config.py
echo "Done installing qtile" read _

# Install Spotify & Spicetify
paru -S spotify-snap spicetify-cli-git --noconfirm
sudo chmod a+wr /usr/share/spotify
sudo chmod a+wr /usr/share/spotify/Apps -R
spicetify
spicetify backup apply enable-devtool
cd ~/Downloads
git clone https://github.com/morpheusthewhite/spicetify-themes
cp -r ~/Downloads/spicetify-themes/Nord ~/spicetify-cli/Themes/
echo "Done installing spotify" read _

sudo pacman -S discord --noconfirm
