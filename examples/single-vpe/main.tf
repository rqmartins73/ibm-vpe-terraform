##############################################################################
# Single VPE Example
# This example demonstrates creating a single Virtual Private Endpoint
# for Cloud Object Storage in one subnet
##############################################################################

module "vpe" {
  source = "../../"

  ibmcloud_api_key  = var.ibmcloud_api_key
  region            = var.region
  resource_group_id = var.resource_group_id
  prefix            = "example"

  vpe_configurations = [
    {
      name       = "cos-vpe"
      vpc_id     = var.vpc_id
      subnet_ids = [var.subnet_id]
      target_crn = "crn:v1:bluemix:public:cloud-object-storage:global:::endpoint:s3.direct.${var.region}.cloud-object-storage.appdomain.cloud"
      tags       = ["env:dev", "service:cos", "example:single-vpe"]
    }
  ]

  tags = ["managed-by:terraform", "example:single-vpe"]
}
