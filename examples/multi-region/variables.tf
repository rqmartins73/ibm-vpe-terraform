##############################################################################
# Required Variables
##############################################################################

variable "ibmcloud_api_key" {
  description = "IBM Cloud API key"
  type        = string
  sensitive   = true
}

variable "resource_group_id" {
  description = "ID of the resource group for all regions"
  type        = string
}

##############################################################################
# US-South Region Variables
##############################################################################

variable "vpc_id_us_south" {
  description = "VPC ID in US-South region"
  type        = string
}

variable "subnet_ids_us_south" {
  description = "List of subnet IDs in US-South region"
  type        = list(string)
}

##############################################################################
# EU-GB Region Variables
##############################################################################

variable "vpc_id_eu_gb" {
  description = "VPC ID in EU-GB (London) region"
  type        = string
}

variable "subnet_ids_eu_gb" {
  description = "List of subnet IDs in EU-GB region"
  type        = list(string)
}

##############################################################################
# JP-TOK Region Variables
##############################################################################

variable "vpc_id_jp_tok" {
  description = "VPC ID in JP-TOK (Tokyo) region"
  type        = string
}

variable "subnet_ids_jp_tok" {
  description = "List of subnet IDs in JP-TOK region"
  type        = list(string)
}