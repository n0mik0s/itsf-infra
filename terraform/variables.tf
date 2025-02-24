variable "tf_environment" {
  type = string
}

variable "vcd_backend_cred_dir" {
  type    = string
  default = ""
}

variable "vcd_backend_conf_dir" {
  type    = string
  default = ""
}

variable "vcd_backend_cred_file" {
  type    = string
  default = ""
}

variable "vcd_backend_resource_file" {
  type = string
}

variable "vcd_backend_domain" {
  type    = string
  default = ""
}

variable "vcd_max_retry_timeout" {
  type    = number
  default = 5
}

variable "vcd_allow_unverified_ssl" {
  type    = bool
  default = true
}

variable "vcd_edge_gateway_default" {
  type    = string
  default = ""
}

variable "vcd_catalog_name" {
  type    = string
  default = ""
}

variable "vcd_edge_cluster_default" {
  type    = string
  default = ""
}

locals {
  ## VCD related vars
  vcd_backend_cred_path_to_file     = "${var.vcd_backend_cred_dir}/${var.vcd_backend_cred_file}"
  vcd_backend_resource_path_to_file = "${var.vcd_backend_conf_dir}/${var.tf_environment}/${var.vcd_backend_resource_file}"

  ## Predefined org settings
  vcd_org     = lookup(lookup(try(jsondecode(file(local.vcd_backend_cred_path_to_file)), {}), var.vcd_backend_domain, {}), "org")
  vcd_org_vdc = lookup(lookup(try(jsondecode(file(local.vcd_backend_cred_path_to_file)), {}), var.vcd_backend_domain, {}), "vdc")
  vcd_token   = lookup(lookup(try(jsondecode(file(local.vcd_backend_cred_path_to_file)), {}), var.vcd_backend_domain, {}), "token")
  vcd_url     = lookup(lookup(try(jsondecode(file(local.vcd_backend_cred_path_to_file)), {}), var.vcd_backend_domain, {}), "url")

  ## General
  company-name = lookup(try(jsondecode(file(local.vcd_backend_resource_path_to_file)), {}), "company-name", {})
  project-name = lookup(try(jsondecode(file(local.vcd_backend_resource_path_to_file)), {}), "project-name", {})

  ## Networks
  vcd_network_dict = lookup(try(jsondecode(file(local.vcd_backend_resource_path_to_file)), {}), "network", {})

  ## VM
  vcd_vm_dict = lookup(try(jsondecode(file(local.vcd_backend_resource_path_to_file)), {}), "vm", {})
}