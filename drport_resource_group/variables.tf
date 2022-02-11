variable "location" {
  type        = string
  description = "Location of the resource group"
  default     = "West Europe"
}

variable "resource_group_name" {
  type        = string
  description = "Name for the resource group"
  default     = "drp-resource-group"
}

variable "acr_name" {
  type        = string
  description = "Name for the container registry"
  default     = "drp-acr"
}

variable "env_vars" {}

variable "env" {}