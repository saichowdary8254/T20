resource "azurerm_resource_group" "rg1" {
   name = "TFRG"
   location = "westus"

   tags = {
     env = "dev"
   }
}

resource "azurerm_virtual_network" "vnet1" {
   name = "NextOpsVNETT21"
   location = azurerm_resource_group.rg1.location
   resource_group_name = azurerm_resource_group.rg1.name
   address_space = [ "10.11.0.0/16" ]
}

resource "azurerm_subnet" "subnet1" {
   name = "Subnet01"
   resource_group_name = azurerm_resource_group.rg1.name
   virtual_network_name = azurerm_virtual_network.vnet1.name
   address_prefixes = [ "10.11.0.0/24" ]
}


resource "azurerm_subnet" "subnet2" {
   name = "Subnet02"
   resource_group_name = azurerm_resource_group.rg1.name
   virtual_network_name = azurerm_virtual_network.vnet1.name
   address_prefixes = [ "10.11.1.0/24" ]
}

resource "azurerm_subnet" "subnet3" {
   name = "Subnet03"
   resource_group_name = azurerm_resource_group.rg1.name
   virtual_network_name = azurerm_virtual_network.vnet1.name
   address_prefixes = [ "10.11.2.0/24" ]
}

resource "azurerm_subnet" "subnet4" {
   name = "Subnet04"
   resource_group_name = azurerm_resource_group.rg1.name
   virtual_network_name = azurerm_virtual_network.vnet1.name
   address_prefixes = [ "10.11.3.0/24" ]
}


