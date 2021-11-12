echo "Set root password"
passwd

# make swapfile
dd if=/dev/zero of=/swapfile bs=1M count=2048 status=progress (change count based on size preference)
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile none swap defaults 0 0" >> /etc/fstab

# Set up timezone
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc

# Set up locale
sed --in-place=.bak 's/^#en_US\.UTF-8/en_US\.UTF-8/' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf

# Set hostname
read -r -p "Hostname: " hostname
echo $hostname > /etc/hostname

# Install other essential packages
pacman -S sudo dhcpcd networkmanager base-devel git --noconfirm --needed

# Create user
read -r -p "Username: " username
useradd -m $username
passwd $username
usermod -aG wheel,audio,video $username
echo "Uncomment %wheel line in vim."
sleep 3
visudo

read -r -p "Bootloader Disk? (usually the same as your install disk): " disk
read -r -p "What bootloader? [G]RUB, GRUB [U]EFI, or [R]EFIND: " bootloader
if [ $bootloader == "G" ];
then
pacman -S grub --noconfirm
grub-install $disk
grub-mkconfig -o /boot/grub/grub.cfg

elif [ $bootloader == "U" ];
then
pacman -S grub efibootmgr os-prober dosfstools --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
fi