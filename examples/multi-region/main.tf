##############################################################################
# Multi-Region VPE Example
# This example demonstrates creating Virtual Private Endpoints across
# multiple IBM Cloud regions for disaster recovery and global access
##############################################################################

##############################################################################
# US-South Region VPEs
##############################################################################

module "vpe_us_south" {
  source = "../../"

  ibmcloud_api_key  = var.ibmcloud_api_key
  region            = "us-south"
  resource_group_id = var.resource_group_id
  prefix            = "us-south"

  vpe_configurations = [
    {
      name       = "cos-vpe"
      vpc_id     = var.vpc_id_us_south
      subnet_ids = var.subnet_ids_us_south
      target_crn = "crn:v1:bluemix:public:cloud-object-storage:global:::endpoint:s3.direct.us-south.cloud-object-storage.appdomain.cloud"
      tags       = ["region:us-south", "service:cos"]
    },
    {
      name       = "kms-vpe"
      vpc_id     = var.vpc_id_us_south
      subnet_ids = [var.subnet_ids_us_south[0]]
      target_crn = "crn:v1:bluemix:public:kms:us-south:::endpoint:private.us-south.kms.cloud.ibm.com"
      tags       = ["region:us-south", "service:kms"]
    }
  ]

  tags = ["managed-by:terraform", "example:multi-region"]
}

##############################################################################
# EU-GB (London) Region VPEs
##############################################################################

module "vpe_eu_gb" {
  source = "../../"

  ibmcloud_api_key  = var.ibmcloud_api_key
  region            = "eu-gb"
  resource_group_id = var.resource_group_id
  prefix            = "eu-gb"

  vpe_configurations = [
    {
      name       = "cos-vpe"
      vpc_id     = var.vpc_id_eu_gb
      subnet_ids = var.subnet_ids_eu_gb
      target_crn = "crn:v1:bluemix:public:cloud-object-storage:global:::endpoint:s3.direct.eu-gb.cloud-object-storage.appdomain.cloud"
      tags       = ["region:eu-gb", "service:cos"]
    },
    {
      name       = "kms-vpe"
      vpc_id     = var.vpc_id_eu_gb
      subnet_ids = [var.subnet_ids_eu_gb[0]]
      target_crn = "crn:v1:bluemix:public:kms:eu-gb:::endpoint:private.eu-gb.kms.cloud.ibm.com"
      tags       = ["region:eu-gb", "service:kms"]
    }
  ]

  tags = ["managed-by:terraform", "example:multi-region"]
}

##############################################################################
# JP-TOK (Tokyo) Region VPEs
##############################################################################

module "vpe_jp_tok" {
  source = "../../"

  ibmcloud_api_key  = var.ibmcloud_api_key
  region            = "jp-tok"
  resource_group_id = var.resource_group_id
  prefix            = "jp-tok"

  vpe_configurations = [
    {
      name       = "cos-vpe"
      vpc_id     = var.vpc_id_jp_tok
      subnet_ids = var.subnet_ids_jp_tok
      target_crn = "crn:v1:bluemix:public:cloud-object-storage:global:::endpoint:s3.direct.jp-tok.cloud-object-storage.appdomain.cloud"
      tags       = ["region:jp-tok", "service:cos"]
    },
    {
      name       = "kms-vpe"
      vpc_id     = var.vpc_id_jp_tok
      subnet_ids = [var.subnet_ids_jp_tok[0]]
      target_crn = "crn:v1:bluemix:public:kms:jp-tok:::endpoint:private.jp-tok.kms.cloud.ibm.com"
      tags       = ["region:jp-tok", "service:kms"]
    }
  ]

  tags = ["managed-by:terraform", "example:multi-region"]
}