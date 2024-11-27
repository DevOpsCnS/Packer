packer {
  required_plugins {
    azure = {
      source   = "github.com/hashicorp/azure"
      version  = "~> 2"
    }
  }
}

source "azure-arm" "packer_build_image" {
  azure_tags = {
    dept = "DevOps"
    task = "Golden Image Build"
  }
  client_id                         = "7f664349-26b1-4804-9314-6ad265c75906"
  client_secret                     = "xxxxxx-xxxxxxx-xxxxxxxx-xxxxxx"
  subscription_id                   = "c5ee34df-9eee-4ca3-ab47-1eda605e102c"
  tenant_id                         = "c2242504-72f3-43a6-b016-11802e615d26"

  image_offer                       = "WindowsServer"
  image_publisher                   = "MicrosoftWindowsServer"
  image_sku                         = "2019-datacenter-gensecond"

  location                          = "East US"
  managed_image_name                = "DevOpsCnS_Packer_Windows_Image"
  managed_image_resource_group_name = "packer-rg"
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
}