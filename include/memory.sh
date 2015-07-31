#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://blog.linuxeye.com
#
# Notes: OneinStack for CentOS/RadHat 5+ Debian 6+ and Ubuntu 12+
#
# Project home page:
#       http://oneinstack.com
#       https://github.com/lj2007331/oneinstack

Mem=`free -m | awk '/Mem:/{print $2}'`
Swap=`free -m | awk '/Swap:/{print $2}'`

if [ $Mem -le 640 ];then
    Mem_level=512M
    Memory_limit=64
elif [ $Mem -gt 640 -a $Mem -le 1280 ];then
    Mem_level=1G
    Memory_limit=128
elif [ $Mem -gt 1280 -a $Mem -le 2500 ];then
    Mem_level=2G
    Memory_limit=192
elif [ $Mem -gt 2500 -a $Mem -le 3500 ];then
    Mem_level=3G
    Memory_limit=256
elif [ $Mem -gt 3500 -a $Mem -le 4500 ];then
    Mem_level=4G
    Memory_limit=320
elif [ $Mem -gt 4500 -a $Mem -le 8000 ];then
    Mem_level=6G
    Memory_limit=384
elif [ $Mem -gt 8000 ];then
    Mem_level=8G
    Memory_limit=448
fi

# add swapfile
if [ "$Swap" == '0' ] ;then
    if [ $Mem -le 1024 ];then
        dd if=/dev/zero of=/swapfile count=1024 bs=1M
    elif [ $Mem -gt 1024 -a $Mem -le 2048 ];then
        dd if=/dev/zero of=/swapfile count=2048 bs=1M
    fi
    mkswap /swapfile
    swapon /swapfile
    chmod 600 /swapfile
    cat >> /etc/fstab << EOF
/swapfile    swap    swap    defaults    0 0
EOF
fi