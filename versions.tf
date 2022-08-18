terraform {
  required_version = ">= 1.2.6"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.17.0"
    }
  }
}
provider "azurerm" {
   features {}
}