resource "vsphere_virtual_machine" "node" {
  count         = "${var.instance_count}"
  name          = "${lookup(count.index, var.hostname)}"
  datacenter    = "${var.vmware_datacenter}"
  cluster       = "${var.vmware_cluster}"
  vcpu          = "${var.vm_vcpu}"
  memory        = "${var.vm_memory}"
  folder        = "${var.vmware_folder}"
  domain        = "${var.base_domain}"
  dns_servers   = ["${var.dns_servers}"]
  dns_suffixes  = ["${var.dns_suffixes}"]

  network_interface {
    label               = "${lookup(count.index, var.vm_network_label)}"
    ipv4_address        = "${lookup(count.index, var.ip_address)}"
    ipv4_prefix_length  = "${lookup(count.index, var.ip_prefix_length)}"
    ipv4_gw             = "${lookup(count.index, var.ip_gateway)}"
  }

  disk {
    datastore = "${var.vm_disk_datastore_cluster}/lookup(count.index, var.vm_disk_datastore)"
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