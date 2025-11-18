module "createrg" {
    source = "../../Module/azurerm_resource_group"
    child_rg = var.root_rg
  
}
# module "createstg" {
#     depends_on = [ module.createrg ]
#     source = "../Module/azurerm_storage_Account"
#     child_stg = var.root_stg
  
# }

module "createvnet" {
    depends_on = [ module.createrg ]
    source = "../../Module/azurerm_virtual_network"
    child_vnet = var.root_vnet
}
module "createsubnet" {
    depends_on = [ module.createrg,module.createvnet ]
    source = "../../Module/azurerm_subnet"
    child_subnet = var.root_subnet 
}
module "createpip" {
    depends_on = [ module.createrg ]
    source = "../../Module/azurerm_Pip"
     child_pip = var.root_pip
    
}

# --------------
module "createfrntndvm"{
    depends_on = [ module.createrg ,module.createpip,module.createvnet,module.createsubnet]
    source = "../../Module/azurerm_virtual_machine"
    vms = var.root_vmstodo
    
}
# ---------------------
module "cretesqlserver" {
    depends_on = [ module.createrg,module.createsubnet ]
    source = "../../Module/azurerm_sqlserver"
    sqlserver  = var.root_sqlserver   
}
module "createdatabase" {
    depends_on = [ module.createrg,module.cretesqlserver,module.createsubnet ]
    source = "../../Module/azurerm_database"
    database11 = var.root_sqldatabase

#  server_id   = module.cretesqlserver.server_id
 }
  
