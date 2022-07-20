export DISTRIBUTIONS="base.txz kernel.txz ports.txz src.txz"
# export BSDINSTALL_DISTDIR="/media"
for d in ada0 da0 vtbd0; do
  if [ -e "/dev/$d" ]; then
    export ZFSBOOT_DISKS=$d
    break
  fi
done
unset d

export nonInteractive="YES"

#!/bin/sh

cat > /etc/rc.conf << EOL
zfs_enable="YES"
dumpdev="NO"
sshd_enable="YES"
hostname="freebsd"
sendmail_enable="NONE"
syslogd_flags="-ss"
clear_tmp_enable="YES"

hald_enable="YES"
moused_enable="YES"
dbus_enable="YES"
vmware_guest_vmblock_enable="YES"
vmware_guest_vmmemctl_enable="YES"
vmware_guest_vmxnet_enable="YES"
vmware_guestd_enable="YES"
EOL

interface="`ifconfig -l | cut -d' ' -f1`"
sysrc ifconfig_$interface="SYNCDHCP"

cat > /boot/loader.conf << EOL
kern.geom.label.disk_ident.enable="0"
kern.geom.label.gptid.enable="0"
opensolaris_load="YES"
zfs_load="YES"
autoboot_delay="2"
if_vmx_load="YES"
# pvscsi_load="YES"
ums_load="YES"
EOL

echo 'WITHOUT_X11="YES"' >> /etc/make.conf
echo 'nameserver 192.168.0.1' >> /etc/resolv.conf

# Create Packer User
echo "West@7Street" | pw useradd packer -h 0 -G wheel -m
echo "West@7Street" | pw usermod root -h 0

# Package Management
fetch http://pkg.FreeBSD.org/FreeBSD:11:amd64/quarterly/Latest/pkg.txz
fetch http://pkg.FreeBSD.org/FreeBSD:11:amd64/quarterly/Latest/pkg.txz.sig
pkg add pkg.txz
pkg update

pkg install -y nano sudo curl open-vm-tools-nox11

# SSHD
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Sudoers
mkdir -p /usr/local/etc/sudoers.d
cat <<EOS > /usr/local/etc/sudoers.d/packer
Defaults:packer !requiretty
packer ALL=(ALL) NOPASSWD: ALL
EOS
chmod 440 /usr/local/etc/sudoers.d/packer

# Update FreeBSD
env PAGER=/bin/cat /usr/sbin/freebsd-update --not-running-from-cron fetch install

reboot