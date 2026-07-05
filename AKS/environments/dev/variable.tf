variable "resource_groups_values" {
  type = map(object({
    rgname   = string
    location = string
  }))
}

variable "acrs_values" {
  type = map(object({
    name     = string
    location = string
    rgname   = string
    sku      = string
  }))
}


variable "aks_clusters_values" {

  type = map(object({
    name               = string
    location           = string
    rgname             = string
    dns_prefix         = string
    kubernetes_version = string
    node_count         = number
    vm_size            = string
  }))
}

