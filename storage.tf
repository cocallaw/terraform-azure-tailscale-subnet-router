resource "azurerm_storage_account" "aci_storage" {
  count                    = var.enable_state_persistence ? 1 : 0
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = data.azurerm_virtual_network.vnet.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  lifecycle {
    precondition {
      condition     = !var.enable_state_persistence || var.storage_account_name != ""
      error_message = "storage_account_name is required when enable_state_persistence is true."
    }
  }
}

resource "azurerm_storage_share" "aci_share" {
  count                = var.enable_state_persistence ? 1 : 0
  name                 = "tailscale-data"
  storage_account_name = azurerm_storage_account.aci_storage[0].name
  quota                = 100
}