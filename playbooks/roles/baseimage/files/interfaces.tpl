source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# I intenionally leave no eth0 configured, so cloudinit will add the interface with static ip 
