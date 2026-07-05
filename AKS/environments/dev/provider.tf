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
  subscription_id = "643bfcc9-412c-4c3f-9588-d3206ea2210c"
}


provider "kubernetes" {

  host = module.aks.host

  client_certificate = base64decode(module.aks.client_certificate)

  client_key = base64decode(module.aks.client_key)

  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
}

