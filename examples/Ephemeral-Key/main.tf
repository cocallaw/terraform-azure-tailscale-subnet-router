provider "azurerm" {
  features {}
  # subscription_id = "00000000-0000-0000-0000-000000000000" # Optional: specify subscription ID if needed
}

module "subnet_router" {
  source  = "cocallaw/tailscale-subnet-router/azure"
  version = "1.5.0"

  resource_group_name        = "myresourcegroup"
  vnet_name                  = "myvnet"
  subnet_name                = "mysubnet"
  container_name             = "mycontainer"
  container_size             = "small"
  container_group_name       = "mycontainergroup"
  tailscale_hostname         = "mytailscalehostname"
  tailscale_advertise_routes = "10.0.0.0/24"
  tailscale_auth_key         = "tskey-1234567890-ABCDEFGHIJKLMNOPQRSTUVXYZ"
  enable_state_persistence   = false
}
