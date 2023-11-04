# How to Create Aws EC2 instance using terraform

- Setup AWS Account
- Sign Up for aws account
- login as root user

# how To generate Access keys

- Terraform installed on your Desktop/Laptop needs to communicate with AWS and to make this communication terraform needs to be authenticated.

- For authentication, we need to generate Access Keys (access key ID and secret access key). These access keys can be used for making - programmatic calls to AWS from the AWS CLI, Tools for PowerShell, AWS SDKs, or direct AWS API calls.

# On Your Security Credentials page click on Access keys (access key ID and secret access key)

- Click on Create New Access key

- Copy the Access Key ID and Secret Access Key (Note:- You can view the Secret Access Key only once, so make sure to copy it.)

# Create your first Terraform infrastructure (main.tf)

- Before we start writing terraform script, the first thing to learn over here is - "You need to save your configuration with .tf extension"

- As Terraform is developed by HashiCorp, so we use HCL for writing the terraform scripts.

- We will start by creating an empty main.tf file.

# Provider

# resource - "aws_instance"

- Now after defining the provider, next we are going define is resource.So what do you mean by resource?Resource - It is something that we are going to provision/start on AWS.Now for this article, we are going to provision EC2 instance on AWS.But before we provision the EC2 instance, we need to gather few points -ami = you need to tell Terraform which AMI(Amazon Machine Image) you are going to use. Is it going to be Ubuntu, CentOS or something else
  instance_type = Also based on your need you have to choose the instance_type and it can be t2.nano, t2.micro, t2. small etc.

```
    resource "aws_instance" "ec2_example" {
    ami = "ami-0767046d1677be5a0"
    instance_type = "t2.micro"
    tags = {
        Name = "Demo EC2"
    }
}
```

# terraform commands

- Alright, now we have completed all the pre-requisites for provisioning our first ec2 instance on the AWS.

# terraform init

- The first command which we are going to run is

```
terraform init
```

# terraform plan

- This command will help you to understand how many resources you are gonna add or delete.

```
terraform plan
```

# terraform apply

- This command will do some real stuff on AWS. Once you will issue this command, it will be going to connect to AWS and then finally going to provision AWS instance.

Here is the command -

```
terraform apply
```

# Verify the EC2 setup

- Let's verify the setup by going back to AWS console.

# terraform destroy

- Now we have seen how to write your terraform script and how to provision your EC2 instance.

Let see how to remove or delete everything from AWS.

We are going to use the command -

```
terraform destroy
```

# Setup up a custom startup script for an Amazon Elastic Compute Cloud (EC2) using Terraform

- To set up a custom startup script for an Amazon Elastic Compute Cloud (EC2) instance using Terraform, you can use the user_data attribute of the aws_instance resource. The user_data attribute allows you to specify data (such as a script) that will be used by cloud-init to configure the instance when it is launched.

- Here is an example of how to use the user_data attribute to specify a custom startup script for an EC2 instance in Terraform. In this example -

- First we will setup the EC2 instance
  Secondly we are going to install Apache Web Server
  At last we are going to set up a very basic HTML page and deploy it on the Apache web server

```

provider "aws" {
   region     = "eu-central-1"
   access_key = "<INSERT_YOUR_ACCESS_KEY>"
   secret_key = "<INSERT_YOUR_SECRET_KEY>"
}

resource "aws_instance" "ec2_example" {

    ami = "ami-0767046d1677be5a0"
    instance_type = "t2.micro"
    key_name= "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]

  user_data = <<-EOF
      #!/bin/sh
      sudo apt-get update
      sudo apt install -y apache2
      sudo systemctl status apache2
      sudo systemctl start apache2
      sudo chown -R $USER:$USER /var/www/html
      sudo echo "<html><body><h1>Hello this custom page built with Terraform User Data</h1></body></html>" > /var/www/html/index.html
      EOF
}
```

# Copy and Execute the script from local machine to remote EC2 instance using file and remote-exec provisioner

- In the previous section, you have seen how to execute custom scripts using the user_data block of terraform. But it is not recommended to use user_data for long and complex scripts.

- In case of long and complex scripts, you should use file as well as remote-exec provisioner. (For more in-depth tutorial please refer to this blog post on - What is terraform provisioner )

- file provisioner- First we will use file provisioner to copy the file to the remote EC2 instance.

- remote-exec provisioner- To execute the script copied using file provisioner

- Here is an example where you can also use the file provisioner in Terraform to copy a script file from the local machine to the instance and execute it.

```
#main.tf

provider "aws" {
   region     = "eu-central-1"
   access_key = "<INSERT_YOUR_ACCESS_KEY>"
   secret_key = "<INSERT_YOUR_SECRET_KEY>"
}

resource "aws_instance" "ec2_example" {

    ami = "ami-0767046d1677be5a0"
    instance_type = "t2.micro"
    key_name= "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]

  # file provisioner -
  # It will copy the "startup.sh" to remote machine
  provisioner "file" {
    source      = "/home/rahul/Jhooq/startup.sh"
    destination = "/home/ubuntu/startup.sh"
  }

  # connection -
  # This block will be used for ssh connection to initiate the copy
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/rahul/Jhooq/keys/aws/aws_key")
      timeout     = "4m"
   }
}

   # remote-exec -
   # Execute the "startup.sh" script copied using "file" provisoner
   provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/startup.sh",
      "/home/ubuntu/startup.sh"
    ]
   }

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}

# aws_key_pair -
# You need to generate the public as well as private key using - ssh-keygen
# Place the public key here
resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "<PLACE_YOU_PUBLIC_KEY>"
}
```
