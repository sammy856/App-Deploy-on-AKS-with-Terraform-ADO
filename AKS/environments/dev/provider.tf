terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.38"
    }
  }

backend "azurerm" {}

}

provider "azurerm" {
  features {}
  subscription_id = "712eeec0-3f6b-4702-8f88-dbfca33db4d0"
}


provider "kubernetes" {

  host = module.aks.host

  client_certificate = base64decode(module.aks.client_certificate)

  client_key = base64decode(module.aks.client_key)

  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
}

