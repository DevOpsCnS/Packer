packer {
  required_plugins {
    azure = {
      source   = "github.com/hashicorp/azure"
      version  = "~> 2"
    }
  }
}

variable resourcegroup {
  type = string
//  default = "packer-rg"
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "azure-arm" "packer_build_image" {
  azure_tags = {
    dept = "DevOps"
    task = "Golden Image Build"
  }
  client_id                         = "xxxxxx-xxxxxxx-xxxxxxxx-xxxxxx"
  client_secret                     = "xxxxxx-xxxxxxx-xxxxxxxx-xxxxxx"
  subscription_id                   = "xxxxxx-xxxxxxx-xxxxxxxx-xxxxxx"
  tenant_id                         = "xxxxxx-xxxxxxx-xxxxxxxx-xxxxxx"

  image_offer                       = "WindowsServer"
  image_publisher                   = "MicrosoftWindowsServer"
  image_sku                         = "2019-datacenter-gensecond"

  location                          = "East US"
  managed_image_name                = "DevOpsCnS_Packer_Windows_Image-${local.timestamp}"
  managed_image_resource_group_name = "${var.resourcegroup}"
  os_type                           = "Windows"
  vm_size                           = "Standard_D2als_v6"

  communicator                      = "winrm"
  winrm_insecure                    = true
  winrm_timeout                     = "5m"
  winrm_use_ssl                     = true
  winrm_username                    = "packer"
}

build {
  sources = ["source.azure-arm.packer_build_image"]

  provisioner "powershell" {
    inline = [
      "Write-Host 'Installing Chocolatey...'",
      "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))",
      "Write-Host 'Chocolatey installed.'",
      "Write-Host 'Restarting the machine...'",
      "Restart-Computer -Force"
    ]
  }
  provisioner "windows-restart" {
    restart_timeout = "10m"
  }

  provisioner "powershell" {
    inline = [
      "Write-Host 'Installing Docker...'",
      "choco install docker -y",
      "Write-Host 'Docker installed.'"
    ]
  } 
}