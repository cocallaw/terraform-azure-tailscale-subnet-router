resource_group_name               = "terraform-test-group"
vnet_name                         = "myVnet"
subnet_name                       = "mySubnet"
storage_account_name              = "myStorageAccount"
container_name                    = "tailscale"
container_size                    = "small"
container_group_name              = "myContainerGroup"
tailscale_ACR_repository          = "myacr.azurecr.io/tailscale"
tailscale_image_tag               = "v1"
tailscale_ACR_repository_username = "myacr"
tailscale_ACR_repository_password = ""
tailscale_hostname                = "tailscaleACI"
tailscale_advertise_routes        = "10.0.0.0/20"
tailscale_auth_key                = ""