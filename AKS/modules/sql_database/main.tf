resource "azurerm_mssql_server" "sql_server" {
  for_each = var.sqldetails

  name                         = each.value.server_name
  resource_group_name          = each.value.rgname
  location                     = each.value.location
  version                      = "12.0"
  administrator_login          = each.value.admin_username
  administrator_login_password = each.value.admin_password

  minimum_tls_version = "1.2"
}

resource "azurerm_mssql_database" "sql_db" {
  for_each = var.sqldetails

  name         = each.value.db_name
  server_id    = azurerm_mssql_server.sql_server[each.key].id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = each.value.sku_name
}

# Optional: Allow Azure internal services (e.g. AKS) to connect to SQL Server
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  for_each = var.sqldetails

  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.sql_server[each.key].id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
