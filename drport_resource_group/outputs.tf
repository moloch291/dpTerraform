output "resource_goup_id" {
  value = "${azurem_resource_group.rg.id}"
}

output "acr_id" {
  value = "${azurem_container_registry.acr.id}"
}
