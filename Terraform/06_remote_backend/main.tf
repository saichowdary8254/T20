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
    address_space            = ["10.1.0.0/16"] 
}

resource "azurerm_subnet" "mysubnet" {
   name                     = join("_",[local.prefix,"Subnet01"]) #nextops_Subnet01
   virtual_network_name     = local.vnet_name
   resource_group_name      = local.rg_name
   address_prefixes         = ["10.1.0.0/24"]
}

resource "azurerm_network_interface" "mynic" {
  name                = "nextopvm-nic"
  location            = local.rg_location
  resource_group_name = local.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "myvm" {
  name                = "nextopslvmt21"
  resource_group_name = local.rg_name
  location            = local.rg_location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "xxxxxxxxxxx"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.mynic.id,
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