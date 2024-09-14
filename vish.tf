terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.50.0"
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
    Name        = "HelloWorld"
    Project     = "MyProject"
    Environment = "Development"
  }
}

resource "aws_security_group" "vish" {
  name_prefix = "mysecurity-"
  tags = {
    Name        = "example"
    Project     = "MyProject"
    Environment = "Development"
  }
}

resource "aws_security_group_rule" "allow_all_egress" {
  type              = "egress"
  security_group_id = aws_security_group.vish.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1" # Allow all outbound traffic
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  security_group_id = aws_security_group.vish.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
}

resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  security_group_id = aws_security_group.vish.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
}
