variable "org" {
  type    = string
  default = ""
}

variable "org_vdc" {
  type    = string
  default = ""
}

variable "vm_dict" {
  type = object({
    description = string
    vm_ram      = number
    vm_cpu      = number
    vm_template = string
    vm_independent_disks = map(object({
      vm_disk_size = number
    }))
    networks = list(object({
      name = string
      ip   = string
      mac  = string
    }))
  })
}

variable "vm_name" {
  type = string
}

variable "project-name" {
  type = string
}

variable "company-name" {
  type = string
}

variable "catalog_name" {
  type = string
}
