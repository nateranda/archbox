bash 1-pre-install.sh
chmod +x /mnt/2-base-install.sh
arch-chroot /mnt /2-base-install.sh
rm /mnt/2-base-install.sh