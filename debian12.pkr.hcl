
variable "config_file" {
  type    = string
  default = "debian-preseed.cfg"
}

variable "cpu" {
  type    = string
  default = "8"
}


variable "disk_size" {
  type    = string
  default = "8000"
}

variable "headless" {
  type    = string
  default = "true"
}

variable "iso_checksum" {
  type    = string
  default = "file:https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/SHA256SUMS"
}

variable "iso_url" {
  type    = string
  default = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.5.0-amd64-netinst.iso"
}

variable "name" {
  type    = string
  default = "debian"
}

variable "ram" {
  type    = string
  default = "8192"
}

variable "ssh_password" {
  type    = string
  default = "thatpassword"
}

variable "ssh_username" {
  type    = string
  default = "root"
}

variable "version" {
  type    = string
  default = "12"
}

source "qemu" "debian_base" {
  accelerator      = "kvm"
  boot_command     = ["<esc><wait>", "auto <wait>", "console-keymaps-at/keymap=us <wait>", "console-setup/ask_detect=false <wait>", "debconf/frontend=noninteractive <wait>", "debian-installer=en_US <wait>", "fb=false <wait>", "install <wait>", "kbd-chooser/method=us <wait>", "keyboard-configuration/xkb-keymap=us <wait>", "locale=en_US <wait>", "netcfg/get_hostname=${var.name}${var.version} <wait>", "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/http/${var.config_file} <wait>", "<enter><wait>"]
  boot_wait        = "15s"
  disk_cache       = "directsync"
  disk_compression = true
  disk_discard     = "unmap"
  disk_interface   = "virtio"
  disk_size        = var.disk_size
  format           = "qcow2"
  headless         = var.headless
  host_port_max    = 2229
  host_port_min    = 2222
  http_directory   = "."
  http_port_max    = 10089
  http_port_min    = 10082
  iso_checksum     = var.iso_checksum
  iso_url          = var.iso_url
  net_device       = "virtio-net"
  output_directory = "/var/lib/libvirt/images/bases"
  qemu_binary      = "/usr/bin/qemu-system-x86_64"
  qemuargs         = [["-m", "${var.ram}M"], ["-smp", "${var.cpu}"]]
  shutdown_command = "echo '${var.ssh_password}' | sudo -S shutdown -P now"
  ssh_password     = var.ssh_password
  ssh_username     = var.ssh_username
  ssh_wait_timeout = "10m"
}

build {
  sources = ["source.qemu.debian_base"]

  provisioner "shell" {
    execute_command = "{{ .Vars }} bash '{{ .Path }}'"
    inline          = ["apt-get update", "apt -y upgrade", "apt install ansible -y"]
  }
  provisioner "shell" {
    execute_command = "{{ .Vars }} bash '{{ .Path }}'"
    inline 			= ["mkdir -p /root/.ssh"]
  }
  provisioner "file" {
	source = "/root/.ssh/id_rsa.pub"
    destination = "/root/.ssh/id_rsa.pub"
  }
  provisioner "ansible-local" {
    playbook_dir  = "playbooks"
    playbook_file = "playbooks/baseimage.yml"
  }
  provisioner "shell" {
    execute_command = "{{ .Vars }} bash '{{ .Path }}'"
    inline          = ["apt-get clean", "apt-get -y autoremove --purge"]
  }

}
