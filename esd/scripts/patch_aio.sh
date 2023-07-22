#!/bin/sh

# esd patch_aio.sh v0.2.5 (2023-07-22 by MIBonk & MIB-Wiki)

if [ -f /net/rcc/dev/shmem/reboot.mib ] || [ -f /net/rcc/dev/shmem/backup.mib ] || [ -f /net/rcc/dev/shmem/flash.mib ]; then
	echo "Some process is already running in background, don't interrupt!"
	exit 0
fi

trap '' 2

export PATH=.:/proc/boot:/bin:/usr/bin:/usr/sbin:/sbin:/mnt/app/media/gracenote/bin:/mnt/app/armle/bin:/mnt/app/armle/sbin:/mnt/app/armle/usr/bin:/mnt/app/armle/usr/sbin
export LD_LIBRARY_PATH=/lib:/mnt/app/root/lib-target:/eso/lib:/mnt/app/usr/lib:/mnt/app/armle/lib:/mnt/app/armle/lib/dll:/mnt/app/armle/usr/lib
unset LD_PRELOAD

export GEM=1
echo -ne "M.I.B. - More Incredible Bash "
cat /net/mmx/fs/sda0/VERSION
echo "NOT FOR COMMERCIAL USE - IF YOU BOUGHT THIS YOU GOT RIPPED OFF"
echo ""
echo "NOTE: NEVER interrupt the process with -Back- button or removing SD Card!!!"
echo "CAUTION: Ensure that a external power is connected to the car on during any"
echo "flash or programming process! Power failure during flashing/programming will"
echo "brick your unit! - All you do and use at your own risk!"
echo ""

/net/mmx/fs/sda0/apps/backup -a

. /net/mmx/fs/sda0/config/BASICS

if [[ "$TRAINVERSION" = *MHI2* ]] ; then
	on -f rcc /net/mmx/fs/sda0/apps/carp -b
fi
if [[ "$TRAINVERSION" = *POG24* ]] || [[ "$TRAINVERSION" = *BYG24* ]]; then
	/net/mmx/fs/sda0/apps/installjava -g24wide -noboot
fi
if [[ "$TRAINVERSION" = *POG11* ]]; then
	/net/mmx/fs/sda0/apps/addimage -pog11on -noboot
fi
/net/mmx/fs/sda0/apps/flash -p

trap 2

exit 0

