packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "windows" {
  ami_name      = "build-your-own-windows-image"
  communicator  = "winrm"
  instance_type = "t2.micro"
  region        = "eu-west-1"
  source_ami_filter {
    filters = {
      name                = "Windows_Server-2025-English-Full-Base-2024.11.04"
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
}