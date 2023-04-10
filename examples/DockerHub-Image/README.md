## Deployment using Docker Hub Pre Built Container

The example below shows the required variables needed to deploy the solution when pulling the Subnet Router Tailscale container from [cocallaw/tailscale-sr on Docker Hub][1]

```hcl
module "subnet_router" {
  source  = "cocallaw/tailscale-subnet-router/azure"
  version = "1.4.0"

  resource_group_name               = "myresourcegroup"
  vnet_name                         = "myvnet"
  subnet_name                       = "mysubnet"
  storage_account_name              = "mystgacct"
  container_name                    = "mycontainer"
  container_size                    = "small"
  container_group_name              = "mycontainergroup"
  tailscale_hostname                = "mytailscalehostname"
  tailscale_advertise_routes        = "10.0.0.0/24"
  tailscale_auth_key                = "tskey-1234567890-ABCDEFGHIJKLMNOPQRSTUVXYZ"
}
```

[1]: https://hub.docker.com/r/cocallaw/tailscale-sr