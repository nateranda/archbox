# Install paru
cd /opt
sudo git clone https://aur.archlinux.org/paru.git
sudo chown -R nater:nater paru
cd paru
makepkg -si

# Install chrome-gnome-shell for gnome extension support, nordic-darker theme, and gnome terminal transparency
# Using the extensions app is far better than doing it the command-line way so let's just roll with it
paru -S chrome-gnome-shell nordic-darker-theme gnome-terminal-transparency --noconfirm

# Install nord gnome terminal theme
cd /Downloads
git clone https://github.com/arcticicestudio/nord-gnome-terminal.git
cd nord-gnome-terminal/src
./nord.sh