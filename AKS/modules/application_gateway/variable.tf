variable "appgwdetails" {
  type = map(object({
    name                  = string
    location              = string
    rgname                = string

    vnet_name             = string
    vnet_rgname           = string
    subnet_name           = string
    subnet_address_prefix = string

    public_ip_name        = string

    sku_name              = string
    sku_tier              = string
    capacity              = number
  }))
}