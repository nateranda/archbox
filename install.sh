# Pre-install
bash 1-pre-install.sh

# Base install
cp 2-base-install.sh /mnt/2-base-install.sh
chmod +x /mnt/2-base-install.sh
arch-chroot /mnt /2-base-install.sh
rm /mnt/2-base-install.sh

# Gnome install
cp 3-gnome-install.sh /mnt/3-gnome-install.sh
chmod +x /mnt/3-gnome-install.sh
arch-chroot /mnt/3-gnome-install.sh
rm /mnt/3-gnome-install.sh

# Misc Install
cp 4-misc-install.sh /mnt/4-misc-install.sh
chmod +x /mnt/4-misc-install.sh
source /mnt/root/ArchTitus/install.conf
arch-chroot /mnt /usr/bin/runuser -u $username -- /home/$username/ArchTitus/2-user.sh