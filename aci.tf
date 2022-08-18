locals {
  container_image = "${var.tailscale_ACR_repository}:${var.tailscale_image_tag}"
}

resource "azurerm_container_group" "containergroup" {
  name                = var.container_group_name
  location            = var.region
  resource_group_name = var.resource_group_name
  ip_address_type     = "Private"
  os_type             = "Linux"
  network_profile_id  = azurerm_network_profile.acg_network_profile.id

  container {
    name   = var.container_name
    image  = local.container_image
    cpu    = 1.0
    memory = 1.0

    ports {
      port     = 443
      protocol = "TCP"
    }

    environment_variables = {
      "TAILSCALE_HOSTNAME"         = var.tailscale_hostname
      "TAILSCALE_ADVERTISE_ROUTES" = var.tailscale_advertise_routes
    }

    secure_environment_variables = {
      "TAILSCALE_AUTH_KEY" = var.tailscale_auth_key
    }

    volume {
      name                 = "tailscale-volume"
      mount_path           = "/var/lib/tailscale"
      storage_account_name = azurerm_storage_account.aci_storage.name
      storage_account_key  = azurerm_storage_account.aci_storage.primary_access_key
      share_name           = azurerm_storage_share.aci_share.name
    }
  }

  image_registry_credential {
    username = var.tailscale_ACR_repository_username
    password = var.tailscale_ACR_repository_password
    server   = split("/", var.tailscale_ACR_repository)[0]
  }
}
