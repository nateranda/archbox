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
arch-chroot /mnt /3-gnome-install.sh