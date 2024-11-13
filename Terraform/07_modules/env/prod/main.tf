module "prod" {
    source = "../../webapp_module"
    rg_name = "ProdRG"
    rg_location = "westus"
    asp_name = "prodasp20"
    app_name = "nextopsprodapp20"
    os_type = "Linux"
    sku_name = "P0v3"  
}