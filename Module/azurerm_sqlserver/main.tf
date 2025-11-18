
resource "azurerm_mssql_server" "sql_server11" {
    for_each = var.sqlserver
  name                         = each.value.sql_server_name
  resource_group_name           = each.value.resource_group_name
  location                     = each.value.location
  version                      = "12.0"
  administrator_login           = each.value.sql_admin_user
  administrator_login_password  = each.value.sql_admin_password
}

