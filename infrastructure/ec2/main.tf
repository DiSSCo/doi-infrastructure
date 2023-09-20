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

resource "aws_instance" "doi_server" {
  source          = "terraform-aws-modules/ec2-instance/aws"
  ami             = "ami-0a244485e2e4ffd03"
  instance_type   = "t3.small"
  azs             = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  security_groups = [aws_security_group.doi-server-sg.id]
  subnet_id       = doi_server_subnet_group
}
