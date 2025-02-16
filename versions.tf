terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Generate RSA key pair
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save private key to PEM file
resource "local_file" "private_key" {
  content         = tls_private_key.private_key.private_key_pem
  filename        = "${path.root}/backend-server-key.pem"
  file_permission = "0400"  # Read-only for current user
}

# Register public key with AWS
resource "aws_key_pair" "generated_key" {
  key_name   = "backend-server-key"
  public_key = tls_private_key.private_key.public_key_openssh
}

# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Add security group for SSH access
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

# Add VPC subnet data source
data "aws_subnet" "default" {
  vpc_id = data.aws_vpc.default.id
  availability_zone = "us-east-1a"
  default_for_az = true
}

# Create EC2 instance
resource "aws_instance" "backend" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  key_name              = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id             = data.aws_subnet.default.id

  tags = {
    Name = "backend-server"
  }
}

# Add outputs for verification
output "instance_public_ip" {
  value = aws_instance.backend.public_ip
}

output "ssh_connection" {
  value = "Connect using: ssh -i ${path.root}/backend-server-key.pem ec2-user@${aws_instance.backend.public_ip}"
}

output "private_key_path" {
  value = abspath("${path.root}/backend-server-key.pem")
}

output "instance_id" {
  value = aws_instance.backend.id
}