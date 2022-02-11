resource "azurerm_resource_group" "resource_group" {
	name     = "${var.resource_group_name}"
	location = "${var.region}"

	tags = {
		Name = "${var.resource_group_name}-${var.region}"
	}
}

