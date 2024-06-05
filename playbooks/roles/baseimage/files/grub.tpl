GRUB_DEFAULT=0
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="initrd=/install/initrd.gz net.ifnames=0 biosdevname=0 console=tty1 console=ttyS0,115200"
GRUB_CMDLINE_LINUX="initrd=/install/initrd.gz net.ifnames=0 biosdevname=0 console=tty1 console=ttyS0,115200"
GRUB_TERMINAL="console serial"
