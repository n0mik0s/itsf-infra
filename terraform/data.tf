data "vcd_org" "default" {
  name = local.vcd_org
}

data "vcd_org_vdc" "default" {
  name = local.vcd_org_vdc
  org  = data.vcd_org.default.name
}

data "vcd_nsxt_edgegateway" "default" {
  org  = data.vcd_org.default.name
  name = var.vcd_edge_gateway_default
}