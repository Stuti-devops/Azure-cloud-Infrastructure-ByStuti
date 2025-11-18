
data "azurerm_mssql_server" "sqlserver" {
     for_each = var.database11
  name                = each.value.sql_server_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_mssql_database" "db11" {
   depends_on = [ data.azurerm_mssql_server.sqlserver ]
  for_each   = var.database11
  name       = each.value.sql_databse_name
#   server_id  = azurerm_mssql_server.sql_server.id
# resource_group_name = each.value.
    server_id  = data.azurerm_mssql_server.sqlserver[each.key].id
    max_size_gb  = each.value.max_size_gb
  collation  = each.value.collation
  sku_name   = each.value.sku_name
   license_type =each.value.license_type
  enclave_type = each.value.enclave_type



   
}