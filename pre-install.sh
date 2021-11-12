timedatectl set-ntp true
pacstrap /mnt base linux linux-firmware vim
genfstab -U /mnt >> /mnt/etc/fstab
cp base-install.sh /mnt/base-install.sh