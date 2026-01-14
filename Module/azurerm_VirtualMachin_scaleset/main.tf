 data "azurerm_key_vault" "kv" {
   for_each = var.vmScaleset
  name = each.value.kevault_name
  resource_group_name = each.value.resource_group_name
 }
  data "azurerm_subnet" "subnet" {
    for_each = var.vmScaleset
    name = each.value.subnet_name
    virtual_network_name = each.value.vnet_name
    resource_group_name = each.value.subnet_rgname
    
  }

data "key_vault_secret" "username" {
    for_each = var.vmScaleset
    name = azurerm_key_vault_secret.admin_User.name
    key_vault_Id = data.azurerm_key_vault.kv.id

  
}
data "azurerm_key_vault_secret" "userPassword" {
   for_each = var.vmScaleset
    name = azurerm_key_vault_secret.admin_User.name
    key_vault_id= data.azurerm_key_vault.kv.id
  
}

resource "azurerm_linux_virtual_machine_scale_set" "FrntndAppScaleset" {
    for_each = var.vmScaleset
    name = each.value.vmss_name
    location = each.value.location
    resource_group_name = each.value.azurerm_resource_group
    instances = 2
    sku = "Standard"
    admin_username =data.azurerm_key_vault_secret.username.value
    admin_password  =data.azurerm_key_vault_secret.userPassword.value
    disable_password_authentication = false
    source_image_reference {
      publisher = each.value.publisher
      offer = each.value.offer
      sku = each.value.sku_source
      version = each.value.version
    }
    network_interface {
      name = each.value.interface_name
      primary = each.value.primary
      ip_configuration {
        name = each.value.ipconfig_name
        primary = each.value.ipconfig_Primary
        subnet_id = dat
      }

    }
    os_disk {
      caching = each.value.osdiskcatching
      storage_account_type = each.value.stg_type
    }
    upgrade_mode = each.value.upgrade_mode
  
}