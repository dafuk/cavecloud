resource "libvirt_volume" "base" {
  name = "base"
  pool = "default"
  source = "/var/lib/libvirt/images/bases/packer-debian_base"
  format = "qcow2"
}
