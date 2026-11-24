
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "sttfstate158908"
    container_name       = "tfstate"
    key                  = "windows-server.tfstate"

    use_azuread_auth = true
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}
