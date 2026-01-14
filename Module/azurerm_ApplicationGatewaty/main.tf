# resource "azurerm_resource_group" "appgw_rg" {
#   for_each = var.app_gateways
#   name     = each.value.rg_name
#   location = each.value.location
# }
data "azurerm_public_ip" "appgateway_pip_data" {
   for_each            = var.app_gateways
  name                = each.value.appgatwway_public_ip_name
  resource_group_name = each.value.resource_group_name
}
data "azurerm_virtual_network" "vnet" {
  for_each            = var.app_gateways
  # name                = "${each.key}-vnet"
  # location            = each.value.location
  # resource_group_name = azurerm_resource_group.appgw_rg[each.key].name
  # address_space       = [each.value.vnet_cidr]
  name = each.value.virtual_network_name
  # location= each.value.location
  resource_group_name = each.value.resource_group_name

}

data "azurerm_subnet" "app_gateways_subnet" {
  for_each             = var.app_gateways
  # name                 = "appgw-subnet"
  # resource_group_name  = azurerm_resource_group.appgw_rg[each.key].name
  # virtual_network_name = azurerm_virtual_network.vnet[each.key].name
  # address_prefixes     = [each.value.subnet_cidr]
 name                 = each.value.subnet
 resource_group_name  =each.value.resource_group_name
virtual_network_name = each.value.virtual_network_name
#  address_prefixes     = [each.value.subnet_cidr]
}

# resource "azurerm_public_ip" "appgw_pip" {
#   for_each            = var.app_gateways
#   name                = "${each.key}-pip"
#   location            = each.value.location
#   resource_group_name = azurerm_resource_group.appgw_rg[each.key].name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

resource "azurerm_application_gateway" "appgw" {
  for_each            = var.app_gateways
  name                = each.value.appgatewayname
  location            = each.value.location
  # resource_group_name = azurerm_resource_group.appgw_rg[each.key].name
  resource_group_name = each.value .resource_group_name

  sku {
    # name     = "Standard_v2"
    # tier     = "Standard_v2"
    # capacity = 2
     name     = each.value.sku_name
    tier     =each.value.sku_tier
    capacity = each.value.sku_capacity
  }

  gateway_ip_configuration {
    # name      = "gw-ip"
    # subnet_id = azurerm_subnet.subnet[each.key].id
     name      = each.value.gateway_ip_configuration
    subnet_id = data.azurerm_subnet.app_gateways_subnet[each.key].id
  }

  frontend_port {
    # name = "http-port"
    # port = 80
     name =each.value.frontend_port_name
    port =each.value.frontend_port
  }

  frontend_ip_configuration {
    name                 = each.value.frontend_ip_configuration_name
    public_ip_address_id = data.azurerm_public_ip.appgateway_pip_data[each.key].id
  }

  backend_address_pool {
    # name = "backend-pool"
    name = each.value.backend_address_pool_name
  }

  backend_http_settings {
    # name     = "http-setting"
    # port     = 80
    # protocol = "Http"
    # cookie_based_affinity = "Disabled"
     name     = each.value.backend_http_settings_name
    port     = each.value.backend_Port
    protocol = each.value.protocol
    cookie_based_affinity = each.value.cookie_based_affinity

  }

  http_listener {
    # name                           = "http-listener"
    # frontend_ip_configuration_name = "frontend-ip"
    # frontend_port_name             = "http-port"
    # protocol                       = "Http"
      name                           = each.value.http_listener_name
    frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
    frontend_port_name             = each.value.frontend_port_name
    protocol                       = each.value.frotnend_protocol
  }

  request_routing_rule {
    # name                       = "rule1"
    # rule_type                  = "Basic"
    # http_listener_name         = "http-listener"
    # backend_address_pool_name  = "backend-pool"
    # backend_http_settings_name = "http-setting"
    # priority                   = 100
    name                       = each.value.request_routing_rule_name
    rule_type                  = each.value.request_routing_rule_type
    http_listener_name         = each.value.request_routing_rule_http_listener_name
    backend_address_pool_name  = each.value.backend_address_pool_name
    backend_http_settings_name = each.value.backend_http_settings_name
    priority                   = each.value.request_priority
  }
}
