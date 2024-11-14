resource "azurerm_resource_group" "rg" {
    name        = var.rg_name 
    location    = var.rg_location  
}

resource "azurerm_virtual_network" "vnet" {
    name                = var.vnet_name 
    resource_group_name = azurerm_resource_group.rg.name 
    location            = azurerm_resource_group.rg.location
    address_space       = var.address_space
}

resource "azurerm_subnet" "subnet" {
    count     =   length(var.subnet_name) # 4
    name      =   var.subnet_name[count.index] # var.subnet_name[0] = subnet1, var.subnet_name[1] = subnet2  
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = [ "10.100.${count.index}.0/24" ]
}

resource "azurerm_network_interface" "nic" {
    count   = 4
    name    = "my-nic-${count.index}"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
      name = "my-ip-config"
      subnet_id = azurerm_subnet.subnet[count.index].id
      private_ip_address_allocation = "Dynamic"
    }  
}

resource "azurerm_linux_virtual_machine" "vm" {
  count                 = 4 # [0,1,2,3]
  name                  = "my-vm-${count.index}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  size                  = "Standard_B1s"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]

  admin_ssh_key {
    username   = "adminuser"
    # ssh-keygen -t rsa -f C:\Terraform\SSHKeys\id_rsa  <-- command to generate keys in windows
    public_key = file("C:/Terraform/SSHKeys/id_rsa.pub") 
  }

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
  
}