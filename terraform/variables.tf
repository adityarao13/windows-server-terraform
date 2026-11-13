
variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "location" {
  description = "Azure deployment region"
  type        = string
  default     = "Central India"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "rg-windows-terraform"
}

variable "vm_name" {
  description = "Windows VM name"
  type        = string
  default     = "vm-windows-01"
}

variable "vm_size" {
  description = "Azure VM SKU"
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Windows administrator username"
  type        = string
  default     = "azureadmin"
}

variable "admin_password" {
  description = "Windows administrator password"
  type        = string
  sensitive   = true
}

variable "admin_source_cidr" {
  description = "Your public IP in CIDR notation, e.g. 203.0.113.10/32"
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.admin_source_cidr == null ? true : can(cidrhost(var.admin_source_cidr, 0))
    error_message = "Provide a valid CIDR address, preferably your public IP with /32."
  }
}
