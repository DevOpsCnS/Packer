packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "region" {
  type = string
}

variable "communicator" {}

variable "instancetype" {
  type = string
  default = "t2.small"
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "windows" {
  ami_name      = "build-your-own-windows-image-${local.timestamp}"
  communicator  = "${var.communicator}"
  instance_type = "${var.instancetype}"
  region        = "${var.region}"
  source_ami_filter {
    filters = {
      name                = "Windows_Server-2019-English-Full-Base-2024.10.09"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["801119661308"] # AWS account ID of the AMI owner
  }
  user_data_file = "./bootstrap_win.txt"
  winrm_password = "SuperS3cr3t!!!!"
  winrm_username = "Administrator"
}

build {
  name = "build-packer-image"
  sources = [
    "source.amazon-ebs.windows"
  ]

  provisioner "powershell" {
    environment_vars = ["DEVOPS_CnS=Welcome to DevOps Consultancy n Solutions"]
    inline           = ["Write-Host \"HELLO DevOps Engineer; WELCOME TO $Env:DEVOPS_CnS\"", "Write-Host \"You are learning how to use Packer to create your own golden image\"", "Write-Host \"This is a customized image with predefined packages \"", "Write-Host \"or in your own scripts.\""]
  }

  provisioner "powershell" { 
    elevated_execute_command = "powershell -ExecutionPolicy Bypass -Command \"& { Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File apache.ps1' -Verb RunAs }\"" 
    script = "apache.ps1"
  }

  provisioner "powershell" { 
    elevated_execute_command = "powershell -ExecutionPolicy Bypass -Command \"& { Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File apache.ps1' -Verb RunAs }\"" 
    inline = [ 
      "Start-Service -Name 'Apache' -ErrorAction Stop", 
      "Set-Service -Name 'Apache' -StartupType Automatic" 
    ] 
  }
}