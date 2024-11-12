resource "azurerm_virtual_network" "myfirstvnet" {
    name                = "TerraformVNET"
    resource_group_name = azurerm_resource_group.myfirstrg.name
    location            = azurerm_resource_group.myfirstrg.location
    address_space       = [ "10.0.0.0/16" ]
}

resource "azurerm_subnet" "myfirstsubnet" {
    name                    = "Subnet1"
    virtual_network_name    = azurerm_virtual_network.myfirstvnet.name
    resource_group_name     = azurerm_resource_group.myfirstrg.name
    address_prefixes        = [ "10.0.0.0/24" ]  
}

resource "azurerm_subnet" "mysecondsubnet" {
    name                    = "Subnet2"
    virtual_network_name    = azurerm_virtual_network.myfirstvnet.name
    resource_group_name     = azurerm_resource_group.myfirstrg.name
    address_prefixes        = [ "10.0.1.0/24" ]  
}

resource "azurerm_subnet" "mythirdsubnet" {
    name                    = "Subnet3"
    virtual_network_name    = azurerm_virtual_network.myfirstvnet.name
    resource_group_name     = azurerm_resource_group.myfirstrg.name
    address_prefixes        = [ "10.0.2.0/24" ]  
}

resource "azurerm_network_interface" "mynic" {
  name                = "nextopvm-nic"
  location            = azurerm_resource_group.myfirstrg.location
  resource_group_name = azurerm_resource_group.myfirstrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.myfirstsubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}