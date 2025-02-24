terraform {
  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "3.14.1"
    }
  }
}

provider "vcd" {
  user                 = "none"
  password             = "none"
  auth_type            = "api_token"
  vdc                  = local.vcd_org_vdc
  api_token            = local.vcd_token
  org                  = local.vcd_org
  url                  = local.vcd_url
  max_retry_timeout    = var.vcd_max_retry_timeout
  allow_unverified_ssl = var.vcd_allow_unverified_ssl
}