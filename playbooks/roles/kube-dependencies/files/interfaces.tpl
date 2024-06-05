source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug eth0
iface eth0 inet static
     address 192.168.0.20${addr}
	 netmask 255.255.255.0
     gateway: 192.168.0.1

iface eth0 inet6 auto

