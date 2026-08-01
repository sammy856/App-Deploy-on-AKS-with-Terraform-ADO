module "rgs" {
  source    = "../../modules/resource_group"
  rgdetails = var.resource_groups_values
}

module "acrs" {
  source     = "../../modules/acr"
  acrdetails = var.acrs_values
  depends_on = [module.rgs]
}


module "application_gateway" {
  source       = "../../modules/application_gateway"
  appgwdetails = var.application_gateway_values
  depends_on   = [module.rgs]
}

module "aks" {
  source                 = "../../modules/kubernetes_cluster"
  aksclusterdetails      = var.aks_clusters_values
  application_gateway_id = module.application_gateway.application_gateway_id
  depends_on             = [module.rgs, module.application_gateway]
}

# Fetch existing Azure Key Vault & Secrets for DB Credentials
data "azurerm_key_vault" "kv" {
  name                = var.keyvault_name
  resource_group_name = var.keyvault_rgname
}

data "azurerm_key_vault_secret" "db_username" {
  name         = var.db_username_secret_name
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "db_password" {
  name         = var.db_password_secret_name
  key_vault_id = data.azurerm_key_vault.kv.id
}

module "sql_database" {
  source = "../../modules/sql_database"
  sqldetails = {
    for k, v in var.sql_databases_values : k => merge(v, {
      admin_username = data.azurerm_key_vault_secret.db_username.value
      admin_password = data.azurerm_key_vault_secret.db_password.value
    })
  }
  depends_on = [module.rgs]
}


# resource "azurerm_role_assignment" "acr_pull" {

#   principal_id         = module.aks.kubelet_identity_object_id
#   role_definition_name = "AcrPull"
#   scope                = module.acrs.acr_id
# }

