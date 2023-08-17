resource "azurerm_kubernetes_cluster" "rashmiaks" {
  name                = "rashmiaks1"
  location            = azurerm_resource_group.first_rg.location
  resource_group_name = azurerm_resource_group.first_rg.name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "rashmipool1"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "staging"
  }
}
