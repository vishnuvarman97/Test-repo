terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "vish" {
  ami           = "ami-05a33650b3cf29d4e"  # Ensure this AMI is appropriate for your needs
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_security_group" "vish" {
  name = "mysecurity"
  tags = {
    Name = "example"
  }
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  security_group_id = aws_security_group.vish.id
  cidr_blocks       = ["10.0.0.0/8"]  # Limit SSH access to specific IP range
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
}

resource "aws_security_group_rule" "allow_all_egress" {
  type              = "egress"
  security_group_id = aws_security_group.vish.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1" # Allow all outbound traffic
}

resource "aws_security_group_rule" "allow_all_tcp" {
  type              = "ingress"
  security_group_id = aws_security_group.vish.id
  cidr_blocks       = ["0.0.0.0/0"] # This exposes all TCP ports to the internet
  from_port         = 1
  to_port           = 65535
  protocol          = "tcp"
  # It might be better to limit this rule to specific ports or remove it if not needed
}
