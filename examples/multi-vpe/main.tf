##############################################################################
# Multi-VPE Example
# This example demonstrates creating multiple Virtual Private Endpoints
# for different IBM Cloud services in the same VPC
##############################################################################

module "vpe" {
  source = "../../"

  ibmcloud_api_key  = var.ibmcloud_api_key
  region            = var.region
  resource_group_id = var.resource_group_id
  prefix            = "multi-example"

  vpe_configurations = [
    # Cloud Object Storage VPE with multi-zone deployment
    {
      name       = "cos-vpe"
      vpc_id     = var.vpc_id
      subnet_ids = var.cos_subnet_ids
      target_crn = "crn:v1:bluemix:public:cloud-object-storage:global:::endpoint:s3.direct.${var.region}.cloud-object-storage.appdomain.cloud"
      security_group_ids = var.security_group_ids
      tags       = ["service:cos", "ha:enabled"]
    },
    # Key Protect VPE
    {
      name       = "kms-vpe"
      vpc_id     = var.vpc_id
      subnet_ids = [var.kms_subnet_id]
      target_crn = "crn:v1:bluemix:public:kms:${var.region}:::endpoint:private.${var.region}.kms.cloud.ibm.com"
      security_group_ids = var.security_group_ids
      tags       = ["service:kms"]
    },
    # PostgreSQL Database VPE
    {
      name       = "postgres-vpe"
      vpc_id     = var.vpc_id
      subnet_ids = [var.database_subnet_id]
      target_crn = "crn:v1:bluemix:public:databases-for-postgresql:${var.region}:::endpoint:private.${var.region}.databases.appdomain.cloud"
      security_group_ids = var.security_group_ids
      tags       = ["service:database"]
    },
    # Container Registry VPE
    {
      name       = "registry-vpe"
      vpc_id     = var.vpc_id
      subnet_ids = var.registry_subnet_ids
      target_crn = "crn:v1:bluemix:public:container-registry:${var.region}:::endpoint:private.${local.registry_region_map[var.region]}.icr.io"
      security_group_ids = var.security_group_ids
      tags       = ["service:registry"]
    }
  ]

  tags = ["managed-by:terraform", "example:multi-vpe"]
}

##############################################################################
# Local Variables
##############################################################################

locals {
  # Map regions to container registry endpoints
  registry_region_map = {
    "us-south" = "us"
    "us-east"  = "us"
    "eu-gb"    = "uk"
    "eu-de"    = "de"
    "jp-tok"   = "jp"
    "au-syd"   = "au"
  }
}