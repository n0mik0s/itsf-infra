resource "vcd_vm" "vcd_vm" {
  name = "${var.company-name}-${var.project-name}-${var.vm_name}"

  vapp_template_id = data.vcd_catalog_vapp_template.default.id
  power_on = false
  computer_name = var.vm_name
  cpus             = var.vm_dict.vm_cpu
  memory           = var.vm_dict.vm_ram

  guest_properties = {
    "guest.hostname"   = var.vm_name
  }

  dynamic "network" {
    for_each = var.vm_dict.networks
    content {
      name               = network.value["name"]
      type               = "org"
      ip_allocation_mode = "MANUAL"
      ip                 = network.value["ip"]
    }
  }
}