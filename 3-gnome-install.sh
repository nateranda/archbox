# Install GNOME and GNOME tools
pacman -S gnome xorg gnome-software-packagekit-plugin gnome-shell-extensions gnome-tweaks --noconfirm --needed

# Remove GNOME apps I don't use
pacman -R gnome-books gnome-contacts gnome-maps gnome-music gnome-weather simple-scan --noconfirm

# Install chrome-gnome-shell for gnome extension support, nordic-darker theme, and gnome terminal transparency
# IMO using the extensions app is far better than doing it the command-line way so let's just roll with it
paru -S chrome-gnome-shell nordic-darker-theme gnome-terminal-transparency --noconfirm

# Install nord gnome terminal theme
cd ~/Downloads
git clone https://github.com/arcticicestudio/nord-gnome-terminal.git
cd nord-gnome-terminal/src
./nord.sh