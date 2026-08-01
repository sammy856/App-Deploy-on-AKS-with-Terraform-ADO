variable "sqldetails" {
  type = map(object({
    server_name    = string
    db_name        = string
    location       = string
    rgname         = string
    admin_username = string
    admin_password = string
    sku_name       = string
  }))
}
