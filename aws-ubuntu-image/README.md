aws-ubuntu.pkr.hcl - Script is to create the basic ubuntu image. There is no difference b/w AWS provided AMI and AMI created with this script.
    Command to run:
        packer init aws-ubuntu.pkr.hcl
        packer validate aws-ubuntu.pkr.hcl
        packer build aws-ubuntu.pkr.hcl
        
aws-ubuntu-apache2.pkr.hcl - Script is install apache2 on top of standard AMI provided by AWS. 
    Command to run:
        packer init aws-ubuntu-apache2.pkr.hcl
        packer validate aws-ubuntu-apache2.pkr.hcl
        packer build aws-ubuntu-apache2.pkr.hcl
        
aws-ubuntu-apache2-variable.pkr.hcl - script demonstrate how to use variables in the packer build script.
    Comman to run:
        packer init aws-ubuntu-apache2-variable.pkr.hcl
        packer validate aws-ubuntu-apache2-variable.pkr.hcl
        packer build -var 'region=eu-west-1' aws-ubuntu-apache2-variable.pkr.hcl
        
aws-ubuntu-apache2-variable-file.pkr.hcl - Demonstrate how to use variables in a file to run packer build script. It will use aws-ubuntu-variables.pkrvars.hcl file which contains variables and its value.
    Comand to run:
        packer init aws-ubuntu-apache2-variable-file.pkr.hcl
        packer validate aws-ubuntu-apache2-variable-file.pkr.hcl
        packer build -var-file="aws-ubuntu-variables.pkrvars.hcl" aws-ubuntu-apache2-variable-file.pkr.hcl
