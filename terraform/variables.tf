variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default = "mediawiki"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default = "ind-central"
}

variable "vm_size" {
  description = "VM size"
  default = "Standard_B2s"
}

variable "ubuntu_version" {
  default = "18.04-LTS"
}

variable "storage_account_type" {
  default = "Standard_LRS"
}

variable "client_id" {
  description = "Client ID, need to provide as part of main script"
}

variable "user" {
  default = "adminuser"
}

variable "client_secret" {
  description = "Client secret, need to provide as part of main script"
}

variable "tenant_id" {
  description = "Tenant ID, need to provide as part of main script"
}

variable "subscription_id" {
  description = "Subscription ID, need to provide as part of main script"
}
