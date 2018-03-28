#!/bin/bash

 # Enable Firstboot Auto Resize
  if grep -q "rootwait quiet splash" /boot/cmdline.txt; then
    /bin/sed -i -- 's\rootwait quiet splash\rootwait quiet init=/usr/lib/raspi-config/init_resize.sh splash\g' /boot/cmdline.txt
  fi
  wget -qO /etc/init.d/resize2fs_once https://github.com/RPi-Distro/pi-gen/raw/dev/stage2/01-sys-tweaks/files/resize2fs_once
  chmod +x /etc/init.d/resize2fs_once
  systemctl enable resize2fs_once

 # Clearing History
  rm -rf /root/.nano
  rm -rf /home/nemsadmin/.nano

  cd /root
  rm .nano_history
  rm .bash_history

  cd /home/pi
  rm .nano_history
  rm .bash_history

#halt