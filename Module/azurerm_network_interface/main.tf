data "azurerm_subnet" "subnet" {
#   for_each             = var.dataaccess
#   name                 = each.value.subnet_name
     name = "todosbunet"
#   virtual_network_name = each.value.vnet_name
     virtual_network_name = "todovnet"
     resource_group_name = "Todoinfra"  
#   resource_group_name  = each.value.rg_name
}

resource "azurerm_network_interface" "nic11" {

    for_each = var.child_nic
    name = each.value.nicname
    location = each.value.location
    resource_group_name = each.value.resource_group_name

    ip_configuration {        
      name =  "internal"
      subnet_id = data.azurerm_subnet.subnet[each.key].id
      private_ip_address_allocation = "Dynamic"
       public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
    }
  
}