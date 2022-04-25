#!/bin/bash
#Copyright (C) 2022 Dimitris Tzemos <dijemos@gmail.com>
#This program is free software: you can redistribute it and/or modify it under the terms 
#of the GNU General Public License as published by the Free Software Foundation, 
#either version 2 of the License, or (at your option) any later version.
#This program is distributed in the hope that it will be useful, 
#but WITHOUT ANY WARRANTY; without even the implied warranty 
#of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#See the GNU General Public License at <http://www.gnu.org/licenses/> for more details.

        flagf=$1
        flagd=$2
        flagw=$3
	    
	    if [ -z "$flagf" ]; then
			export flagf="ext4"
	    elif [ "$flagf" = "ext2" ]; then
			export flagf="ext2"
		elif [ "$flagf" = "ext3" ]; then
			export flagf="ext3"
		elif [ "$flagf" = "ext4" ]; then
			export flagf="ext4"     
		elif [ "$flagf" = "btrfs" ]; then
			export flagf="btrfs"
		elif [ "$flagf" = "jfs" ]; then
			export flagf="jfs" 
		elif [ "$flagf" = "reiserfs" ]; then
			export flagf="reiserfs"
		elif [ "$flagf" = "xfs" ]; then
			export flagf="xfs"  	
		fi  		
		
		if [ -z "$flagw" ]; then
			export WAIT=10
		else
	        export WAIT=$flagw
		fi   
		
		if [ -z "$flagd" ] || [ "$flagd" == "/dev/sda1" ]; then
			export flagd="/dev/sdb1"
		fi	
		
		
			
kv=`file -L /boot/vmlinuz | sed 's/^.*, version \([^ ]\+\) .*$/\1/'`

#moduleslist="loop:xhci-pci:ohci-pci:ehci-pci:xhci-hcd:uhci-hcd:ehci-hcd:mmc-core:mmc-block:sdhci:sdhci-pci:sdhci-acpi:usb-storage:hid:usbhid:i2c-hid:hid-generic:hid-apple:hid-asus:hid-cherry:hid-logitech:hid-logitech-dj:hid-logitech-hidpp:hid-lenovo:hid-microsoft:hid_multitouch:crc32c-intel:fuse"
moduleslist="loop:xhci-pci:ohci-pci:ehci-pci:xhci-hcd:uhci-hcd:ehci-hcd:mmc-core:mmc-block:sdhci:sdhci-pci:sdhci-acpi:usb-storage:hid:usbhid:i2c-hid:hid-generic:hid-apple:hid-asus:hid-cherry:hid-logitech:hid-logitech-dj:hid-logitech-hidpp:hid-lenovo:hid-microsoft:hid_multitouch:mptbase:mptscsih:mptspi:jbd2:mbcache:crc32c_intel:crc32c_generic:fuse:ext2:ext3:ext4:xfs:reiserfs:jfs:btrfs:isofs:fat:nls_cp437:nls_iso8859-1:msdos:vfat:ntfs"
		
mkinitrd -c -f $flagf -u -w $WAIT -o /boot/initrd.gz -r $flagd -k $kv -m $moduleslist >/dev/null 2>&1
rm -rf /boot/initrd-tree/
if [ -f /usr/sbin/update-grub ]; then
  echo "updating grub"
  update-grub
fi 
