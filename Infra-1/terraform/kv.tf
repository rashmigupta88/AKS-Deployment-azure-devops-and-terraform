data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "kv" {
  name                       = "examplekeyvault"
  location                   = azurerm_resource_group.first_rg.location
  resource_group_name        = azurerm_resource_group.first_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]
  }
}

resource "azurerm_key_vault_secret" "token" {
  name         = "acr-username"
  value        =  azurerm_container_registry_token.token.name
  key_vault_id = azurerm_key_vault.kv.id
}