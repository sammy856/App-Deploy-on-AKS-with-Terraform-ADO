output "application_gateway_id" {
  value = values(azurerm_application_gateway.appgw)[0].id
}

output "application_gateway_name" {
  value = values(azurerm_application_gateway.appgw)[0].name
}

output "public_ip_address" {
  value = values(azurerm_public_ip.appgw_pip)[0].ip_address
}