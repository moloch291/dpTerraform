terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "drport" {
  source               = "./drport_resource_group"
  connection_string    = "dummy-connection-string"
  mssql_admin_login_pw = "p4assword"
  mssql_admin_login    = "4dm1n"
  env                  = "qa"
}