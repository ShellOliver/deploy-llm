variable "project_name" {
  description = "Project name"
  type        = string
}

variable "region" {
  description = "Magalu Cloud region (e.g., br-se1)"
  type        = string
  default     = "br-se1-a"
}

variable "instance_type" {
  description = "vm instance type"
  type        = string
}

variable "ssh_key_name" {
  description = "Name of the SSH key uploaded to Magalu Cloud"
  type        = string
}

variable "magalu_api_key" { # mgc auth api-key create --name="default-vm"
  description = "Magalu Cloud api key"
  type        = string
}

# Add other variables (vm_name, vm_image, etc.)
variable "vm_name" {
  description = "Vm name"
  type        = string
  default     = "main-vm"
}

variable "vm_image" {
  description = "Vm image"
  type        = string
  default     = "cloud-ubuntu-24.04 LTS"
}

variable "ssh_private_key_path" {
  description = "Vm private key"
  type        = string
}

variable "my_ssh_pub_key" {
  description = "Vm public key"
  type        = string
}

variable "allowed_tcp_ports" {
  description = "TCP allowed ports"
  type        = list
  default     = [80]
}