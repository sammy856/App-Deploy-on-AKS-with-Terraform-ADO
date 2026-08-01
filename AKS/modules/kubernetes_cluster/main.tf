resource "azurerm_kubernetes_cluster" "aks" {

  for_each = var.aksclusterdetails

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rgname
  dns_prefix          = each.value.dns_prefix
  kubernetes_version  = each.value.kubernetes_version

  default_node_pool {
    name       = "system"
    node_count = each.value.node_count
    vm_size    = each.value.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  role_based_access_control_enabled = true

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  dynamic "ingress_application_gateway" {
    for_each = var.application_gateway_id != null ? [1] : []
    content {
      gateway_id = var.application_gateway_id
    }
  }

  tags = {
    Environment = "Dev"
  }
}