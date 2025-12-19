resource "azurerm_kubernetes_cluster" "namaks_cluster" {
    for_each = var.child_kubecluster
  name = each.value.akscluster_name
  location = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix = each.value.dns_prefix
  default_node_pool {
    name = each.value.default_Pool_name
    node_count = each.value.node_count
    vm_size = each.value.vm_size
  }
  # identity {
  #   type = each.value.type
  # }
 
}