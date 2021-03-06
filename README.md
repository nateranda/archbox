# Update
I have decided to archive this project and instead host my own Arch setup in the example config file of my new project [Archscript](https://www.github.com/nateranda/archscript). This repository won't be updated anymore.

# Archbox
My personal Arch setup featuring a comfy GNOME desktop and a focused Qtile desktop.

## Theme
Nord is the main theme used in both desktop environments because it looks cool and has wide support accross many different programs. Go to [nordtheme.com](https://www.nordtheme.com/) to see all supported programs.

## Design
Contrary to many power users, I feel that there is sometimes *too much* customizability — I think DEs like KDE end up bogging down their own system in pursuit of the most customizability possible. That's what gravitates me towards GNOME so much — I find myself using every major feature it offers without wanting much more out of it, and it offers just as much customizability as other DEs with its extensions and tweak apps.

## User Experience
Vanilla GNOME offers a very streamlined workflow that is fairly consistent in its design right out of the box, which is why I've chosen it as my main desktop environment. Aside from theming, extensions, and a couple setting changes, my personal GNOME install functions exactly like vanilla.

When I want a completely straightforward and distraction-free DE, I go with Qtile, mainly for its Python config file and its extensive top-bar theming. For my configuration, he main major difference is the directional keybinds — I like to use the arrow keys instead of the vim bindings. I also use mod+q to quit a window like macOS. Keybinds are easy enough to change in the `config.py` file located in `~.config/qtile`.

# Using the Scripts


# Manual Install

## Base Install
Refer to the Arch Installation Guide here: https://wiki.archlinux.org/index.php/Installation_guide

The install method changes from month to month so I'm not hard-coding it into the install script. Just pick what you like the best and go from there.

## Swapfile
Do this after arch-chroot. Create the swapfile with:

    dd if=/dev/zero of=/swapfile bs=1M count=4096 status=progress (change count based on size preference)
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    
Then, add `/swapfile none swap defaults 0 0` to the end of `/etc/fstab`.
## Bootloader

### GRUB with DOS
Install with:

    pacman -S grub
    grub-install /dev/sdX
    grub-mkconfig -o /boot/grub/grub.cfg

### GRUB with UEFI
First, install some packages and mount your EFI partition:

	pacman -S grub efibootmgr os-prober dosfstools
	mount /dev/sdXY /boot
	
Install with:

	grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

Then, enable os-prober by adding `GRUB_DISABLE_OS_PROBER=false` to the end of `/etc/default/grub`.

Finally, create the config file with:

	grub-mkconfig -o /boot/grub/grub.cfg

### rEFInd (UEFI ONLY)
I prefer installing rEFInd instead of GRUB for UEFI machines, as it offers mouse support. Install with:

	pacman -S refind
	refind-install
	
Then, delete the first two lines & replace the UUID of `/boot/refind-linux.conf`. Also  and `/boot/EFI/refind/refind.conf` with your EFI partition.

## Users & Sudo
Create a user with `sudo` perms with:

    pacman -S sudo
    useradd -m user_name
    passwd user_name
    usermod -aG wheel user_name
    visudo (uncomment %wheel line)

You're welcome to add the user to more groups as you wish. If you don't want to use vim for visudo, add `EDITOR=nano` in front of `visudo` to use nano instead.

## Other Stuff
Bluetooth:

    pacman -S bluez bluez-utils
    systemctl enable bluetooth

Wi-Fi:

    pacman -S networkmanager
    systemctl enable NetworkManager
    nmtui

Ethernet:

    pacman -S dhcpcd
    systemctl enable dhcpcd

NVIDIA Drivers:

    pacman -S nvidia nvidia-utils

Firefox:

    pacman -S firefox

## Post-Install
Reboot to make sure everything got installed fine:

    exit
    reboot

Sign into your sudoer user. Then, clone the Archbox repo with:

    cd
    mkdir Downloads
    cd Downloads
    git clone https://github.com/nateranda/archbox

Feel free to change the install location of the repo to your liking, however the scripts assume you installed the repo into the `downloads` folder.

# Running the Scripts
If you don't want to configure the system manually, most things after this can be installed by running the `install.sh` and `config.sh` files. If these scripts don't work or you want to do it the old-fashioned way, refer below to the manual guide.

Make the scripts executable with:

    chmod +x ~/Downloads/achbox/install.sh
    chmod +x ~/Downloads/achbox/config.sh

If you want to install Steam, enable the multilib repository by opening `/etc/pacman.conf` in a text editor and uncommenting the `[multilib]` line and the line below it. Then, upgrade the system with `sudo pacman -Syu` to sync the repos. If not, remove steam from the last line of `install.sh`.

Then, run the `install.sh` file with:

    . ~/Downloads/archbox/install.sh

This script updates the system and downloads Paru, GNOME, Qtile, and other miscellaneous apps. After it's done, log into both GNOME and Qtile one time to create the config directories and make sure everything works.

After that, run the `config.sh` file from either GNOME or Qtile with:

    . ~/Downloads/archbox/config.sh

This script configures GNOME, Qtile, and other apps. If there is another theme or config you want to install instead of the ones in the scripts, just change the URLs/commands associated with them.

Also, things like GNOME keybinds, Spofity and VSCode themes, and enabling extensions can't be done with the command line. Look at the last few sections of the manual configuration to make sure they work properly.

# Manual Configuration
If you aren't under a time crunch, the manual method is preferred as it's much more reliable and customizable.

## Paru
Install paru with:

    sudo pacman -S base-devel git
    cd /opt
    sudo git clone https://aur.archlinux.org/paru.git
    sudo chown -R username:username ./paru
    cd paru
    makepkg -si

Don't worry if this takes a while to build, especially on a VM.

## GNOME
Install GNOME and configuration apps with:

    sudo pacman -S gnome xorg gnome-software-packagekit-plugin gnome-shell-extensions gnome-tweaks
    systemctl start gdm

Remove unwanted GNOME default apps with:

	sudo pacman -R gnome-books gnome-contacts gnome-maps gnome-music gnome-weather simple-scan

Then, log into your user. I like to use the Xorg option, as it's more widely supported compared to the new-ish Wayland compositor.

To install extensions, install the GNOME Extensions firefox/chrome add-on. Then, enable these extensions:

    Blur My Shell
    Audio Output Switcher
    Screenshot Tool

Feel free to enable any others - some ones to consider are ArcMenu, Arch Update Indicator, and Dash to Dock.

Pop Shell isn't yet updated for GNOME 40 on the extensions website. Install the Github version instead with:

    cd ~/Downloads
    git clone https://github.com/pop-os/shell
    cd shell
    sudo pacman -S typescript
    make
    make install

If you want to, make the GNOME terminal transparent with:

    paru -S gnome-terminal-transparency

Download and enable the nord-darker theme with:

    sudo pacman -S wget
    mkdir ~/.themes
    cd ~/.themes
    wget https://github.com/EliverLara/Nordic/releases/download/v1.9.0/Nordic-darker.tar.xz
    gsettings set org.gnome.desktop.interface gtk-theme "Nordic"
    gsettings set org.gnome.desktop.wm.preferences theme "Nordic"

## Qtile
Install Qtile and essential programs with:

    sudo pacman -S xorg-xinit qtile kitty feh firefox

Then, log out of GNOME and log into Qtile. Install the Archbox Qtile config with:

    cp ~/Downloads/archbox/qtile/config.py ~/.config/qtile/config.py
    cp ~/Downloads/archbox/qtile/autostart.sh ~/.config/qtile/autostart.sh
    chmod 700 ~/.config/qtile/autostart.sh

## Misc Apps:
Welcome back, script users! Install miscellaneous apps with:

    paru -S spotify-snap timeshift
    sudo pacman -S discord vlc obs-studio neofetch wget youtube-dl steam code qbittorrent ntfs-3g fuse virtualbox

## Quality of Life
Go to keyboard in settings and set these keybinds:

    gnome-terminal: Ctrl+Alt+T and/or Meta+Enter
    nautilus: Meta+E

For some reason, there isn't a way to assign multiple keybinds to one action. As a workaround, just create multiple entries, each with a different keybind.

## Loose Ends
Enable User Themes and any other installed extensions in the Extensions app. Pop Shell might crash GNOME when toggled on for the first time, so do that last and prepare for a reboot. It'll work fine after that, though.

Enable the Nord theme by selecting nord-darker for the system and shell theme in the Appearance section of the Tweaks app.
To enable the Maximize and Minimize buttons, toggle them on in the Window Titlebars section.
Disable mouse acceleration by setting the Acceleration Profile dropdown to Flat in the Keyboard & Mouse section.
