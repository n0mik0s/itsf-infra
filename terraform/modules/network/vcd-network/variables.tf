variable "org" {
  type    = string
  default = ""
}

variable "org_vdc" {
  type    = string
  default = ""
}

variable "edge_gateway_default" {
  type    = string
  default = ""
}

variable "edge_cluster_default" {
  type    = string
  default = ""
}

variable "network_dict" {
  type = object({
    description   = string
    isolated      = bool
    prefix_length = number
    ip_pools = list(object({
      start_address = string
      end_address   = string
    }))
    gateway            = string
    guest_vlan_allowed = bool
    dhcp_enable        = bool
    dhcp_pools = list(object({
      start_address = string
      end_address   = string
    }))
    dhcp_mode           = string
    listener_ip_address = string
    dns1                = string
    dns2                = string
    dhcp_bindings = map(object({
      mac = string
      ip  = string
    }))
  })
}

variable "network_name" {
  type = string
}

variable "project-name" {
  type = string
}

variable "company-name" {
  type = string
}