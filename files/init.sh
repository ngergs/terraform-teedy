#!/bin/bash
mkdir /mnt/data
mount -o discard,defaults,noatime /dev/disk/by-id/scsi-0DO_Volume_teedy-volume /mnt/data
echo '/dev/disk/by-id/scsi-0DO_Volume_teedy-volume /mnt/data ext4 defaults,nofail,discard 0 0' | tee -a /etc/fstab
docker-compose -f /root/docker-compose.yml up -d
