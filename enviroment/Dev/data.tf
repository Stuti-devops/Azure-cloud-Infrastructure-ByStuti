# variable "dataaccess" {
#   name = string
#   virtual_network_name = string

# }
# data "azurerm_subnet" "subnet" {
#   for_each             = var.dataaccess
#   name                 = each.value.subnet_name
     # name = "todosbunet"
#   virtual_network_name = each.value.vnet_name
# virtual_network_name = "todovnet"
# resource_group_name = "Todoinfra"  
#   resource_group_name  = each.value.rg_name
# }

# data "azurerm_public_ip" "pip" {
#  for_each            = var.dataaccess
#   name                = each.value.pip_name
#   resource_group_name = each.value.rg_name
# }
