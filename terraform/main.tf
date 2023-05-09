variable client_id {}
variable client_secret {}
variable tenant_id {}
variable subscription_id {}

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.55.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}

  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}


resource "azurerm_resource_group" "mediawiki_rg" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "mediawiki_vpn" {
  name                = "${var.prefix}-vpn"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.mediawiki_rg.location
  resource_group_name = azurerm_resource_group.mediawiki_rg.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.mediawiki_rg.name
  virtual_network_name = azurerm_virtual_network.mediawiki_vpn.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "mediawiki_nic" {
  name                = "${var.prefix}-nic"
  resource_group_name = azurerm_resource_group.mediawiki_rg.name
  location            = azurerm_resource_group.mediawiki_rg.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "mediawiki_vm" {
  name                            = "${var.prefix}-vm"
  resource_group_name             = azurerm_resource_group.mediawiki_rg.name
  location                        = azurerm_resource_group.mediawiki_rg.location
  size                            = var.vm_size
  admin_username                  = var.user
  network_interface_ids = [
    azurerm_network_interface.mediawiki_nic.id,
  ]

  admin_ssh_key {
    username = var.user
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = var.ubuntu_version
    version   = "latest"
  }

  os_disk {
    storage_account_type = var.storage_account_type
    caching              = "ReadWrite"
  }

  provisioner "file" {
    source      = "install_salt.sh"
    destination = "/tmp/install_salt.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_salt.sh",
      "/tmp/install_salt.sh",
    ]
  }
}
