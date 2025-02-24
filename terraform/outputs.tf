output "vcd_org" {
  value = local.vcd_org
}

output "vcd_org_vdc" {
  value = local.vcd_org_vdc
}

output "vcd_token" {
  value     = local.vcd_token
  sensitive = true
}

output "vcd_url" {
  value = local.vcd_url
}

output "vcd_backend_cred_path_to_file" {
  value = local.vcd_backend_cred_path_to_file
}

output "vcd_backend_resource_path_to_file" {
  value = local.vcd_backend_resource_path_to_file
}

output "company-name" {
  value = local.company-name
}

output "project-name" {
  value = local.project-name
}
