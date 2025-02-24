variable "backend_vcd_cred_file" {
  type    = string
  default = "~/.vodafone/credentials/vcd.json"
}

variable "backend_vcd_domain" {
  type    = string
  default = "incloud.vodafone.ua"
}

locals {

  ## Predefined org settings
  org         = "SIP_ITSF"
  vdc         = "SIP_ITSF oVDC"
  catalog_org = "FirstOne"
  catalog_tmpl = "LinuxCatalog"

  ## VM setup
  vapp_count             = 1
  vapp_name              = "freeswitch"
  vapp_domain            = "itsf.dc"
  vapp_tmpl              = "Debian 10.9 Template updated_05_2021"
  vapp_cpus              = 2
  vapp_memory            = 4096
  vapp_data_disc_size_mb = 20480
}