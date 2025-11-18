resource "azurerm_public_ip" "pip" {
    for_each = var.child_pip
    # name = lookup(each.value, "pipname", "pip-${each.key}")
   name                = each.value.pipname
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  
}