resource "azurerm_resource_group" "myrg" {
    name        = var.rg_name
    location    = var.rg_location  
}

locals {
    rg_name     = azurerm_resource_group.myrg.name 
    rg_location = azurerm_resource_group.myrg.location
    vnet_name   = azurerm_virtual_network.myvnet.name
    prefix      = "nextops"
}

resource "azurerm_virtual_network" "myvnet" {
    name                     = join("_",[local.prefix,var.vnet_name]) #nextops_VNET
    resource_group_name      = local.rg_name
    location                 = local.rg_location
    address_space            = ["10.0.0.0/16"] 
}

resource "azurerm_subnet" "mysubnet" {
   name                     = join("_",[local.prefix,"Subnet01"]) #nextops_Subnet01
   virtual_network_name     = local.vnet_name
   resource_group_name      = local.rg_name
   address_prefixes         = ["10.0.0.0/24"]
}
