terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.9.0"
    }
  }
  backend "azurerm" {
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}

  subscription_id = "a355c32e-4a22-4b05-aab4-be236850fa6e"
  #client_id       = "95682372-c793-4456-99b3-85cf587688d9"
  #client_secret   = "jp_8Q~_c_OpXDMUkCSMMYQd-fRvM1q4niJctecMO"
  #tenant_id       = "9085ff8c-8807-4ff8-a403-ea470525cda6"
}
