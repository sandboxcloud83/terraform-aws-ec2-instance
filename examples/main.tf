# /examples/basic_instance/main.tf

provider "aws" {
  region = "us-east-1" # Or any other region
}

# 1. --- Find Existing Infrastructure ---
# We look up existing resources instead of creating them.
# This makes the example faster and mirrors a real-world use case.

# Find the default VPC in the selected region.
data "aws_vpc" "default" {
  default = true
}

# Find all the subnets within that default VPC.
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Find the latest Amazon Linux 2 AMI. This is better than hardcoding an AMI.
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


# 2. --- Use the EC2 Instance Module ---
# This is where we call your newly created brick.
# The `source` is relative to this example's directory.

module "app_server" {
  source = "../" # Assumes the example is in examples/basic_instance/

  instance_name = "MyExampleAppServer"
  instance_type = "t3.micro"
  ami_id        = data.aws_ami.amazon_linux.id

  # We use one of the subnets we found earlier.
  subnet_id = data.aws_subnets.default.ids[0]

  # For simplicity, this example doesn't attach a key pair or security groups.
  # In a real scenario, you would pass them in like this:
  # vpc_security_group_ids = ["sg-0123456789abcdef0"]
  # key_name               = "my-aws-key-pair"

  tags = {
    Environment = "Example"
    ManagedBy   = "Terraform"
  }
}
