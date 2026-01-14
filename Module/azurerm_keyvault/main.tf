data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "keyvault" {
    for_each = var.kv
  name = each.value.kevault_name
  location = each.value.location
  resource_group_name = each.value.resource_group_name
  tenant_id = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption = true
  soft_delete_retention_days = 7
  purge_protection_enabled = false
  sku_name = "standard"
access_policy {
tenant_id = data.azurerm_client_config.current.tenant_id
object_id = data.azurerm_client_config.current.object_id

key_permissions = ["Get"]
secret_permissions = ["Get", "Set","List",]
}
#   access_policy  {
#     # tenant_ID = data.azurerm_client_config.current.tenant_ID
#     # client_Id = data.azurerm_client_config.current.client_Id
#     tenant_id = data.azurerm_client_config.current.tenant_id
#     # client_id = data.azurerm_client_config.current.client_id
  
#   key_permission =[
#        "Get",
#   ]
#   secret_permission = [
#     "Get","set"
#   ]
#   storage_permission =[
#     "Get",
#   ]
# }

 }
# output "key_vault_id" {
#   value = azurerm_key_vault.keyvault[each.key].id
# }