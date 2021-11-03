## Terraform Ansible LAMP with RDS
---
---
 
Here we will be using RDS as our MySql DB and Ubuntu 20.4 as our web servers. 
Since we are using RDS, patching or any other maintainence activity is taken care by AWS. Hence we don't need NAT gateway or instance. Anyway they cost a lot too.  But RDS with Multi AZ also has a high price, but you get high availability of the site.

Here is the reference architecture that We are going to Spin up using Terraform(Infra Provisioning) And Ansible(Configuration Management).

## Pre-requisites to Run the script


1. AWS Account 
2. Access Key & Secret Access Key for an administrator command line user
3. Terraform (minimum version 13.0) as mentioned in provider.tf
   
   `required_version = "~> 0.13"` !!! BUT latests version not working check again after changes 28.10.2021

4. Create a key pair in the region you want to deploy (Default here is eu-central-1, but you can change in terraform.tfvars)

## Steps to run the Scripts

1. Clone the repository 

` git clone https://github.com/ignatka89/terraform-ansible-lamp.git`

2. Go to the repository

`cd terraform-ansible-lamp`

3. Open terraform.tfvars and replace your values.

```
#The Region you want to deploy the infra
aws_region         = "eu-central-1"

# Replace the VPC cidr from your account. Range of CIDR max(22)
vpc_cidr           = "172.170.100.0/22"

# Key pair name create in same region
key_name           = "ubuntu"

# personal laptop public ip for debugging and SSH purpose (you can put here 127.0.0.1 if you have NAT it's not wokring)
personal_laptop_ip = "37.214.72.246"
```

4. Initialiaze the terraform so that all related plugins gets download

`terraform init`

5. Run Apply and the approve with yes command

`terraform apply`

or directly auto approve it

`terraform apply --auto-approve`

6. After completion the ALB URL and DB DNS will be there in the outputs section similar to this

```
alburl = "lamp-alb-******.eu-central-1.elb.amazonaws.com"
dburl = "lampdb.******.eu-central-1.rds.amazonaws.com"
```

7. On hittng the ALB you should be able to see index.html for apache web servers.


## Ansible Part

We are using the EC2 user data to install Ansible and do the installation of the LAMP required packages.
The user data that we are passing to the instance is the filename:
`installAnsibleUbuntu.sh`

You can clone the Ansible Script here: 

`git clone https://github.com/ignatka89/ansible_lamp.git`

This is just a sample and only the apache sever is running here.
And when you access the instances you can do the following command to check access to MySql 
Database in RDS using the terraform output dburl.

`nc lampdb.******.eu-central-1.rds.amazonaws.com 3306 -v`

And hence we can start building the LAMP application as required.

## for Module "terraform-aws-modules/ec2-instance/aws"

delete in main.tf (.terraform/modules/ec2_instance/mail.tf) 134:   volume_tags = var.enable_volume_tags ? merge({ "Name" = var.name }, var.volume_tags) : null

to avoid an Error: Conflicting configuration arguments


## Thank you

