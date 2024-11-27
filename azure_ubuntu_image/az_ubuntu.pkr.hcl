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
  client_id                         = "xxxxxx-xxxxxxx-xxxxxxxx-xxxxxx"
  client_secret                     = "xxxxxx-xxxxxxx-xxxxxxxx-xxxxxx"
  subscription_id                   = "xxxxxx-xxxxxxx-xxxxxxxx-xxxxxx"
  tenant_id                         = "xxxxxx-xxxxxxx-xxxxxxxx-xxxxxx"

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