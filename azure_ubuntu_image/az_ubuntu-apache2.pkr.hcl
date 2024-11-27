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
  client_id                         = "7f664349-26b1-4804-9314-6ad265c75906"
  client_secret                     = "skc8Q~P8eHCYZBDKLfNHEP6gYaEm5_beKBS6Ca09"
  image_offer                       = "ubuntu-24_04-lts"
  image_publisher                   = "canonical"
  image_sku                         = "server"
  location                          = "East US"
  managed_image_name                = "DevOpsCnS_Packer_Image-${local.timestamp}"
  managed_image_resource_group_name = "${var.resourcegroup}"
  os_type                           = "Linux"
  subscription_id                   = "c5ee34df-9eee-4ca3-ab47-1eda605e102c"
  tenant_id                         = "c2242504-72f3-43a6-b016-11802e615d26"
  vm_size                           = "Standard_D2als_v6"
}

build {
  sources = ["source.azure-arm.packer_build_image"]

  provisioner "shell" {
    inline = [ 
      "echo Installing Docker...", 
      "curl -fsSL https://get.docker.com | sh", 
      "sudo usermod -aG docker $USER", 
      "sudo systemctl start docker", 
      "sudo systemctl enable docker" 
    ] 
  }
  provisioner "shell" {
    inline = [
      "echo Installing Apache2",
      "sudo apt-get update",
      "sudo apt-get install -y apache2",
      "sudo systemctl start apache2"
    ]
  }
}