resource "azurerm_resource_group" "rg" {
	name     = "${var.resource_group_name}"
	location = "${var.region}"

	tags = {
		Name = "${var.resource_group_name}-${var.region}"
		Environment = "${var.env}"
	}
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.acr_name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Premium" # ?

  tags = {
    Name = "${var.acr_name}-${var.region}"
    Environment = "${var.env}"
  }
}