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

  image_offer                       = "ubuntu-24_04-lts"
  image_publisher                   = "canonical"
  image_sku                         = "server"
  location                          = "East US"
  vm_size                           = "Standard_D2als_v6"
  os_type                           = "Linux"

  managed_image_name                = "DevOpsCnS_Packer_Image"
  managed_image_resource_group_name = "packer-rg"
}

build {
  sources = ["source.azure-arm.packer_build_image"]
}