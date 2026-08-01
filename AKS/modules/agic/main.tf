resource "helm_release" "agic" {

  name       = "agic"
  repository = "oci://mcr.microsoft.com/azure-application-gateway/charts"
  chart      = "ingress-azure"

  namespace = "kube-system"

  values = [
    yamlencode({
      appgw = {
        subscriptionId = var.subscription_id
        resourceGroup  = var.resource_group_name
        name           = var.application_gateway_name
      }
      armAuth = {
        type             = "workloadIdentity"
        identityClientID = var.identity_client_id
      }
    })
  ]
}