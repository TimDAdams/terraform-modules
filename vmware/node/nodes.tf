resource "vsphere_virtual_machine" "node" {
  count         = "${var.instance_count}"
  name          = "${var.hostname["${count.index}"]}"
  datacenter    = "${var.vmware_datacenter}"
  cluster       = "${var.vmware_cluster}"
  vcpu          = "${var.vm_vcpu}"
  memory        = "${var.vm_memory}"
  folder        = "${var.vmware_folder}"
  domain        = "${var.base_domain}"
  dns_servers   = ["${var.dns_servers}"]
  dns_suffixes  = ["${var.dns_suffixes}"]

  network_interface {
    label               = "${var.vm_network_label}"
    ipv4_address        = "${var.ip_address}"
    ipv4_prefix_length  = "${var.ip_prefix_length}"
    ipv4_gateway        = "${var.ip_gateway}"
  }

  disk {
    datastore = "${var.vm_disk_datastore_cluster}/${var.vm_disk_datastore}"
    template  = "${var.vm_disk_template_folder}/${var.vm_disk_template}"
    type      = "thin"
  }
connection {
    type        = "ssh"
    user        = "salt"
}

provisioner "remote-exec" {
    inline = [
      "sudo systemctl enable salt-minion.service",
      "sudo systemctl start salt-minion.service",
    ]
  }

}