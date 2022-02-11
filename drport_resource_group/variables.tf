variable "location" {
  type        = string
  description = "Location of the resource group and it's containments"
  default     = "West Europe"
}

variable "general_tier" {
  type        = string
  description = "Tier of acr sku"
  default     = "Basic"
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

variable "svc_plan_sku_tier" {
  type        = string
  description = "Tier of acr sku"
  default     = "Standard"
}

variable "svc_plan_sku_size" {
  type        = string
  description = "Size of acr sku"
  default     = "S1" # Default value, needs resolve
}

variable "mssql_name" {
  type        = string
  description = "Name for mssql"
  default     = "drp-mssql"
}

variable "mssql_max_size" {
  type        = number
  description = "Max size for mssql in GB"
  default     = 2
}

variable "is_premium_or_business_crit_tier" {
  type        = bool
  description = "States if current tier basic or not"
  default     = false
}

variable "mssql_admin_login" {}

variable "mssql_admin_login_pw" {}

##### This is just example data! #####
variable "env_vars" {
  description = "Dummy var replacing env vars"

  type = list(object({
    name      = string
    age       = number
    direction = string
  }))
  default = [{
    name      = "Pista"
    age       = 21
    direction = "South"
  },
  {
    name      = "Jeno"
    age       = 12
    direction = "North"
  }]
}

variable "app_svc_plan_kind" {
  kind        = string
  description = "Kind of the app service plan"
  default     = "Windows" # This is the default, needs resolve!
}

variable "connection_string" {}