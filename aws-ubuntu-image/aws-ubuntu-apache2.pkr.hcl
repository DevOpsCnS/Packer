packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "build-your-own-ubuntu-image"
  instance_type = "t4g.nano"
  region        = "eu-west-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-arm64-server-20240927*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"] # AWS account ID of the AMI owner
  }
  ssh_username = "ubuntu"
}

build {
  name = "build-packer-image"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {
    environment_vars = [
      "var=Welcome to DevOps Consultancy n Solutions",
    ]
    inline = [
      "echo Installing Apache2",
      "sleep 30",
      "sudo apt-get update",
      "sudo apt-get install -y apache2",
      "echo $var > index.html",
      "sudo mv index.html /var/www/html/",
      "sudo systemctl start apache2",
    ]
  }
}