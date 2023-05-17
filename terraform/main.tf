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

resource "azurerm_network_security_group" "mediawiki_nsg" {
  name                = "${var.prefix}-nsg"
  location            = azurerm_resource_group.mediawiki_rg.location
  resource_group_name = azurerm_resource_group.mediawiki_rg.name

  security_rule {
    name                       = "allowInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080,80,443,22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "mediawiki_nsg-associate" {
  subnet_id                 = azurerm_subnet.internal.id
  network_security_group_id = azurerm_network_security_group.mediawiki_nsg.id
}

resource "azurerm_public_ip" "mediawiki_public_ip" {
  name                = "${var.prefix}-public-ip"
  location            = azurerm_resource_group.mediawiki_rg.location
  resource_group_name = azurerm_resource_group.mediawiki_rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "mediawiki_nic" {
  name                = "${var.prefix}-nic"
  resource_group_name = azurerm_resource_group.mediawiki_rg.name
  location            = azurerm_resource_group.mediawiki_rg.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mediawiki_public_ip.id
  }
  depends_on = [
    azurerm_public_ip.mediawiki_public_ip
  ]
}

resource "tls_private_key" "linux_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "local_file" "linux_key" {
  filename = "linuxkey.pem"
  content = tls_private_key.linux_key.private_key_pem
  file_permission = "400"
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
    public_key = tls_private_key.linux_key.public_key_openssh
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

  connection {
    type        = "ssh"
    user        = "${var.user}"
    private_key = file(local_file.linux_key.filename)
    host        = self.public_ip_address
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
