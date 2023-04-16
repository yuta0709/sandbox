#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

#Downloading ISO file
wget https://s3-us.vyos.io/rolling/current/vyos-1.4-rolling-202304120317-amd64.iso

TMP_MNT=/tmp/vyos-rootfs
UNSQUASHFS_DIR=/tmp/vyos-unsquashfs
sudo umount ${TMP_MNT}
rm -r ${TMP_MNT}

# Mounting VyOS ISO image
mkdir ${TMP_MNT}
sudo mount -o loop ./vyos-1.4-rolling-202304120317-amd64.iso ${TMP_MNT}

# Unpacking filesystem
sudo apt-get install -y squashfs-tools
mkdir ${UNSQUASHFS_DIR}
sudo unsquashfs -f -d ${UNSQUASHFS_DIR} ${TMP_MNT}/live/filesystem.squashfs

# Creating Docker image
sudo tar -C ${UNSQUASHFS_DIR} -c . | sudo docker import - manabuhirano/vyos:1.4

# Clean
sudo umount /tmp/vyos-rootfs
sudo rm -rf /tmp/vyos-rootfs
sudo rm -rf /tmp/vyos-unsquashfs

