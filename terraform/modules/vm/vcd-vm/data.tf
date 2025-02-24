data "vcd_catalog" "default" {
  org  = var.org
  name = var.catalog_name
}

data "vcd_catalog_vapp_template" "default" {
  org        = var.org
  catalog_id = data.vcd_catalog.default.id
  name       = var.vm_dict.vm_template
}