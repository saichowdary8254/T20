# Resource Group
resource "azurerm_resource_group" "example" {
  name     = "myrG"
  location = "westus"
}

# App Service Plan
resource "azurerm_service_plan" "example" {
  name                = "nextopsmyasp01"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  os_type             = "Linux"
  sku_name            = "B1" # Premium SKU for production workloads
}

# App Service for Node.js Web App
resource "azurerm_linux_web_app" "example" {
  name                = "nextopsmywa01"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  service_plan_id     = azurerm_service_plan.example.id

  site_config {

  }
  # site_config {
  #   application_stack {
  #     node_version = "18-lts" # Node.js 18 LTS version
  #   }

  #   # Add a startup command here
  #   app_command_line = "pm2 serve /home/site/wwwroot/browser --no-daemon --spa" # Replace with your startup command
  # }

  # app_settings = {
  #   "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  #   "WEBSITE_NODE_DEFAULT_VERSION"        = "~18"
  # }

  # identity {
  #   type = "SystemAssigned"
  # }

  # tags = {
  #   environment = "production"
  # }
}
