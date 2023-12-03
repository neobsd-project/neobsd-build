neobsd-build
==============
Live media creator for NeoBSD distribution

## Introduction
The purpose of this tool is quickly generate live images for NeoBSD.

## Features
* Build NeoBSD from packages
* Mate desktop environment
* Xfce desktop environment
* Gnome deskop environment
* Hybrid DVD/USB image

## Graphics support
* Compatible with VirtualBox, VMware, NVIDIA graphics out of box
* SCFB support with automatic best resolution for UEFI enabled systems with Intel/AMD graphics

## System requirements
* Latest version of NeoBSD 
* 20GB of free disk space
* 4GB of free memory

## Initial setup
Install the required packages:
```
pkg install git transmission-cli rsync
```
Make sure to have linux64 kernel module loaded
```
kldload linux64
sysrc -f /etc/rc.conf kld_list="linux64"
```
Clone the repo:
```
git clone https://www.github.com/neobsd/neobsd-build.git
```
## Starting a build
#### Enter the directory for running the LiveCD build script:
```
cd neobsd-build
```

#### To build a NeoBSD with __MATE__ as default desktop
```
./build.sh -d mate -b unstable
```
or
```
./build.sh -d mate -b release
```

#### (Option) To build NeoBSD with __XFCE__ as default desktop
```
./build.sh -d xfce -b unstable
```   

## Burn an image to cd:
```
cdrecord /usr/local/neobsd-build/iso/NeoBSD.iso
```

## Write an image to usb stick:
```
dd if=/usr/local/neobsd-build/iso/NeoBSD.iso of=/dev/da0 bs=4m
```
