provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "terra-app" {
  name     = "terraform-resourcegroup"
  location = "eastus"
}

resource "azurerm_mssql_server" "terra-app" {
  name                         = "terraform-app-sqlserver"
  resource_group_name          = azurerm_resource_group.terra-app.name
  location                     = azurerm_resource_group.terra-app.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "thisIsKat11"
  minimum_tls_version          = "1.2"
}

resource "azurerm_mssql_database" "terra-app" {
  name           = "terraform-app-sql-db"
  server_id      = azurerm_mssql_server.terra-app.id
}

resource "azurerm_storage_account" "terra-app" {
  name                     = "terraformsa4213"
  resource_group_name      = azurerm_resource_group.terra-app.name
  location                 = azurerm_resource_group.terra-app.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_data_factory" "terra-app" {
  name                = "terraform-data-factory42"
  location            = azurerm_resource_group.terra-app.location
  resource_group_name = azurerm_resource_group.terra-app.name
}

resource "azurerm_databricks_workspace" "terra-app" {
  name                = "terraform-databricks"
  resource_group_name = azurerm_resource_group.terra-app.name
  location            = azurerm_resource_group.terra-app.location
  sku                 = "standard"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "terra-app" {
  name                = "terraformkeyvault42"
  location            = azurerm_resource_group.terra-app.location
  resource_group_name = azurerm_resource_group.terra-app.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}
