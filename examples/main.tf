module "subnet_router" {
  source  = "cocallaw/tailscale-subnet-router/azure"
  version = "1.0"

  region                            = var.region
  resource_group_name               = var.resource_group_name
  vnet_name                         = var.vnet
  subnet_name                       = var.subnet_name
  storage_account_name              = var.storage_account_name
  container_name                    = var.container_name
  container_group_name              = var.container_group_name
  tailscale_ACR_repository          = var.tailscale_ACR_repository
  tailscale_image_tag               = var.tailscale_image_tag
  tailscale_ACR_repository_username = var.tailscale_ACR_repository_username
  tailscale_ACR_repository_password = var.tailscale_ACR_repository_password
  tailscale_hostname                = var.tailscale_hostname
  tailscale_advertise_routes        = var.tailscale_advertise_routes
  tailscale_auth_key                = var.tailscale_auth_key
}
