# Module Azure Tailscale Subnet Router
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.17.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.17.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_group.containergroup](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group) | resource |
| [azurerm_network_profile.acg_network_profile](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_profile) | resource |
| [azurerm_storage_account.aci_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_share.aci_share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_group_name"></a> [container\_group\_name](#input\_container\_group\_name) | The name of the ACI container group resource | `string` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | The name of the Tailscale ACI container resrouce | `string` | `"tailscale"` | no |
| <a name="input_region"></a> [region](#input\_region) | The Azure region where the subnet router ACI service will be deployed | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Azure Resource Group | `string` | `"myResourceGroup"` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of the storage account to be created for use by the Tailscale ACI container | `string` | n/a | yes |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | The name of the subnet that the Tailscal ACI container will use in the defined vnet | `string` | n/a | yes |
| <a name="input_tailscale_ACR_repository"></a> [tailscale\_ACR\_repository](#input\_tailscale\_ACR\_repository) | The name of ACR repository where the Tailscale image is stored | `string` | `"myacr.azurecr.io/tailscale"` | no |
| <a name="input_tailscale_ACR_repository_password"></a> [tailscale\_ACR\_repository\_password](#input\_tailscale\_ACR\_repository\_password) | The password of the ACR repository where the Tailscale image is stored | `string` | n/a | yes |
| <a name="input_tailscale_ACR_repository_username"></a> [tailscale\_ACR\_repository\_username](#input\_tailscale\_ACR\_repository\_username) | The username of the ACR repository where the Tailscale image is stored | `string` | n/a | yes |
| <a name="input_tailscale_advertise_routes"></a> [tailscale\_advertise\_routes](#input\_tailscale\_advertise\_routes) | The CIDR ranges that Tailscale will advertise to your Tailnet | `string` | n/a | yes |
| <a name="input_tailscale_auth_key"></a> [tailscale\_auth\_key](#input\_tailscale\_auth\_key) | The Auth Key that Tailscale container will use to authenticate with and join your Tailnet | `string` | n/a | yes |
| <a name="input_tailscale_hostname"></a> [tailscale\_hostname](#input\_tailscale\_hostname) | The hostname that Tailscale will use to identify the connected ACI container | `string` | n/a | yes |
| <a name="input_tailscale_image_tag"></a> [tailscale\_image\_tag](#input\_tailscale\_image\_tag) | The image tag for the Tailscale container stored in the defined ACR | `string` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | The name of the Virtual Network that the Trailscale ACI container will be connected to | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->