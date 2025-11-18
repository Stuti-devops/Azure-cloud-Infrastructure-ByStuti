terraform{
        required_providers{

        azurerm ={
            source = "hashicorp/azurerm"
            version = "4.34.0"
        }
    }
     backend "azurerm" {
    resource_group_name  = "stutiRgfrpipeline"       # Replace with your resource group name
    storage_account_name = "stutipipelinestg"       # Replace with your storage account name
    container_name       = "stutipipelinecontainer"               # Replace with your container name
    key                  = "stutipipeline.tfstate"      # Path to the state file in the container
       
  }
}


provider "azurerm" {
    features {
      
    }
    subscription_id = "d7b038b3-220d-47fb-8d8a-df373fd719c8"
  # Configuration options
}

