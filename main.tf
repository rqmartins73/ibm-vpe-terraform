##############################################################################
# IBM Cloud Virtual Private Endpoint Gateway
##############################################################################

##############################################################################
# Data Source - Resource Group Lookup
##############################################################################

data "ibm_resource_group" "resource_group" {
  count = var.resource_group_name != null ? 1 : 0
  name  = var.resource_group_name
}

locals {
  # Determine the resource group ID to use
  resource_group_id = coalesce(
    var.resource_group_id,
    try(data.ibm_resource_group.resource_group[0].id, null)
  )

  # Merge global tags with VPE-specific tags
  vpe_tags = { for idx, vpe in var.vpe_configurations : idx => concat(
    var.tags,
    lookup(vpe, "tags", [])
  ) }

  # Generate VPE names with optional prefix
  vpe_names = { for idx, vpe in var.vpe_configurations : idx =>
    var.prefix != "" ? "${var.prefix}-${vpe.name}" : vpe.name
  }
}

##############################################################################
# Virtual Private Endpoint Gateway
##############################################################################

resource "ibm_is_virtual_endpoint_gateway" "vpe" {
  for_each = { for idx, vpe in var.vpe_configurations : idx => vpe }

  name           = local.vpe_names[each.key]
  vpc            = each.value.vpc_id
  resource_group = coalesce(each.value.resource_group_id, local.resource_group_id)
  tags           = local.vpe_tags[each.key]

  target {
    crn           = each.value.target_crn
    resource_type = "provider_cloud_service"
  }

  security_groups = length(each.value.security_group_ids) > 0 ? each.value.security_group_ids : null

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags that might be added by other processes
      tags,
    ]
  }
}

##############################################################################
# Virtual Private Endpoint Gateway IP Reservations
##############################################################################

resource "ibm_is_virtual_endpoint_gateway_ip" "vpe_ip" {
  for_each = merge([
    for vpe_idx, vpe in var.vpe_configurations : {
      for subnet_idx, subnet_id in vpe.subnet_ids :
      "${vpe_idx}-${subnet_idx}" => {
        gateway_id = ibm_is_virtual_endpoint_gateway.vpe[vpe_idx].id
        subnet_id  = subnet_id
        vpe_name   = local.vpe_names[vpe_idx]
      }
    }
  ]...)

  gateway     = each.value.gateway_id
  reserved_ip = ibm_is_subnet_reserved_ip.vpe_subnet_reserved_ip[each.key].reserved_ip
}

##############################################################################
# Reserved IPs for VPE Gateway
##############################################################################

resource "ibm_is_subnet_reserved_ip" "vpe_subnet_reserved_ip" {
  for_each = merge([
    for vpe_idx, vpe in var.vpe_configurations : {
      for subnet_idx, subnet_id in vpe.subnet_ids :
      "${vpe_idx}-${subnet_idx}" => {
        subnet_id = subnet_id
        vpe_name  = local.vpe_names[vpe_idx]
      }
    }
  ]...)

  subnet = each.value.subnet_id
  name   = "${each.value.vpe_name}-${each.key}-ip"
}