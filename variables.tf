variable "region" {
  type        = string
  description = "The Azure region where the subnet router ACI service will be deployed"
}

variable "resource_group_name" {
  description = "The name of the Azure Resource Group"
}

variable "vnet_name" {
  type        = string
  description = "The name of the Virtual Network that the Trailscale ACI container will be connected to"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet that the Tailscal ACI container will use in the defined vnet"
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account to be created for use by the Tailscale ACI container"
}

variable "container_name" {
  type        = string
  description = "The name of the Tailscale ACI container resrouce"
  default     = "tailscale"
}

variable "container_group_name" {
  type        = string
  description = "The name of the ACI container group resource"
}

variable "tailscale_ACR_repository" {
  type        = string
  description = "The name of ACR repository where the Tailscale image is stored, e.g. myacr.azurecr.io/tailscale"
}

variable "tailscale_image_tag" {
  type        = string
  description = "The image tag for the Tailscale container stored in the defined ACR"
}

variable "tailscale_ACR_repository_username" {
  type        = string
  description = "The username of the ACR repository where the Tailscale image is stored"
}

variable "tailscale_ACR_repository_password" {
  type        = string
  sensitive   = true
  description = "The password of the ACR repository where the Tailscale image is stored"
}

variable "tailscale_hostname" {
  type        = string
  description = "The hostname that Tailscale will use to identify the connected ACI container"
}

variable "tailscale_advertise_routes" {
  type        = string
  description = "The CIDR ranges that Tailscale will advertise to your Tailnet"
}

variable "tailscale_auth_key" {
  type        = string
  sensitive   = true
  description = "The Auth Key that Tailscale container will use to authenticate with and join your Tailnet"
}