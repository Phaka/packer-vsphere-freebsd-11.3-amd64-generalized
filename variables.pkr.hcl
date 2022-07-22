variable "packer_username" {
  type = string
}

variable "packer_password" {
  type = string
}

variable "packer_password_hashed" {
  type = string
}

//variable "packer_authorized_key" {
//  type = string
//  default = ""
//}

variable "ssh_password" {
  type = string
}

variable "ssh_password_hashed" {
  type = string
}

variable "ssh_username" {
  type = string
  default = "root"
}

//variable "ssh_authorized_key" {
//  type = string
//  default = ""
//}

variable "vcenter_username" {
  type = string
}

variable "vcenter_password" {
  type = string
}

variable "vcenter_server" {
  type = string
}

variable "vcenter_folder" {
  type = string
  default = "FreeBSD/11.3/amd64"
}

variable "vsphere_host" {
  type = string
}

variable "vsphere_network" {
  type = string
  default = "VM Network"
}

variable "vsphere_datastore" {
  type = string
  default = "datastore1"
}

variable "iso_path_prefix" {
  type = string
  default = "[isos] bla.iso"
}

variable "iso_path" {
  type = string
  default = "ISO-IMAGES/11.3/FreeBSD-11.3-RELEASE-amd64-dvd1.iso"
}

variable "processor_count" {
  type = number
  default = 1
}

variable "processor_cores" {
  type = number
  default = 2
}

variable "RAM" {
  type = number
  default = 4096
}

variable "disk_size" {
  type = number
  default = 32768
}

variable "hostname" {
  type = string
  default = "freebsd-113-amd64"
}
