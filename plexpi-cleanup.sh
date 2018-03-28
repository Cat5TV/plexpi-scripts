#!/bin/bash

 # Create PlexPi Config
  systemctl stop plexmediaserver
  if [[ ! -d /etc/systemd/system/plexmediaserver.service.d ]]; then
    mkdir /etc/systemd/system/plexmediaserver.service.d
  fi
  wget -O /etc/systemd/system/plexmediaserver.service.d/override.conf https://raw.githubusercontent.com/Cat5TV/plexpi-scripts/master/conf/override.conf
  systemctl daemon-reload
  systemctl start plexmediaserver

 # Enable Firstboot Auto Resize
  if grep -q "rootwait quiet splash" /boot/cmdline.txt; then
    /bin/sed -i -- 's\rootwait quiet splash\rootwait quiet init=/usr/lib/raspi-config/init_resize.sh splash\g' /boot/cmdline.txt
  fi
  wget -qO /etc/init.d/resize2fs_once https://github.com/RPi-Distro/pi-gen/raw/dev/stage2/01-sys-tweaks/files/resize2fs_once
  chmod +x /etc/init.d/resize2fs_once
  systemctl enable resize2fs_once

 # Clearing History
  rm -rf /root/.nano
  rm -rf /home/pi/.nano

  cd /root
  rm .nano_history
  rm .bash_history

  cd /home/pi
  rm .nano_history
  rm .bash_history

halt
