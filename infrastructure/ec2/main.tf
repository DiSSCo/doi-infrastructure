provider "aws" {
  region = "eu-west-2"
  default_tags {
    tags = {
      Environment = "DOI"
      Owner       = "DiSSCo"
      Project     = "DiSSCo PID"
      Terraform   = "True"
    }
  }
}

resource "aws_eip" "static_ip" {
  domain   = "vpc"
  instance = aws_instance.doi_server
}

resource "aws_instance" "doi_server" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  ami                         = "ami-0a244485e2e4ffd03"
  instance_type               = "t3.small"
  associate_public_ip_address = true

  subnet_id = data.terraform_remote_state.vpc-state.doi_server_subnets
  security_groups = [data.terraform_remote_state.vpc-state.doi_server_security_group]
}
