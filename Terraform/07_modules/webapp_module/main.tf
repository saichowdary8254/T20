resource "azurerm_resource_group" "myrg" {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_service_plan" "myasp" {
  name                = var.asp_name
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  os_type             = var.os_type
  sku_name            = var.sku_name
}

resource "azurerm_linux_web_app" "myapp" {
  name                = var.app_name
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_service_plan.myasp.location
  service_plan_id     = azurerm_service_plan.myasp.id

  site_config {}
}