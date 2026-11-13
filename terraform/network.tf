
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-windows-01"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create an RDP rule only when an allowed source CIDR is supplied.
resource "azurerm_network_security_rule" "rdp" {
  count = var.admin_source_cidr == null ? 0 : 1

  name                       = "Allow-RDP-Restricted"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "3389"
  source_address_prefix      = var.admin_source_cidr
  destination_address_prefix = "*"

  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}


resource "azurerm_network_interface" "nic" {
  name                = "nic-windows-01"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
