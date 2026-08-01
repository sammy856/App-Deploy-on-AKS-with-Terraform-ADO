output "sql_server_fqdn" {
  value = { for k, v in azurerm_mssql_server.sql_server : k => v.fully_qualified_domain_name }
}

output "sql_database_id" {
  value = { for k, v in azurerm_mssql_database.sql_db : k => v.id }
}
