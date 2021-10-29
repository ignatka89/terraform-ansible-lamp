#The Region you want to deploy the infra
aws_region         = "eu-central-1"

# Replace the VPC cidr from your account. Range of CIDR max(22)
vpc_cidr           = "172.170.100.0/22"

# Key pair name create in same region
key_name           = "ubuntu"

# personal laptop public ip for debugging and SSH purpose
personal_laptop_ip = "37.214.72.246"