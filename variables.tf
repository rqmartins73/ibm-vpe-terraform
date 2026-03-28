##############################################################################
# Account Variables
##############################################################################

variable "ibmcloud_api_key" {
  description = "IBM Cloud API key"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "IBM Cloud region where resources will be created"
  type        = string
  default     = "us-south"
}

variable "resource_group_id" {
  description = "ID of the resource group where VPE resources will be created"
  type        = string
}

##############################################################################
# VPE Configuration Variables
##############################################################################

variable "vpe_configurations" {
  description = "List of Virtual Private Endpoint configurations. Each VPE requires a name, VPC ID, subnet IDs, and target CRN."
  type = list(object({
    name               = string
    vpc_id             = string
    subnet_ids         = list(string)
    target_crn         = string
    security_group_ids = optional(list(string), [])
    resource_group_id  = optional(string)
    tags               = optional(list(string), [])
  }))
  default = []

  validation {
    condition     = length(var.vpe_configurations) > 0
    error_message = "At least one VPE configuration must be provided."
  }

  validation {
    condition = alltrue([
      for vpe in var.vpe_configurations :
      length(vpe.subnet_ids) > 0
    ])
    error_message = "Each VPE configuration must have at least one subnet ID."
  }
}

##############################################################################
# Optional Global Settings
##############################################################################

variable "prefix" {
  description = "Prefix to add to all VPE resource names"
  type        = string
  default     = ""
}

variable "tags" {
  description = "List of tags to apply to all VPE resources"
  type        = list(string)
  default     = []
}

##############################################################################
# Service Endpoint Targets (Common IBM Cloud Services)
##############################################################################

variable "service_endpoints" {
  description = "Map of common IBM Cloud service endpoint CRNs by region. Use these as reference for target_crn in vpe_configurations."
  type        = map(map(string))
  default = {
    "us-south" = {
      "cos"              = "crn:v1:bluemix:public:cloud-object-storage:global:::endpoint:s3.direct.us-south.cloud-object-storage.appdomain.cloud"
      "kms"              = "crn:v1:bluemix:public:kms:us-south:::endpoint:private.us-south.kms.cloud.ibm.com"
      "databases-for-postgresql" = "crn:v1:bluemix:public:databases-for-postgresql:us-south:::endpoint:private.us-south.databases.appdomain.cloud"
      "container-registry" = "crn:v1:bluemix:public:container-registry:us-south:::endpoint:private.us.icr.io"
    }
    "us-east" = {
      "cos"              = "crn:v1:bluemix:public:cloud-object-storage:global:::endpoint:s3.direct.us-east.cloud-object-storage.appdomain.cloud"
      "kms"              = "crn:v1:bluemix:public:kms:us-east:::endpoint:private.us-east.kms.cloud.ibm.com"
      "databases-for-postgresql" = "crn:v1:bluemix:public:databases-for-postgresql:us-east:::endpoint:private.us-east.databases.appdomain.cloud"
      "container-registry" = "crn:v1:bluemix:public:container-registry:us-east:::endpoint:private.us.icr.io"
    }
    "eu-gb" = {
      "cos"              = "crn:v1:bluemix:public:cloud-object-storage:global:::endpoint:s3.direct.eu-gb.cloud-object-storage.appdomain.cloud"
      "kms"              = "crn:v1:bluemix:public:kms:eu-gb:::endpoint:private.eu-gb.kms.cloud.ibm.com"
      "databases-for-postgresql" = "crn:v1:bluemix:public:databases-for-postgresql:eu-gb:::endpoint:private.eu-gb.databases.appdomain.cloud"
      "container-registry" = "crn:v1:bluemix:public:container-registry:eu-gb:::endpoint:private.uk.icr.io"
    }
    "eu-de" = {
      "cos"              = "crn:v1:bluemix:public:cloud-object-storage:global:::endpoint:s3.direct.eu-de.cloud-object-storage.appdomain.cloud"
      "kms"              = "crn:v1:bluemix:public:kms:eu-de:::endpoint:private.eu-de.kms.cloud.ibm.com"
      "databases-for-postgresql" = "crn:v1:bluemix:public:databases-for-postgresql:eu-de:::endpoint:private.eu-de.databases.appdomain.cloud"
      "container-registry" = "crn:v1:bluemix:public:container-registry:eu-de:::endpoint:private.de.icr.io"
    }
    "jp-tok" = {
      "cos"              = "crn:v1:bluemix:public:cloud-object-storage:global:::endpoint:s3.direct.jp-tok.cloud-object-storage.appdomain.cloud"
      "kms"              = "crn:v1:bluemix:public:kms:jp-tok:::endpoint:private.jp-tok.kms.cloud.ibm.com"
      "databases-for-postgresql" = "crn:v1:bluemix:public:databases-for-postgresql:jp-tok:::endpoint:private.jp-tok.databases.appdomain.cloud"
      "container-registry" = "crn:v1:bluemix:public:container-registry:jp-tok:::endpoint:private.jp.icr.io"
    }
    "au-syd" = {
      "cos"              = "crn:v1:bluemix:public:cloud-object-storage:global:::endpoint:s3.direct.au-syd.cloud-object-storage.appdomain.cloud"
      "kms"              = "crn:v1:bluemix:public:kms:au-syd:::endpoint:private.au-syd.kms.cloud.ibm.com"
      "databases-for-postgresql" = "crn:v1:bluemix:public:databases-for-postgresql:au-syd:::endpoint:private.au-syd.databases.appdomain.cloud"
      "container-registry" = "crn:v1:bluemix:public:container-registry:au-syd:::endpoint:private.au.icr.io"
    }
  }
}