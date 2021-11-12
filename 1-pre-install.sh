timedatectl set-ntp true
pacstrap /mnt base linux linux-firmware vim
genfstab -U /mnt >> /mnt/etc/fstab
cp 2-base-install.sh /mnt/2-base-install.sh