terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.32.0"
    }
  }
  required_version = ">= 1.2.8"
}
provider "azurerm" {
  features {}
}
data "azurerm_client_config" "current" {}
resource "azurerm_resource_group" "data_platform" {
  name     = "data-platform-${var.env}"
  location = var.resource_location
}

resource "azurerm_storage_account" "data_platform" {
  name                     = "${var.resource_group_prefix}sa${var.env}bronze"
  resource_group_name      = azurerm_resource_group.data_platform.name
  location                 = azurerm_resource_group.data_platform.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
}

resource "azurerm_databricks_workspace" "data_platform" {
  name                = "${var.resource_group_prefix}dbr${var.env}"
  resource_group_name = azurerm_resource_group.data_platform.name
  location            = azurerm_resource_group.data_platform.location
  sku                 = var.databricks_tier

}

resource "azurerm_mssql_server" "data_platform" {
  name                         = "${var.resource_group_prefix}sqldb${var.env}"
  resource_group_name          = azurerm_resource_group.data_platform.name
  location                     = azurerm_resource_group.data_platform.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_data_factory" "data_platform" {
  name                = "${var.resource_group_prefix}adf${var.env}"
  resource_group_name = azurerm_resource_group.data_platform.name
  location            = azurerm_resource_group.data_platform.location
}
resource "azurerm_key_vault" "data_platform" {
  name                        = "${var.resource_group_prefix}kv${var.env}"
  location                    = azurerm_resource_group.data_platform.location
  resource_group_name         = azurerm_resource_group.data_platform.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}
