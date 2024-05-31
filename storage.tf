provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "your-resource-group-name"
  location = "East US" # Replace with your desired location
}

resource "azurerm_storage_account" "example" {
  name                     = "your-storage-account-name"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [] # Replace with your virtual network's subnet IDs, if applicable
    ip_rules                   = [] # Add any specific IP rules if needed
  }

  min_tls_version = "TLS1_3"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_container" "example" {
  name                  = "example-container"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

output "connection_string" {
  value = azurerm_storage_account.example.primary_connection_string
}
