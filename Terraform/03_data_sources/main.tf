data "azurerm_resource_group" "existingrg"{
    name = "existingrg"
}

data "azurerm_virtual_network" "existingvnet" {
    name = "ExistingVNET01"
    resource_group_name = data.azurerm_resource_group.existingrg.name 
}

data "azurerm_subnet" "existingsubnet" {
    name = "default"
    resource_group_name = data.azurerm_resource_group.existingrg.name 
    virtual_network_name = data.azurerm_virtual_network.existingvnet.name
}

data "azurerm_subnet" "existingsubnet2" {
    name = "subnet2"
    resource_group_name = data.azurerm_resource_group.existingrg.name 
    virtual_network_name = data.azurerm_virtual_network.existingvnet.name
}

resource "azurerm_network_interface" "newnic" {
    name                = "nextopvm-nic1"
    location            = data.azurerm_resource_group.existingrg.location
    resource_group_name = data.azurerm_resource_group.existingrg.name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = data.azurerm_subnet.existingsubnet.id
        private_ip_address_allocation = "Dynamic"
    }  
}

resource "azurerm_linux_virtual_machine" "newvm" {
  name                = "nextopslvmt10"
  resource_group_name = data.azurerm_resource_group.existingrg.name
  location            = data.azurerm_resource_group.existingrg.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  admin_password      = "xxxxxxxxx"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.newnic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {"environment" = "prod"}
}