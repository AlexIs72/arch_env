#!/bin/sh

INSTALL_DEV=/dev/sda
USER_NAME=user
USER_PASSWORD=123321
ROOT_PASSWORD=123321

PART_TYPE=gpt
BOOT_PART_SIZE=100M
BOOT_PART_LABEL=EFI
ROOT_PART_SIZE="100%"
ROOT_PART_LABEL="ArchLinux"

TIMEZONE="Novosiborsk"
HOSTNAME="archlinux-host"

USE_EFI=0

if [ -d /sys/firmware/efi ]; then
    USE_EFI=1
fi

#-----------------------
# TODO
# - script's arguments
# - init wifi if need


#-----------------------
# Remove old partitions

/usr/bin/parted -s ${INSTALL_DEV} \
	rm 2 \
	rm 1 \
	print \
	quit

#-----------------------
# Create partitions

/usr/bin/parted -s ${INSTALL_DEV} \
	mklabel ${PART_TYPE} \
	mkpart EFI fat32 0% ${BOOT_PART_SIZE} \
	set 1 esp on \
	mkpart root_fs ext4 ${BOOT_PART_SIZE} ${ROOT_PART_SIZE} \
	align-check optimal 1 \
	align-check optimal 2 \
	print \
	quit

#-----------------------
# Format partitions

/usr/bin/mkfs.vfat -n EFI -F 32	 ${INSTALL_DEV}1
/usr/bin/mkfs.ext4 -F -L root_fs ${INSTALL_DEV}2

#-----------------------
# Mount partitions

mount ${INSTALL_DEV}2 /mnt
mkdir -p /mnt/boot
mount ${INSTALL_DEV}1 /mnt/boot

#-----------------------
# Fix mirror's list 
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old
reflector -c Russia > /etc/pacman.d/mirrorlist

#-----------------------
# Base install

/usr/bin/pacstrap -i /mnt \
    base \
    linux \
    linux-firmware \
    efibootmgr \
    vim \
    sudo \
    dhcpcd \
    openssh \
    intel-ucode

#-----------------------
# Tune

genfstab -U /mnt >> /mnt/etc/fstab

#-----------------------
# Chroot actions script

rootfs_uuid=$(blkid ${INSTALL_DEV}2 | cut -d' ' -f3)

cat << EOF > /mnt/chroot_actions.sh
#!/bin/sh

#-----------------------
# Manage users

#echo ${ROOT_PASSWORD} | passwd --stdin root
echo root:${ROOT_PASSWORD} | chpasswd
#groupadd ${USER_NAME}
#useradd -d /home/${USER_NAME} -g ${USER_NAME} -s /bin/bash ${USER_NAME}
useradd -m ${USER_NAME}
#echo ${USER_PASSWORD} | passwd --stdin ${USER_NAME}
echo ${USER_NAME}:${USER_PASSWORD} | chpasswd

bootctl install

cat << BL_EF > /boot/loader/loader.conf
default arch
timeout 5
editor 1
BL_EF

cat << BLE_EF > /boot/loader/entries/arch.conf
title ArchLinux
linux /vmlinuz-linux
initrd /intel-ucode.img
initrd /initramfs-linux.img
options root=${rootfs_uuid} rw
BLE_EF

systemctl enable dhcpcd
systemctl enable sshd

ln -s /usr/share/zoneinfo/Asia/${TIMEZONE} /etc/localtime

echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "${HOSTNAME}" > /etc/hostname

cat << HOSTS_EF > /etc/hosts
127.0.0.1	localhost
::1		localhost
127.0.1.1	${HOSTNAME}.localdomain ${HOSTNAME}
HOSTS_EF

cat << SUDO_EF > /etc/sudoers.d/${USER_NAME}
${USER_NAME} ALL=(ALL) ALL
SUDO_EF

#hwclock --systohc --localtime

exit

EOF

chmod +x /mnt/chroot_actions.sh


#-----------------------
# Chroot

arch-chroot /mnt /chroot_actions.sh

umount -R /mnt


