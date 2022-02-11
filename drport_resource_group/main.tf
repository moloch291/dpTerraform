resource "azurerm_resource_group" "rg" {
	name     = "${var.resource_group_name}"
	location = "${var.location}"

	tags = {
		Name        = "${var.resource_group_name}-${var.location}"
		Environment = "${var.env}"
	}
}

resource "azurerm_container_registry" "acr" {
  depends_on          = [azurem_resource_group.rg]
  name                = "${var.acr_name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"

  tags = {
    Name        = "${var.acr_name}-${var.location}"
    Environment = "${var.env}"
  }
}