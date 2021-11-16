#!/bin/bash

    bash 0-preinstall.sh
    arch-chroot /mnt /root/Minim/1-setup.sh
    source /mnt/root/Minim/install.conf
    arch-chroot /mnt /usr/bin/runuser -u $username -- /home/$username/Minim/2-user.sh
    arch-chroot /mnt /root/Minim/3-post-setup.sh