data "azurerm_key_vault" "azkve" {
  for_each = var.key_vault_secret
  name = each.value.kevault_name
  resource_group_name = each.value.resource_group_name
}
 resource "random_uuid" "secret" {
  for_each = var.key_vault_secret
 }
 resource "azurerm_key_vault_secret" "admin_User" {
   for_each = var.key_vault_secret
   name = each.value.user_name
   value = "StutiVMSS-${random_uuid.secret[each.key].result}"
   key_vault_id = data.azurerm_key_vault.azkve[each.key].id
 }
resource "azurerm_key_vault_secret" "user_Password" {
  for_each = var.key_vault_secret
   name         = each.value.user_Password
 
  value        = "StutiTodo-${random_uuid.secret[each.key].result}"
  key_vault_id = data.azurerm_key_vault.azkve[each.key].id
}