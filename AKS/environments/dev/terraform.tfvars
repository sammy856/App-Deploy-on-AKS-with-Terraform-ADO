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

