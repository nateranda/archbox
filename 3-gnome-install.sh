# Install GNOME and GNOME tools
pacman -S gnome xorg gnome-software-packagekit-plugin gnome-shell-extensions gnome-tweaks --noconfirm --needed

# Remove GNOME apps I don't use
pacman -R gnome-books gnome-contacts gnome-maps gnome-music gnome-weather simple-scan --noconfirm