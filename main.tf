terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.96.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "drport" {
    source = "./drport_resource_group"
    env    = "Test Environment
}