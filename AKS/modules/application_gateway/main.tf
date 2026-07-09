# Existing Application Gateway subnet ko read karega
# data "azurerm_subnet" "appgw_subnet" {
#   for_each = var.appgwdetails

#   name                 = each.value.subnet_name
#   virtual_network_name = each.value.vnet_name
#   resource_group_name  = each.value.vnet_rgname
# }


resource "azurerm_subnet" "appgw_subnet" {
  for_each = var.appgwdetails

  name                 = each.value.subnet_name
  resource_group_name  = each.value.vnet_rgname
  virtual_network_name = each.value.vnet_name

  address_prefixes = [
    each.value.subnet_address_prefix
  ]
}


# Application Gateway ke liye Static Public IP
resource "azurerm_public_ip" "appgw_pip" {
  for_each = var.appgwdetails

  name                = each.value.public_ip_name
  location            = each.value.location
  resource_group_name = each.value.rgname

  allocation_method = "Static"
  sku               = "Standard"
}


# Application Gateway
resource "azurerm_application_gateway" "appgw" {
  for_each = var.appgwdetails

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rgname

  sku {
    name     = each.value.sku_name
    tier     = each.value.sku_tier
    capacity = each.value.capacity
  }

  gateway_ip_configuration {
    name = "appgw-ip-configuration"

    subnet_id = azurerm_subnet.appgw_subnet[each.key].id
  }

  frontend_ip_configuration {
    name = "appgw-frontend-ip"

    public_ip_address_id = azurerm_public_ip.appgw_pip[each.key].id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  backend_address_pool {
    name = "temporary-backend-pool"
  }

  backend_http_settings {
    name                  = "temporary-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  http_listener {
    name                           = "temporary-http-listener"
    frontend_ip_configuration_name = "appgw-frontend-ip"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "temporary-routing-rule"
    priority                   = 100
    rule_type                  = "Basic"
    http_listener_name         = "temporary-http-listener"
    backend_address_pool_name  = "temporary-backend-pool"
    backend_http_settings_name = "temporary-http-settings"
  }
}