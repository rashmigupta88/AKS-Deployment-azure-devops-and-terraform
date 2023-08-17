variable "rg_name" {
    default = "wordpress-site"
}

variable "location"{
    default = "CanadaCentral"
}
resource "azurerm_resource_group" "first_rg" {
  name     = var.rg_name
  location = var.location

  tags = {

      env = "staging"
      department = "hr"
  }
}

resource "azurerm_container_registry" "acr" {
  name                = "containerRegistryrashmi1"
  resource_group_name = azurerm_resource_group.first_rg.name
  location            = azurerm_resource_group.first_rg.location
  sku                 = "Standard"
  admin_enabled       = true

  
}

resource "azurerm_container_registry_scope_map" "scope_map" {
  name                    = "rashmi-scope-map"
  container_registry_name = azurerm_container_registry.acr.name
  resource_group_name     = azurerm_resource_group.first_rg.name
  actions = [
    "repositories/repo1/content/read",
    "repositories/repo1/content/write"
  ]
}

resource "azurerm_container_registry_token" "token" {
  name                    = "battoken"
  container_registry_name = azurerm_container_registry.acr.name
  resource_group_name     = azurerm_resource_group.first_rg.name
  scope_map_id            = azurerm_container_registry_scope_map.scope_map.id
}