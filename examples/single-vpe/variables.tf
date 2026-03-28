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
  description = "ID of the VPC where VPE will be created"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for VPE"
  type        = string
}