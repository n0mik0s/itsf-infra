resource "vcd_network_routed_v2" "network" {
  count = var.network_dict.isolated ? 0 : 1

  name            = "${var.company-name}-${var.project-name}-${var.network_name}-routed-network"
  org             = data.vcd_org.default.name
  edge_gateway_id = data.vcd_nsxt_edgegateway.default.id
  gateway         = var.network_dict.gateway
  prefix_length   = var.network_dict.prefix_length
  description     = var.network_dict.description
  dns1            = var.network_dict.dns1
  dns2            = var.network_dict.dns2

  dynamic "static_ip_pool" {
    for_each = var.network_dict.ip_pools
    content {
      end_address   = static_ip_pool.value["end_address"]
      start_address = static_ip_pool.value["start_address"]
    }
  }
}

resource "vcd_network_isolated_v2" "network" {
  count = var.network_dict.isolated ? 1 : 0

  org      = data.vcd_org.default.name
  owner_id = data.vcd_org_vdc.default.id

  name        = "${var.company-name}-${var.project-name}-${var.network_name}-isolated-network"
  description = var.network_dict.description

  gateway       = var.network_dict.gateway
  prefix_length = var.network_dict.prefix_length

  guest_vlan_allowed = var.network_dict.guest_vlan_allowed

  dynamic "static_ip_pool" {
    for_each = var.network_dict.ip_pools
    content {
      end_address   = static_ip_pool.value["end_address"]
      start_address = static_ip_pool.value["start_address"]
    }
  }
}

resource "vcd_nsxt_network_dhcp" "network_dhcp" {
  count = var.network_dict.dhcp_enable ? 1 : 0

  org_network_id      = var.network_dict.isolated ? vcd_network_isolated_v2.network[0].id : vcd_network_routed_v2.network[0].id
  mode                = var.network_dict.dhcp_mode
  listener_ip_address = var.network_dict.listener_ip_address

  dynamic "pool" {
    for_each = var.network_dict.dhcp_pools
    content {
      end_address   = pool.value["end_address"]
      start_address = pool.value["start_address"]
    }
  }
}

resource "vcd_nsxt_network_dhcp_binding" "dhcp_binding" {
  for_each = var.network_dict.dhcp_bindings

  org = data.vcd_org.default.name

  org_network_id = vcd_nsxt_network_dhcp.network_dhcp[0].id

  name         = "${var.company-name}-${var.project-name}-${var.network_name}-${each.key}-DHCP-binding"
  description  = "DHCP binding description"
  binding_type = "IPV4"
  ip_address   = each.value.ip
  lease_time   = 3600
  mac_address  = each.value.mac
  dns_servers  = [var.network_dict.dns1, var.network_dict.dns2]

  dhcp_v4_config {
    gateway_ip_address = var.network_dict.gateway
  }
}