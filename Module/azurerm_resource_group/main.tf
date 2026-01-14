resource "azurerm_resource_group" "nammyrge" {
  for_each = var.rg
  name = each.value.resource_group_name
  location = each.value.location
}