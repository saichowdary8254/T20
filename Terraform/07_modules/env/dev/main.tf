module "dev" {
    source = "../../webapp_module"
    rg_name = "DevRG"
    rg_location = "westus"
    asp_name = "devasp20"
    app_name = "nextopsdevapp20"
    os_type = "Linux"
    sku_name = "B1"  
}