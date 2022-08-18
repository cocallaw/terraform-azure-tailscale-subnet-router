resource "azurerm_storage_account" "aci_storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}

resource "azurerm_storage_share" "aci_share" {
  name                 = "tailscale-data"
  storage_account_name = azurerm_storage_account.aci_storage.name
  quota                = 100
}