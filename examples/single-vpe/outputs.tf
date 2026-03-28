##############################################################################
# Outputs
##############################################################################

output "vpe_gateway_id" {
  description = "ID of the created VPE gateway"
  value       = module.vpe.vpe_gateway_ids[0]
}

output "vpe_gateway_name" {
  description = "Name of the created VPE gateway"
  value       = module.vpe.vpe_gateway_names[0]
}

output "vpe_ip_address" {
  description = "IP address of the VPE"
  value       = module.vpe.vpe_ip_addresses[0]
}

output "vpe_summary" {
  description = "Summary of the created VPE"
  value       = module.vpe.vpe_summary
}