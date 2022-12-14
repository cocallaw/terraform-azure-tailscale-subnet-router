variable "resource_group_name" {
  description = "The name of the Azure Resource Group"
}

variable "vnet_name" {
  type        = string
  description = "The name of the Virtual Network that the Trailscale ACI container will be connected to. This Virtual Network must already exist, and will be used to determine the Azure Region that resources will be created in."
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
}

variable "container_size" {
  type        = string
  description = "The size (small/medium/large) of the Tailscale ACI container group resource"

  validation {
    condition     = contains(["small", "medium", "large"], var.container_size)
    error_message = "Valid container_size inputs are 'small', 'medium' or 'large'."
  }
}

variable "container_group_name" {
  type        = string
  description = "The name of the ACI container group resource"
}

variable "container_source" {
  type        = string
  default     = "DockerHub"
  description = "The source of the Tailscale container image. Valid inputs are 'DockerHub' or 'ACR'"

  validation {
    condition     = contains(["DockerHub", "ACR"], var.container_source)
    error_message = "Valid container_source inputs are 'DockerHub' or 'ACR'."
  }
}

variable "tailscale_ACR_repository" {
  type        = string
  default     = ""
  description = "The name of ACR repository where the Tailscale image is stored, e.g. myacr.azurecr.io/tailscale"
}

variable "tailscale_image_tag" {
  type        = string
  default     = "latest"
  description = "The image tag for the Tailscale container stored in the defined ACR"
}

variable "tailscale_ACR_repository_username" {
  type        = string
  default     = ""
  description = "The username of the ACR repository where the Tailscale image is stored"
}

variable "tailscale_ACR_repository_password" {
  type        = string
  default     = ""
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

variable "tailscale_login_server_parameter" {
  type        = string
  description = "Optional URL for alternative login servers such as Headscale. Must include --login-server. Example: '--login-server https://headscale.mydomain.org'"
  default     = ""
}