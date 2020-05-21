#!/bin/bash
#updates
apt-get update
apt-get -y upgrade
#dist-upgrade still involves interactions for kernel-updates...
#apt-get -y dist-upgrade
apt-get -y autoremove

#mount
mkdir /mnt/data
mount -o discard,defaults,noatime /dev/disk/by-id/scsi-0DO_Volume_teedy-volume /mnt/data
echo '/dev/disk/by-id/scsi-0DO_Volume_teedy-volume /mnt/data ext4 defaults,nofail,discard 0 0' | tee -a /etc/fstab

#docker
ufw delete allow 2375/tcp
ufw delete allow 2376/tcp
docker-compose -f /root/docker-compose.yml up -d

#nginx
add-apt-repository ppa:certbot/certbot -y
apt-get -y install nginx python-certbot-nginx
ufw allow 'Nginx Full'
rm /etc/nginx/sites-enabled/default
mv nginx.conf /etc/nginx/sites-available/ngergs.de
rm -r /etc/letsencrypt/
ln -s /mnt/data/letsencrypt/ /etc/
ln -s /etc/nginx/sites-available/ngergs.de /etc/nginx/sites-enabled/
systemctl enable nginx
systemctl start nginx
