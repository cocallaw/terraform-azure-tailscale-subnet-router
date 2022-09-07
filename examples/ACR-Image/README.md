## Deployment using Azure Container Registry (ACR)

The example below shows the required variables needed to deploy the solution when pulling the Subnet Router Tailscale container from an Azure Container Registry instance. The container must be built and pushed to ACR before deployment occurs.

```hcl
module "subnet_router" {
  source  = "cocallaw/tailscale-subnet-router/azure"
  version = "1.2.0"

  resource_group_name               = "myresourcegroup"
  vnet_name                         = "myvnet"
  subnet_name                       = "mysubnet"
  storage_account_name              = "mystorageacct"
  container_name                    = "mycontainer"
  container_size                    = "small"
  container_group_name              = "mycontainergroup"
  container_source                  = "ACR"
  tailscale_ACR_repository          = "myacr.azurecr.io/tailscale"
  tailscale_image_tag               = "latest"
  tailscale_ACR_repository_username = "myacrusername"
  tailscale_ACR_repository_password = "supersecretP@ssw0rd"
  tailscale_hostname                = "mytailscalehostname"
  tailscale_advertise_routes        = "10.0.0.0/24"
  tailscale_auth_key                = "tskey-1234567890-ABCDEFGHIJKLMNOPQRSTUVXYZ"
}

```