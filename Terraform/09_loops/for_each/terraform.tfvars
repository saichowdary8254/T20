resourcedetails = {
  "eastus" = {
    rg_name        = "east-rg"
    rg_location    = "eastus"
    vnet_name      = "east-vnet"
    address_space  = ["10.11.0.0/16"]
    subnet_name    = "eussubnet1"
    address_prefix = ["10.11.0.0/24"]
    vm_name        = "east-vm"
    size           = "Standard_B1s"
  }
  "westus" = {
    rg_name        = "west-rg"
    rg_location    = "westus"
    vnet_name      = "west-vnet"
    address_space  = ["10.12.0.0/16"]
    subnet_name    = "wussubnet1"
    address_prefix = ["10.12.0.0/24"]
    vm_name        = "west-vm"
    size           = "Standard_B2s"
  }
}
