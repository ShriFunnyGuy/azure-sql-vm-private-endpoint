/*
  Bicep Template: Web App with SQL Database Deployment

  This template deploys a scalable Azure Web App along with an App Service Plan and
  an Azure SQL Database hosted on a SQL Server. It allows parameterization of
  key settings such as resource location, names, and SQL administrator credentials.

  The App Service Plan defines the hosting environment and pricing tier for the Web App.
  The Web App is linked to this hosting plan and serves as the application front-end.
  The SQL Server provides a managed database server, while the SQL Database hosts
  the application's data.

  This setup is ideal for web applications that require a reliable backend database
  and flexible hosting on Azure's App Service platform.
*/

// Parameters

@description('Location for the resources, defaults to the resource group location')
param location string = resourceGroup().location

@description('Name of the App Service Plan to be created')
param appServicePlanName string = 'myAppServicePlan-${uniqueString(resourceGroup().id)}'

@description('Name of the Web App to be created')
param webAppName string = 'myWebApp-${uniqueString(resourceGroup().id)}'

@description('Name of the SQL Server to be created')
param sqlServerName string = 'mySqlServer-${uniqueString(resourceGroup().id)}'

@description('Name of the SQL Database to be created')
param sqlDatabaseName string = 'mySqlDatabase'

@description('Administrator login for the SQL Server')
param sqlAdminLogin string = 'shrisqladmin'

@description('Password for the SQL Server administrator')
@secure()
param sqlAdminPassword string

// Resource: App Service Plan
// Defines the hosting plan for the Web App with Standard S1 SKU.
// This plan determines the performance, features, and pricing tier of the web app.
resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'S1'        // Standard tier, small instance
    tier: 'Standard'
    size: 'S1'
    family: 'S'
    capacity: 1        // Number of instances
  }
}

// Resource: Web App
// Creates a Web App resource under the specified App Service Plan.
// This is the application hosting environment for your web application.
resource webApp 'Microsoft.Web/sites@2022-09-01' = {
  name: webAppName
  location: location
  kind: 'app'          // Specifies this is an App Service app
  properties: {
    serverFarmId: appServicePlan.id  // Link to the App Service Plan resource
  }
}

// Resource: SQL Server
// Creates an Azure SQL logical server that hosts databases.
// Administrator credentials are required for SQL server management.
resource sqlServer 'Microsoft.Sql/servers@2021-11-01' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlAdminLogin
    administratorLoginPassword: sqlAdminPassword
  }
}

// Resource: SQL Database
// Creates a SQL database on the previously created SQL Server.
// The SKU specifies a Basic tier database with limited DTUs and storage.
resource sqlDatabase 'Microsoft.Sql/servers/databases@2021-11-01' = {
  parent: sqlServer
  name: sqlDatabaseName
  location: location
  sku: {
    name: 'Basic'      // Basic performance tier
    tier: 'Basic'
    capacity: 5        // Database capacity (DTUs)
  }
}

