
# resource "azurerm_public_ip" "lb_pip" {
#   for_each            = var.load_balancers
#   name                = "${each.key}-pip"
#   location            = each.value.location
#   resource_group_name = azurerm_resource_group.lb_rg[each.key].name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }
data "azurerm_public_ip" "lb_pip_data" {
  for_each            = var.load_balancers 
  name                = each.value.lb_public_ip_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_lb" "lb" {
  for_each            = var.load_balancers
  name                = each.value.load_balancer_name 
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  
    sku                 = each.value.sku

  frontend_ip_configuration {
   
     name                 = each.value.frontend_ip_configuration_name
    public_ip_address_id = data.azurerm_public_ip.lb_pip_data[each.key].id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  for_each        = var.load_balancers
 
  name            = each.value.backend_pool_name
  loadbalancer_id = azurerm_lb.lb[each.key].id
}
resource "azurerm_lb_probe" "http_probe" {
 
    for_each        = var.load_balancers
  name            = each.value.health_Probe
  loadbalancer_id = azurerm_lb.lb[each.key].id
  protocol        = each.value.protocol
  port            = each.value.port
  request_path    = each.value.request_path
}
resource "azurerm_lb_rule" "http_rule" {
  for_each                       = var.load_balancers

   name                           = each.value.loadbalncer_rule
  loadbalancer_id                = azurerm_lb.lb[each.key].id
  protocol                       = each.value.lbrule_Protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name

  backend_address_pool_ids = [
    azurerm_lb_backend_address_pool.backend_pool[each.key].id
  ]

  probe_id = azurerm_lb_probe.http_probe[each.key].id
}
# ------------attach with vm------------------------------------------
# resource "azurerm_network_interface_backend_address_pool_association" "nic_lb_assoc" {
#   for_each                = azurerm_network_interface.nic
#   network_interface_id    = each.value.id
#   ip_configuration_name   = "internal"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool["lb1"].id
# }
