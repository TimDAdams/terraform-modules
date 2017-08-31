variable "instance_count" {
  type        = "string"
  description = "Number of nodes to be created."
}

variable "base_domain" {
  type = "string"
}

variable dns_server {
  type        = "list"
  description = "DNS Servers of the VMs"
}

variable dns_suffixes {
  type        = "list"
  description = "List of DNS suffixes to be used for DNS search order"
}

variable ipv_address {
  type        = "map"
  description = "IP Address of the node"
}

variable ip_gateway {
  type        = "map"
  description = "IP gateway for the node"
}

variable ip_prefix_length {
  type        = "map"
  description = "IP gateway for the node"
}

variable gateway {
  type        = "string"
  description = "Gateway of the node"
}

variable hostname {
  type        = "map"
  description = "Hostname of the node"
}

variable root_public_keys {
  type        = "list"
  description = "Public Key for root User"
}

variable vmware_datacenter {
  type        = "string"
  description = "vSphere Datacenter for VMs"
}

variable vmware_cluster {
  type        = "string"
  description = "vSphere Cluster for VMs"
}

variable vm_vcpu {
  type        = "string"
  description = "VM vCPU count"
}

variable vm_memory {
  type        = "string"
  description = "VM Memory size in MB"
}

variable vm_network_label {
  type        = "map"
  description = "PortGroup for VM"
}

variable vm_disk_datastore {
  type        = "string"
  description = "Datastore for VM"
}

variable vm_disk_datastore_cluster {
  type = "string"
  description = "Datastor cluster for VMs"
}

variable vm_disk_template {
  type        = "string"
  description = "Disk template to use for cloning CentOS Linux"
}

variable vm_disk_template_folder {
  type        = "string"
  description = "vSphere template folder for testing VMs"
}

variable "vmware_folder" {
  type        = "string"
  description = "Name of the VMware folder to create objects in"
}

variable "private_key" {
  type        = "string"
  description = "SSH private key file in .pem format corresponding to vmware_ssh_authorized_key. If not provided, SSH agent will be used."
  default     = ""
}

variable "image_re" {
  description = <<EOF
(internal) Regular expression used to extract repo and tag components from image strings
EOF

  type = "string"
}
