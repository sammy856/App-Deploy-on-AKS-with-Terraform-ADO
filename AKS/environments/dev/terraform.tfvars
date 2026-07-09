# resource_groups_values = {
#   rg1 = {
#     rgname   = "donotdeletemygroup"
#     location = "japan east"
#   }
# }




aks_clusters_values = {
  cluster = {
    name               = "sammyaks"
    location           = "japan east"
    rgname             = "donotdeletemygroup"
    dns_prefix         = "sammyaksdns"
    kubernetes_version = "1.34.7"
    node_count         = 1
    vm_size            = "Standard_D2s_v6"
  }
}


acrs_values = {
  acr = {
    name     = "sameeracr"
    location = "japan east"
    rgname   = "donotdeletemygroup"
    sku      = "Basic"
  }
}


application_gateway_values = {
  appgw = {
    name     = "sammy-appgw"
    location = "japan east"
    rgname   = "donotdeletemygroup"

    vnet_name   = "aks-vnet-36135508"
    vnet_rgname = "MC_donotdeletemygroup_sammyaks_japaneast"
    subnet_name = "aks-appgateway"

    public_ip_name = "sammy-appgw-pip"

    sku_name = "Standard_v2"
    sku_tier = "Standard_v2"
    capacity = 2
  }
}
