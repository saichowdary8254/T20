module "qa" {
    source = "../../webapp_module"
    rg_name = "QaRG"
    rg_location = "westus"
    asp_name = "qaasp20"
    app_name = "nextopsqaapp20"
    os_type = "Linux"
    sku_name = "B1"  
}