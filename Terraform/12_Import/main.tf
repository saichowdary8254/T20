resource "azurerm_resource_group" "rg1" {
    name = "ImportRG"
    location = "eastus" 

    tags = {
        env = "dev",
    } 
}

resource "azurerm_virtual_network" "vnet1" {
    name = "ImportVNET"
    resource_group_name = azurerm_resource_group.rg1.name
    location = azurerm_resource_group.rg1.location
    address_space = [ "10.30.0.0/16" ]  
}

resource "azurerm_subnet" "subnet1" {
    name = "Subnet1"
    resource_group_name = azurerm_resource_group.rg1.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes = [ "10.30.0.0/24" ]
}

resource "azurerm_subnet" "subnet2" {
    name = "Subnet2"
    resource_group_name = azurerm_resource_group.rg1.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes = [ "10.30.1.0/24" ]
}

resource "azurerm_network_interface" "nic1" {
    name = "importvm954"
    resource_group_name = azurerm_resource_group.rg1.name
    location = azurerm_resource_group.rg1.location
    ip_configuration {
        name                          = "ipconfig1"
        subnet_id                     = azurerm_subnet.subnet1.id
        private_ip_address_allocation = "Dynamic"
    }  
}