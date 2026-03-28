##############################################################################
# US-South Region Outputs
##############################################################################

output "us_south_vpe_gateways" {
  description = "US-South VPE gateway details"
  value       = module.vpe_us_south.vpe_gateways
}

output "us_south_vpe_summary" {
  description = "US-South VPE summary"
  value       = module.vpe_us_south.vpe_summary
}

##############################################################################
# EU-GB Region Outputs
##############################################################################

output "eu_gb_vpe_gateways" {
  description = "EU-GB VPE gateway details"
  value       = module.vpe_eu_gb.vpe_gateways
}

output "eu_gb_vpe_summary" {
  description = "EU-GB VPE summary"
  value       = module.vpe_eu_gb.vpe_summary
}

##############################################################################
# JP-TOK Region Outputs
##############################################################################

output "jp_tok_vpe_gateways" {
  description = "JP-TOK VPE gateway details"
  value       = module.vpe_jp_tok.vpe_gateways
}

output "jp_tok_vpe_summary" {
  description = "JP-TOK VPE summary"
  value       = module.vpe_jp_tok.vpe_summary
}

##############################################################################
# Combined Outputs
##############################################################################

output "all_regions_summary" {
  description = "Summary of VPEs across all regions"
  value = {
    us_south = {
      total_vpes = module.vpe_us_south.vpe_summary.total_vpe_gateways
      vpe_names  = module.vpe_us_south.vpe_gateway_names
    }
    eu_gb = {
      total_vpes = module.vpe_eu_gb.vpe_summary.total_vpe_gateways
      vpe_names  = module.vpe_eu_gb.vpe_gateway_names
    }
    jp_tok = {
      total_vpes = module.vpe_jp_tok.vpe_summary.total_vpe_gateways
      vpe_names  = module.vpe_jp_tok.vpe_gateway_names
    }
    total_vpes_all_regions = (
      module.vpe_us_south.vpe_summary.total_vpe_gateways +
      module.vpe_eu_gb.vpe_summary.total_vpe_gateways +
      module.vpe_jp_tok.vpe_summary.total_vpe_gateways
    )
  }
}