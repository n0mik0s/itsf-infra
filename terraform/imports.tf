/*
resource "vcd_network_routed_v2" "terraform_test_network" {
  name            = "terraform_test_network"
  org             = data.vcd_org.default.name
  edge_gateway_id = data.vcd_nsxt_edgegateway.default.id
  gateway         = "10.1.0.1"
  prefix_length   = 24
  description     = "Network for testing terraform import feature"
  dns1            = "1.1.1.1"

  static_ip_pool {
    end_address   = "10.1.0.254"
    start_address = "10.1.0.10"
  }
}

resource "vcd_nsxt_network_dhcp" "terraform_test_network_pools" {
  org_network_id      = vcd_network_routed_v2.terraform_test_network.id
  mode                = "NETWORK"
  listener_ip_address = "10.1.0.254"

  pool {
    start_address = "10.1.0.100"
    end_address   = "10.1.0.200"
  }
}
*/