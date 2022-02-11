variable "region" {
    type        = string
    description = "Default location of the resource group"
    default     = "West Europe"
}

variable "resource_group_name" {
    type        = string
    description = "Name for the resource group"
    default     = "drp_resource_group"
}

variable "env" {}