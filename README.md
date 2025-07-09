# 🚀 Azure Deployment: SQL Server with Private Endpoint and Windows VM

This Bicep template deploys a secure and self-contained environment in Azure that includes:

---

## 🔧 Resources Deployed

### ✅ Azure SQL Server
- Logical SQL Server with **public access disabled**
- A sample database (**AdventureWorksLT**) using the **Basic** SKU

### ✅ Private Networking
- **Virtual Network**: `10.0.0.0/16`
- **Subnet for Private Endpoint**: `10.0.0.0/24`
- **Private Endpoint** for SQL Server access via the VNet
- **Private DNS Zone** for SQL Private Link name resolution

### ✅ Windows Virtual Machine
- **Windows Server 2019** VM
- Customizable size (default: `Standard_B2s`)
- Includes **public IP** and **network interface**
- Admin credentials provided as secure parameters

---

## 🔐 Security Highlights
- SQL Server is deployed with **public network access disabled**
- Uses **Private Link** and **DNS Zone Group** for secure VNet-based SQL connectivity
- Admin credentials for SQL Server and VM are passed securely via `@secure()` parameters

---

## 📌 Parameters

| Parameter | Description |
|----------|-------------|
| `sqlAdministratorLogin` | SQL Server admin username |
| `sqlAdministratorLoginPassword` | SQL Server admin password (secure) |
| `vmAdminUserName` | VM admin username |
| `vmAdminPassword` | VM admin password (secure, complex) |
| `VmSize` | (Optional) VM size (default: `Standard_B2s`) |
| `location` | (Optional) Deployment region (defaults to the resource group location) |

---

## 💡 Use Cases
- Deploy **SQL Server privately** without public internet exposure
- Test **SQL connectivity** from a VM via **Private Link**
- Base setup for **dev**, **demo**, or **secure POC** environments

---

## 📦 Deployment Example
You can deploy the resources using the Azure CLI:

```bash
az deployment group create \
  --resource-group myResourceGroup \
  --template-file main.bicep \
  --parameters \
    sqlAdministratorLogin=adminuser \
    sqlAdministratorLoginPassword=<YourPasswordHere> \
    vmAdminUserName=vmadmin \
    vmAdminPassword=<YourVmPasswordHere>
```
# 🚀 Azure Web App with SQL Database Bicep Template

This Bicep template deploys a complete Azure environment for a web application, including:

- An **App Service Plan** for hosting the Web App with a specified pricing tier.
- An **Azure Web App** configured to run your web application.
- An **Azure SQL Server** instance with an administrator login.
- An **Azure SQL Database** deployed on the SQL Server for application data.

This setup is suitable for applications requiring a managed web hosting environment integrated with a backend SQL database.

---

## 📌 Parameters

| Parameter            | Description                                      | Default              | Required |
|----------------------|--------------------------------------------------|----------------------|----------|
| `location`           | Azure region where resources will be deployed    | Resource group location | No     |
| `appServicePlanName` | Name of the App Service Plan                     | `myAppServicePlan`   | No       |
| `webAppName`         | Name of the Web App                              | `myWebApp`           | No       |
| `sqlServerName`      | Name of the Azure SQL Server                     | `mySqlServer`        | No       |
| `sqlDatabaseName`    | Name of the Azure SQL Database                   | `mySqlDatabase`      | No       |
| `sqlAdminLogin`      | Administrator login for the SQL Server          | `shrisqladmin`       | No       |
| `sqlAdminPassword`   | Password for the SQL Server admin user           | *(secure)*           | ✅ Yes   |

---

## 📦 Deployment Example

You can deploy the resources using the Azure CLI:

```bash
az deployment group create \
  --resource-group myResourceGroup \
  --template-file main.bicep \
  --parameters \
    sqlAdminLogin=adminuser \
    sqlAdminPassword=<YourSecureSqlPassword>

---

