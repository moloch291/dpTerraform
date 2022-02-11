##### Resource group: #####
resource "azurerm_resource_group" "rg" {
	name     = "${var.resource_group_name}"
	location = "${var.location}"

	tags = {
		Name        = "${var.resource_group_name}-${var.location}"
		Environment = "${var.env}"
	}
}
##### ACR: #####
resource "azurerm_container_registry" "acr" {
  depends_on          = [azurem_resource_group.rg]
  name                = "${var.acr_name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "${var.acr_sku_tier}"

  tags = {
    Name        = "${var.acr_name}-${var.location}"
    Environment = "${var.env}"
  }
}
##### SQL: #####
resource "azurerm_mssql_server" "mssql_server" {
  depends_on                   = [azurem_resource_group.rg]
  name                         = "${var.mssql_name}-server"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "${var.mssql_admin_login}"
  administrator_login_password = "${var.mssql_admin_login_pw}"

  tags = {
    Name        = "${var.mssql_name}-server"
    Environment = "${var.env}"
  }
}
resource "azurerm_mssql_database" "mssql_db" {
  depends_on     = [azurerm_mssql_server.mssql_server]
  name           = "${var.mssql_name}-db"
  server_id      = azurerm_mssql_server.mssql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = var.mssql_max_size
  read_scale     = (var.is_premium_or_business_crit_tier ? true : false)
  sku_name       = "${var.general_tier}"
  zone_redundant = (var.is_premium_or_business_crit_tier ? true : false)

  tags = {
    Name        = "${var.mssql_name}-db"
    Environment = "${var.env}"
  }
}
##### App service: #####
resource "azurerm_app_service_plan" "drp_svc_plan" {
  depends_on          = [azurem_resource_group.rg]
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "${var.app_svc_plan_kind}"

  sku {
    tier = "${var.svc_plan_sku_tier}"
    size = "${var.svc_plan_sku_size}"
  }

  tags = {
    Name        = "${var.mssql_name}-db-svc-plan"
    Environment = "${var.env}"
  }
}

resource "azurerm_app_service" "example" {
  depends_on          = [azurerm_app_service_plan.drp_svc_plan]
  name                = "example-app-service"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.drp_svc_plan.id

  dynamic "app_settings" {
    for_each = len(var.env_vars[var.env]) > 0 ? [true] : []

    content {
      name      = var.env_vars[var.env].name
      age       = var.env_vars[var.env].age
      direction = var.env_vars[var.env].direction
    }
  }

  connection_string {
    name  = "${var.mssql_name}-db-connnection-string"
    type  = "SQLServer"
    value = "${var.connection_string}"
  }

  tags = {
    Name        = "${var.mssql_name}-db-svc"
    Environment = "${var.env}"
  }
}
