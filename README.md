<img width="1201" height="718" alt="image" src="https://github.com/user-attachments/assets/aa36742c-83c4-4e99-9574-20299437fe58" />


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

## ✅ Prerequisites
- Azure subscription with resource deployment permissions
- An existing **Resource Group** for deployment

---

## 📦 Deployment Example

```bash
az deployment group create \
  --resource-group myResourceGroup \
  --template-file main.bicep \
  --parameters \
    sqlAdministratorLogin=adminuser \
    sqlAdministratorLoginPassword=<YourPasswordHere> \
    vmAdminUserName=vmadmin \
    vmAdminPassword=<YourVmPasswordHere>
