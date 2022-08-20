# Terraform module for Tailscale subnet router in ACI
[![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/cocallaw/tailscale-subnet-router/azure/)
[![GitHub license](https://img.shields.io/github/license/cocallaw/terraform-azure-tailscale-subnet-router?color=orange)](https://github.com/cocallaw/terraform-azure-tailscale-subnet-router/blob/main/LICENSE)

This module deploys a Tailscale [subnet router][1] as an [Azure Container Instance][2]. The subnet router ACI instance is deployed into an existing Azure Virtual Network and advertises to your Tailnet the CIDR block for the Azure VNet.

## Docker Container
The `docker/Dockerfile` file extends the `tailscale/tailscale`
[image][3] with an entrypoint script that starts the Tailscale daemon and runs
`tailscale up` using an [auth key][4] and the relevant advertised [CIDR block][5].

The Docker container must be built and pushed to an ACR repository so that it can be referenced during deployment.

### Build locally with Docker and [push image to ACR][6]
```bash
docker build \
  --tag tailscale-subnet-router:v1 \
  --file ./docker/tailscale.Dockerfile \
  .

# Optionally override the tag for the base `tailscale/tailscale` image
docker build \
  --build-arg TAILSCALE_TAG=v1.29.18 \
  --tag tailscale-subnet-router:v1 \
  --file ./docker/tailscale.Dockerfile \
  .
```

### Build remotely using [Azure Container Registry Tasks][7] with Azure CLI
```bash
ACR_NAME=<registry-name>
az acr build --registry $ACR_NAME --image tailscale:v1 .

# Optionally override the tag for the base `tailscale/tailscale` image
ACR_NAME=<registry-name>
az acr build --registry $ACR_NAME --build-arg TAILSCALE_TAG=v1.29.18 --image tailscale:v1 .
```

## Subnet Delegation 
To assist with the deployment of the ACI container group in the Azure VNet, the subnet being used should be [delegated][8] to the `Microsoft.ContainerInstance/containerGroups`.
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

- The Tailscale state (`/var/lib/tailscale`) is stored in a [Azure File Share][9] in a Storage Account so that the subnet router only needs to be [authorized][10] once.

## Improvements Needed

### Container Registry Authentication
Currently the module supports using a username and password to authenticate to the ACR repository, and the server URL is derived from the ACR repository name.
- Validation testing needed for use with Docker Hub
- Add Option to use [anonymous pull][11] with ACR
- Investigate using a service principal to authenticate to the ACR repository
- Investigate support for using a [Managed Identity to authenticate to the ACR repository][12]

### Container Size Selection
When the Tailscale container is deployed, the size is set to 1 CPU core and 1 GiB of memory. Currently there is no option to adjust this size, unless the `aci.tf` file is edited.
- Add Variable Option to adjust the size of the ACI container. Possible Small/Med/Large options that are available for deployment but easily defined by the user. 

[1]: https://tailscale.com/kb/1019/subnets/
[2]: https://docs.microsoft.com/en-us/azure/container-instances/container-instances-overview
[3]: https://hub.docker.com/r/tailscale/tailscale
[4]: https://tailscale.com/kb/1085/auth-keys/
[5]: https://tailscale.com/kb/1019/subnets/
[6]: https://docs.microsoft.com/en-us/azure/container-registry/container-registry-get-started-docker-cli?tabs=azure-cli
[7]: https://docs.microsoft.com/en-us/azure/container-registry/container-registry-tutorial-quick-task
[8]: https://docs.microsoft.com/en-us/azure/virtual-network/subnet-delegation-overview
[9]: https://docs.microsoft.com/en-us/azure/storage/files/storage-files-introduction
[10]: https://tailscale.com/kb/1099/device-authorization/
[11]: https://docs.microsoft.com/en-us/azure/container-registry/anonymous-pull-access
[12]: https://github.com/hashicorp/terraform-provider-azurerm/issues/15915