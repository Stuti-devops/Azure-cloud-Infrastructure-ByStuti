resource "azurerm_container_registry" "ACR" {
  
  for_each            = var.child_ACR
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku
  admin_enabled       = each.value.admin_enabled
}
