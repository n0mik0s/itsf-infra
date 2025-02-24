module "network" {
  for_each = local.vcd_network_dict

  source = "./modules/network/vcd-network"

  org     = local.vcd_org
  org_vdc = local.vcd_org_vdc

  edge_gateway_default = var.vcd_edge_gateway_default
  edge_cluster_default = var.vcd_edge_cluster_default

  network_dict = each.value
  network_name = each.key
  company-name = local.company-name
  project-name = local.project-name
}

module "vm" {
  for_each = local.vcd_vm_dict

  source = "./modules/vm/vcd-vm"

  org          = local.vcd_org
  org_vdc      = local.vcd_org_vdc
  catalog_name = var.vcd_catalog_name

  vm_dict      = each.value
  vm_name      = each.key
  company-name = local.company-name
  project-name = local.project-name

  depends_on = [module.network]
}

