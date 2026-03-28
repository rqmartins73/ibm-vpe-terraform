##############################################################################
# Outputs
##############################################################################

output "vpe_gateways" {
  description = "All VPE gateway details"
  value       = module.vpe.vpe_gateways
}

output "vpe_gateway_ids" {
  description = "List of all VPE gateway IDs"
  value       = module.vpe.vpe_gateway_ids
}

output "vpe_gateway_names" {
  description = "List of all VPE gateway names"
  value       = module.vpe.vpe_gateway_names
}

output "vpe_ip_addresses" {
  description = "List of all VPE IP addresses"
  value       = module.vpe.vpe_ip_addresses
}

output "vpe_summary" {
  description = "Summary of all created VPE resources"
  value       = module.vpe.vpe_summary
}

output "cos_vpe_details" {
  description = "Cloud Object Storage VPE details"
  value = {
    id   = module.vpe.vpe_gateway_ids[0]
    name = module.vpe.vpe_gateway_names[0]
  }
}

output "kms_vpe_details" {
  description = "Key Protect VPE details"
  value = {
    id   = module.vpe.vpe_gateway_ids[1]
    name = module.vpe.vpe_gateway_names[1]
  }
}

output "database_vpe_details" {
  description = "Database VPE details"
  value = {
    id   = module.vpe.vpe_gateway_ids[2]
    name = module.vpe.vpe_gateway_names[2]
  }
}

output "registry_vpe_details" {
  description = "Container Registry VPE details"
  value = {
    id   = module.vpe.vpe_gateway_ids[3]
    name = module.vpe.vpe_gateway_names[3]
  }
}