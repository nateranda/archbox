# make swapfile
read -r -p "Swapfile Size (in megabytes): " swapsize
dd if=/dev/zero of=/swapfile bs=1M count=$swapsize status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile none swap defaults 0 0" >> /etc/fstab

# Set up timezone (CHANGE TO PREFERRED TIMEZONE)
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc

# Set up locale (CHANGE TO PREFERRED LOCALE)
sed --in-place=.bak 's/^#en_US\.UTF-8/en_US\.UTF-8/' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf

# Set hostname
read -r -p "Hostname: " hostname
echo $hostname > /etc/hostname

# Install other essential packages
pacman -S sudo dhcpcd networkmanager base-devel git unzip --noconfirm --needed

# Enable necessary processes
systemctl enable dhcpcd
systemctl enable NetworkManager
systemctl enable bluetooth

# Set root password
echo "Set root password"
passwd

# Create user
read -r -p "Username: " username
useradd -m $username
passwd $username
usermod -aG wheel,audio,video $username
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

# Determine processor type and install microcode
proc_type=$(lscpu | awk '/Vendor ID:/ {print $3}')
case "$proc_type" in
	GenuineIntel)
		print "Installing Intel microcode"
		pacman -S --noconfirm intel-ucode
		;;
	AuthenticAMD)
		print "Installing AMD microcode"
		pacman -S --noconfirm amd-ucode
		;;
esac	

# Install bootloader
read -r -p "Bootloader Disk? (usually the same as your install disk eg. /dev/sda): " disk

if [ -e /sys/firmware/efi ]; then
pacman -S grub efibootmgr os-prober dosfstools --noconfirm
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

else
pacman -S grub --noconfirm
grub-install $disk
grub-mkconfig -o /boot/grub/grub.cfg
fi