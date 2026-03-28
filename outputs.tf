##############################################################################
# Virtual Private Endpoint Gateway Outputs
##############################################################################

output "vpe_gateways" {
  description = "Map of Virtual Private Endpoint Gateway details"
  value = {
    for idx, vpe in ibm_is_virtual_endpoint_gateway.vpe : idx => {
      id                 = vpe.id
      name               = vpe.name
      crn                = vpe.crn
      vpc_id             = vpe.vpc
      resource_group_id  = vpe.resource_group
      target_crn         = vpe.target[0].crn
      target_name        = vpe.target[0].name
      target_resource_type = vpe.target[0].resource_type
      created_at         = vpe.created_at
      health_state       = vpe.health_state
      lifecycle_state    = vpe.lifecycle_state
      security_groups    = vpe.security_groups
      tags               = vpe.tags
    }
  }
}

output "vpe_gateway_ids" {
  description = "List of Virtual Private Endpoint Gateway IDs"
  value       = [for vpe in ibm_is_virtual_endpoint_gateway.vpe : vpe.id]
}

output "vpe_gateway_names" {
  description = "List of Virtual Private Endpoint Gateway names"
  value       = [for vpe in ibm_is_virtual_endpoint_gateway.vpe : vpe.name]
}

output "vpe_gateway_crns" {
  description = "List of Virtual Private Endpoint Gateway CRNs"
  value       = [for vpe in ibm_is_virtual_endpoint_gateway.vpe : vpe.crn]
}

##############################################################################
# Reserved IP Outputs
##############################################################################

output "vpe_reserved_ips" {
  description = "Map of reserved IPs for each VPE gateway"
  value = {
    for key, ip in ibm_is_subnet_reserved_ip.vpe_subnet_reserved_ip : key => {
      id         = ip.reserved_ip
      address    = ip.address
      name       = ip.name
      subnet_id  = ip.subnet
      created_at = ip.created_at
    }
  }
}

output "vpe_ip_addresses" {
  description = "List of all VPE IP addresses"
  value       = [for ip in ibm_is_subnet_reserved_ip.vpe_subnet_reserved_ip : ip.address]
}

##############################################################################
# VPE Gateway IP Bindings
##############################################################################

output "vpe_gateway_ips" {
  description = "Map of VPE gateway IP bindings"
  value = {
    for key, gw_ip in ibm_is_virtual_endpoint_gateway_ip.vpe_ip : key => {
      id          = gw_ip.id
      gateway_id  = gw_ip.gateway
      address     = gw_ip.address
      name        = gw_ip.name
      reserved_ip = gw_ip.reserved_ip
      created_at  = gw_ip.created_at
    }
  }
}

##############################################################################
# Summary Output
##############################################################################

output "vpe_summary" {
  description = "Summary of all created VPE resources"
  value = {
    total_vpe_gateways = length(ibm_is_virtual_endpoint_gateway.vpe)
    total_reserved_ips = length(ibm_is_subnet_reserved_ip.vpe_subnet_reserved_ip)
    vpe_details = [
      for idx, vpe in ibm_is_virtual_endpoint_gateway.vpe : {
        name           = vpe.name
        id             = vpe.id
        vpc_id         = vpe.vpc
        target_service = vpe.target[0].name
        health_state   = vpe.health_state
        ip_addresses = [
          for key, ip in ibm_is_subnet_reserved_ip.vpe_subnet_reserved_ip :
          ip.address if startswith(key, tostring(idx))
        ]
      }
    ]
  }
}