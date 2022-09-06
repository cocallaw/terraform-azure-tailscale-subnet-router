locals {
  container_image         = "${var.tailscale_ACR_repository}:${var.tailscale_image_tag}"
  image_registry_username = var.container_source == "DockerHub" ? null : var.tailscale_ACR_repository_username
  image_registry_password = var.container_source == "DockerHub" ? null : var.tailscale_ACR_repository_password
  image_registry_server   = var.container_source == "DockerHub" ? null : split("/", var.tailscale_ACR_repository)[0]

  beta_container_image = {
    "DockerHub" = "cocallaw/tailscale-sr:latest"
    "ACR"       = "${var.tailscale_ACR_repository}:${var.tailscale_image_tag}"
  }

  aci_cpu_cores = {
    "small"  = "1.0"
    "medium" = "2.0"
    "large"  = "3.0"
  }
  aci_memory_size = {
    "small"  = "1.0"
    "medium" = "2.0"
    "large"  = "4.0"
  }
}

resource "azurerm_container_group" "containergroup" {
  name                = var.container_group_name
  location            = data.azurerm_virtual_network.vnet.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Private"
  os_type             = "Linux"
  network_profile_id  = azurerm_network_profile.acg_network_profile.id

  container {
    name   = var.container_name
    image  = local.beta_container_image[var.container_source]
    cpu    = local.aci_cpu_cores[var.container_size]
    memory = local.aci_memory_size[var.container_size]

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

  dynamic "image_registry_credential" {
    for_each = var.container_source == "DockerHub" ? [] : [1]
    content {
      server   = local.image_registry_server
      username = local.image_registry_username
      password = local.image_registry_password
    }
  }
}
