variable "resource_groups_values" {
  type = map(object({
    rgname   = string
    location = string
  }))
}

variable "acrs_values" {
  type = map(object({
    name     = string
    location = string
    rgname   = string
    sku      = string
  }))
}


variable "aks_clusters_values" {

  type = map(object({
    name               = string
    location           = string
    rgname             = string
    dns_prefix         = string
    kubernetes_version = string
    node_count         = number
    vm_size            = string
  }))
}


variable "application_gateway_values" {
  type = map(object({
    name     = string
    location = string
    rgname   = string

    vnet_name             = string
    vnet_rgname           = string
    subnet_name           = string
    subnet_address_prefix = string

    public_ip_name = string

    sku_name = string
    sku_tier = string
    capacity = number
  }))
}

variable "sql_databases_values" {
  type = map(object({
    server_name    = string
    db_name        = string
    location       = string
    rgname         = string
    admin_username = optional(string, "")
    admin_password = optional(string, "")
    sku_name       = string
  }))
}

variable "keyvault_name" {
  type        = string
  description = "Name of existing Key Vault"
  default     = "sammy-keyvault"
}

variable "keyvault_rgname" {
  type        = string
  description = "Resource group name of existing Key Vault"
  default     = "donotdeletemygroup"
}

variable "db_username_secret_name" {
  type        = string
  description = "Name of Key Vault secret for DB Username/ID"
  default     = "db-username"
}

variable "db_password_secret_name" {
  type        = string
  description = "Name of Key Vault secret for DB Password"
  default     = "db-password"
}

variable "subscription_id" {}


