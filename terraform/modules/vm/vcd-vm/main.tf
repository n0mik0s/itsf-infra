resource "vcd_vm" "vcd_vm" {
  name = "${var.company-name}-${var.project-name}-${var.vm_name}"

  vapp_template_id = data.vcd_catalog_vapp_template.default.id
  power_on         = false
  computer_name    = var.vm_name
  cpus             = var.vm_dict.vm_cpu
  memory           = var.vm_dict.vm_ram

  guest_properties = {
    "guest.hostname" = var.vm_name
  }

  dynamic "network" {
    for_each = var.vm_dict.networks
    content {
      name               = network.value["name"]
      type               = "org"
      ip_allocation_mode = "MANUAL"
      ip                 = network.value["ip"]
      mac                = network.value["mac"]
    }
  }

  dynamic "disk" {
    for_each = var.vm_dict.vm_independent_disks
    content {
      name        = vcd_independent_disk.independent_disk[disk.key].name
      bus_number  = disk.key + 1
      unit_number = disk.key + 1
    }
  }
}

resource "vcd_independent_disk" "independent_disk" {
  for_each = var.vm_dict.vm_independent_disks

  vdc             = data.vcd_org_vdc.default.name
  name            = "${var.company-name}-${var.project-name}-${var.vm_name}-independent_disk-${each.key}"
  size_in_mb      = each.value.vm_disk_size
  bus_type        = "SCSI"
  bus_sub_type    = "VirtualSCSI"
  storage_profile = "Hyper speed space"
}