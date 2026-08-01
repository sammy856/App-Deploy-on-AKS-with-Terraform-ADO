module "rgs" {
  source    = "../../modules/resource_group"
  rgdetails = var.resource_groups_values
}

module "acrs" {
  source     = "../../modules/acr"
  acrdetails = var.acrs_values
  # depends_on = [module.rgs]
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


# resource "azurerm_role_assignment" "acr_pull" {

#   principal_id         = module.aks.kubelet_identity_object_id
#   role_definition_name = "AcrPull"
#   scope                = module.acrs.acr_id
# }

