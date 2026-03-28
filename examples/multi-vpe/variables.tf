##############################################################################
# Required Variables
##############################################################################

variable "ibmcloud_api_key" {
  description = "IBM Cloud API key"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "IBM Cloud region"
  type        = string
  default     = "us-south"
}

variable "resource_group_id" {
  description = "ID of the resource group"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where VPEs will be created"
  type        = string
}

##############################################################################
# Subnet Variables
##############################################################################

variable "cos_subnet_ids" {
  description = "List of subnet IDs for Cloud Object Storage VPE (multi-zone recommended)"
  type        = list(string)
}

variable "kms_subnet_id" {
  description = "Subnet ID for Key Protect VPE"
  type        = string
}

variable "database_subnet_id" {
  description = "Subnet ID for Database VPE"
  type        = string
}

variable "registry_subnet_ids" {
  description = "List of subnet IDs for Container Registry VPE"
  type        = list(string)
}

##############################################################################
# Optional Variables
##############################################################################

variable "security_group_ids" {
  description = "List of security group IDs to apply to all VPEs"
  type        = list(string)
  default     = []
}