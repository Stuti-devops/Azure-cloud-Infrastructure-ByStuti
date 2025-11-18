root_rg = {
    rg1={
        resource_group_name = "TodoAppinfra11"
        location = "West Europe"
    }
    
}
root_stg = {
    stg1={
        storage_account_name = "todoinfrastg"
        resource_group_name = "TodoAppinfra11"
        location = "West Europe"
        account_tier = "Standard"
        account_replication_type = "LRS"
    }
}
root_vnet = {
    vnet1={
    virtual_network_name= "todovnet"
    resource_group_name = "TodoAppinfra11"
    location = "West Europe"
    address_space = ["10.0.0.0/16"]
    }
}
root_subnet = {
    subnet1 ={
         subnet_name = "frontsubnet"
         resource_group_name = "Todoappinfra11" 
         virtual_network_name = "todovnet"
         address_prefixes = ["10.0.1.0/26"]
    }
     subnet1 ={
         subnet_name = "backendsubnet"
         resource_group_name = "Todoappinfra11" 
         virtual_network_name = "todovnet"
         address_prefixes = ["10.0.2.0/26"]
    }
}
root_pip = {
    pip1 = {
      pipname = "frontendpip"
      location = "West Europe"
      resource_group_name = "TodoAppinfra11" 
    }
    pip1 = {
      pipname = "backendpip"
      location = "West Europe"
      resource_group_name = "TodoAppinfra11" 
    }
}
root_nic = {
  nic1 = {
    nicname = "nic-frontend-vm-01"
    resource_group_name = "TodoAppinfra11"
    location = "West Europe"
  }
  nic1 = {
    nicname = "nic-backend-vm-01"
    resource_group_name = "TodoAppinfra11"
    location = "West Europe"
  }
}
root_vmstodo = {
  vm1 = {
    nic_name       = "nic-frontend-vm-01"
    location       = "West Europe"
    rg_name        = "TodoAppinfra11"
    vnet_name      = "todovnet"
    subnet_name    = "frontsubnet"
    pip_name       = "frontendpip"
    vm_name        = "frontend-vm"
    size           = "Standard_B1s"
    admin_username = "adminstuti"
    admin_password = "st@1234"
    # source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    # }
  }
  vm2 = {
    nic_name       = "nic-backend-vm-01"
    location       = "West Europe"
    rg_name        = "TodoAppinfra11"
    vnet_name      = "todovnet"
    subnet_name    = "backendsubnet"
    pip_name       = "backendpip"
    vm_name        = "backend-vm"
    size           = "Standard_B1s"
    admin_username = "adminstuti"
    admin_password = "st@1234"
    # source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    # }
  }
}



    root_sqlserver = {
        sqlserver1 = {
            sql_server_name = "todoserver"
            resource_group_name = "TodoAppinfra11"
            location = "West Europe"
             version = "12.0"
             minimum_tls_version = "1.2"
            sql_admin_user = "Todoserveradmin"
            sql_admin_password = "@12345"
        }
         
  
    }
    root_sqldatabase = {
        sqldatabse1 = { 
            sql_databse_name = "frntndtodoinfrasqldatabase"
            sql_server_name = "todoserver"
            resource_group_name = "TodoAppinfra11"
            #  server_id    = var.server_id
             collation    = "SQL_Latin1_General_CP1_CI_AS"
             license_type = "LicenseIncluded"
             max_size_gb  = "2"
             sku_name     = "S0"
             enclave_type = "VBS"
        }

     
 
    }
