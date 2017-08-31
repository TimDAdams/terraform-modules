resource "vsphere_virtual_machine" "node" {
  count         = "${var.instance_count}"
  name          = "${lookup(var.hostname, count.index)}"
  datacenter    = "${var.vmware_datacenter}"
  cluster       = "${var.vmware_cluster}"
  vcpu          = "${var.vm_vcpu}"
  memory        = "${var.vm_memory}"
  folder        = "${var.vmware_folder}"
  domain        = "${var.base_domain}"
  dns_servers   = ["${var.dns_servers}"]
  dns_suffixes  = ["${var.dns_suffixes}"]

  network_interface {
    label               = "${lookup(var.vm_network_label, count.index)}"
    ipv4_address        = "${lookup(var.ip_address, count.index)}"
    ipv4_prefix_length  = "${lookup(var.ip_prefix_length, count.index)}"
    ipv4_gateway        = "${lookup(var.ip_gateway, count.index)}"
  }

  disk {
    datastore = "${var.vm_disk_datastore_cluster}/lookup(var.vm_disk_datastore, count.index)"
    template  = "${var.vm_disk_template_folder}/${var.vm_disk_template}"
    type      = "thin"
  }
connection {
    type        = "ssh"
    user        = "root"
}

provisioner "remote-exec" {
    inline = [
      "sudo systemctl enable salt-minion.service",
      "sudo systemctl start salt-minion.service",
      "sudo systemctl enable httpd.service",
      "sudo systemctl start httpd.service",
    ]
  }

}