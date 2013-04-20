#!/bin/bash

export CHROOT=/opt/ubuntu-groovy

mount --bind /dev $CHROOT/dev
mount --bind /proc $CHROOT/proc
mount --bind /sys $CHROOT/sys
mount -t devpts devpts $CHROOT/dev/pts

if [ -d /home/$(logname)/Dropbox ]; then
    mount --bind /home/$(logname)/Dropbox $CHROOT/root/Dropbox
fi

# Networking
cp /etc/resolv.conf $CHROOT/etc/resolv.conf

# Vim goodnes
if [ -d /home/$(logname)/.vim ]; then
    cp -r /home/$(logname)/.vim $CHROOT/root/.vim
fi

if [ -e /home/$(logname)/.vimrc ]; then
    cp /home/$(logname)/.vimrc $CHROOT/root/.vimrc
fi

# Allow GUI applications
xhost + > /dev/null

env HOME=/root chroot $CHROOT su -

umount $CHROOT/dev/pts
umount $CHROOT/sys
umount $CHROOT/proc
umount $CHROOT/dev

if [ -d /home/$(logname)/Dropbox ]; then
    umount $CHROOT/root/Dropbox
fi

xhost - > /dev/null
