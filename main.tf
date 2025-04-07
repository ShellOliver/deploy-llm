terraform {
  required_providers {
    mgc = {
      source  = "MagaluCloud/mgc"
      version = "0.32.2"
    }
  }
}

provider "mgc" {
  alias = "sul"
  region = var.region
  api_key = var.magalu_api_key
}

# SSH Key Resource
resource "mgc_ssh_keys" "vm" {
  provider = mgc.sul
  name = var.ssh_key_name # using variable, instead of hardcoding
  key  = var.my_ssh_pub_key # using variable
}

# VPC Resource
resource "mgc_network_vpcs" "vm" {
  name        = "default vpc"
  description = "default vpc"
}

resource "mgc_network_subnetpools" "vm" {
  name        = "main-subnetpool"
  description = "Main Subnet Pool"
  type        = "pip"
  cidr        = "10.0.0.0/16"
}

resource "mgc_network_vpcs_subnets" "vm" {
  cidr_block      = "10.0.0.0/24"  
  description     = "Subnet"
  dns_nameservers = ["8.8.8.8", "8.8.4.4"] 
  ip_version      = "IPv4"
  name            = "vm-subnet"  
  subnetpool_id   = mgc_network_subnetpools.vm.id
  vpc_id          = mgc_network_vpcs.vm.id
}

# Public IP Resource
resource "mgc_network_public_ips" "vm" {
  description = "example public ip"
  vpc_id      = mgc_network_vpcs.vm.id
}

# Security Group Resources
resource "mgc_network_security_groups" "ssh_sec_group" {
  name = "${var.project_name}-ssh-sec-group"
}

resource "mgc_network_security_groups" "instances_sec_group" {
  name = "${var.project_name}-instances_sec_group"
}

# Security Group Rules Resources
resource "mgc_network_security_groups_rules" "allow_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_max    = 22
  port_range_min    = 22
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = mgc_network_security_groups.ssh_sec_group.id
}

resource "mgc_network_security_groups_rules" "allow_tcp" {
  for_each          = toset([for port in var.allowed_tcp_ports : tostring(port)])
  direction         = "ingress"
  ethertype         = "IPv4"
  port_range_max    = each.key
  port_range_min    = each.key
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = mgc_network_security_groups.instances_sec_group.id
}

# GPU VM Instance Resource
resource "mgc_virtual_machine_instances" "vm" {
  name         = var.vm_name
  machine_type = var.instance_type
  image        = var.vm_image
  ssh_key_name = mgc_ssh_keys.vm.name
  vpc_id       = mgc_network_vpcs.vm.id
}

# Docker Setup Resource
resource "null_resource" "setup_stack" {
  depends_on = [mgc_virtual_machine_instances.vm]

  triggers = {
    instance_id = mgc_virtual_machine_instances.vm.id
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y docker.io",
      "sudo systemctl enable docker"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.ssh_private_key_path)
      host        = mgc_network_public_ips.vm.public_ip
    }
  }
}

# Outputs
output "vm_public_ip" {
  value       = mgc_network_public_ips.vm.public_ip
  description = "Public IP to access the VM"
}

output "docker_test_command" {
  value       = "ssh -i ~/.ssh/id_rsa ubuntu@${mgc_network_public_ips.vm.public_ip} 'sudo docker run hello-world'"
  description = "Command to test Docker container"
}