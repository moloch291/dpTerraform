output "resource_group_id" {
  value = "${azurerm_resource_group.rg.id}"
}

output "acr_id" {
  value = "${azurerm_container_registry.acr.id}"
}