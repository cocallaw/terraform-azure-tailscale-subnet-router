# Terraform module for Tailscale subnet router in ACI
[![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/cocallaw/tailscale-subnet-router/azure/)
[![GitHub license](https://img.shields.io/github/license/cocallaw/terraform-azure-tailscale-subnet-router?color=orange)](https://github.com/cocallaw/terraform-azure-tailscale-subnet-router/blob/main/LICENSE)

This module deploys a Tailscale [subnet router][1] as an [Azure Container Instance][2]. The subnet router ACI instance is deployed into an existing Azure Virtual Network and advertises to your Tailnet the CIDR block for the Azure VNet.

## Usage
To use this module, you must have a Tailscale account to generate a Tailscale auth key, and you must have an existing Azure Virtual Network to associate the ACI Subnet Router with.

### Minimum Required Configuration
The following configuration is the minimum required to deploy a Tailscale subnet router ACI instance into an existing Azure Virtual Network.

```hcl
module "subnet_router" {
  source  = "cocallaw/tailscale-subnet-router/azure"
  version = "1.2.0"

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

## Docker Container
The `docker/Dockerfile` file extends the `tailscale/tailscale`
[image][3] with an entrypoint script that starts the Tailscale daemon and runs
`tailscale up` using an [auth key][4] and the relevant advertised [CIDR block][5].

By default the module will pull the Subnet Router Docker image from [cocallaw/tailscale-sr on Docker Hub][6]. If you prefer to build and push the Docker image to your own Azure Container Registry, you can use the `container_source` variable to specify `ACR` instead of `DockerHub`.

### Build locally with Docker and [push image to ACR][7]
```bash
docker build \
  --tag tailscale-subnet-router:v1 \
  --file Dockerfile \
  .

# Optionally override the tag for the base `tailscale/tailscale` image
docker build \
  --build-arg TAILSCALE_TAG=v1.29.18 \
  --tag tailscale-subnet-router:v1 \
  --file ./docker/tailscale.Dockerfile \
  .
```

### Build remotely using [Azure Container Registry Tasks][8] with Azure CLI
```bash
ACR_NAME=<registry-name>
az acr build --registry $ACR_NAME --image tailscale:v1 .

# Optionally override the tag for the base `tailscale/tailscale` image
ACR_NAME=<registry-name>
az acr build --registry $ACR_NAME --build-arg TAILSCALE_TAG=v1.29.18 --image tailscale:v1 .
```

## ACI Size
The size of the Tailscale ACI container instance can be set using the `container_size` variable, with the values `small`, `medium` or `large`. The CPU and Memory values for S/M/L are defined in `aci.tf`, and can be adjusted by changing the local variable maps for `aci_cpu_cores` and `aci_memory_size`. 
```bash
  aci_cpu_cores = {
    "small" = "1.0"
    "medium" = "2.0"
    "large" = "3.0"
  }
  aci_memory_size = {
    "small" = "1.0"
    "medium" = "2.0"
    "large" = "4.0"
  }
```
 
## Subnet Delegation 
To assist with the deployment of the ACI container group in the Azure VNet, the subnet being used should be [delegated][9] to the `Microsoft.ContainerInstance/containerGroups`.
```bash
# Update the subnet with a delegation for Microsoft.ContainerInstance/containerGroups
az network vnet subnet update \
  --resource-group myResourceGroup \
  --name mySubnet \
  --vnet-name myVnet \
  --delegations Microsoft.ContainerInstance/containerGroups

# Verify that the subnet is now delegated to the ACI instance
  az network vnet subnet show \
  --resource-group myResourceGroup \
  --name mySubnet \
  --vnet-name myVnet \
  --query delegations
```    
## Notes

- The Tailscale state (`/var/lib/tailscale`) is stored in a [Azure File Share][10] in a Storage Account so that the subnet router only needs to be [authorized][11] once.

- The module will use the Region of the existing Azure Virtual Network specified in the variable `vnet_name`, as the region to deploy resources.
## Improvements Needed

### Container Registry Authentication
Currently the module supports using a username and password to authenticate to the ACR repository, and the server URL is derived from the ACR repository name.
- Validation testing needed for use with Docker Hub
- Add Option to use [anonymous pull][12] with ACR
- Investigate using a service principal to authenticate to the ACR repository
- Investigate support for using a [Managed Identity to authenticate to the ACR repository][13]


[1]: https://tailscale.com/kb/1019/subnets/
[2]: https://docs.microsoft.com/azure/container-instances/container-instances-overview
[3]: https://hub.docker.com/r/tailscale/tailscale
[4]: https://tailscale.com/kb/1085/auth-keys/
[5]: https://tailscale.com/kb/1019/subnets/
[6]: https://hub.docker.com/r/cocallaw/tailscale-sr
[7]: https://docs.microsoft.com/azure/container-registry/container-registry-get-started-docker-cli?tabs=azure-cli
[8]: https://docs.microsoft.com/azure/container-registry/container-registry-tutorial-quick-task
[9]: https://docs.microsoft.com/azure/virtual-network/subnet-delegation-overview
[10]: https://docs.microsoft.com/azure/storage/files/storage-files-introduction
[11]: https://tailscale.com/kb/1099/device-authorization/
[12]: https://docs.microsoft.com/azure/container-registry/anonymous-pull-access
[13]: https://github.com/hashicorp/terraform-provider-azurerm/issues/15915
