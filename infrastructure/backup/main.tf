provider "aws" {
  region = "eu-west-2"
  default_tags {
    tags = {
      Environment = "DOI"
      Owner       = "DiSSCo"
      Project     = "DiSSCo DOI"
      Terraform   = "True"
    }
  }
}

data "terraform_remote_state" "db-state" {
  backend = "s3"

  config = {
    bucket = "doi-terraform-state-backend"
    key    = "doi/database/terraform.tfstate"
    region = "eu-west-2"
  }
}

module "s3-bucket" {
  bucket = "dissco-doi-backup"
  source = "terraform-aws-modules/s3-bucket/aws"
}

module "rds-export-to-s3" {
  source  = "binbashar/rds-export-to-s3/aws"

  create_customer_kms_key = false
  customer_kms_key_arn    = "arn:aws:secretsmanager:eu-west-2:824841205322:secret:rds!db-c0b80aa4-d161-4ccc-8a87-06e06568dbd2-rKvFrF"
  database_names          = data.terraform_remote_state.db-state.outputs.db_name
  prefix                  = "doi-snapshot"
  snapshots_bucket_name   = module.s3-bucket.s3_bucket_id
  snapshots_bucket_prefix = "backup/2023/"
  rds_event_ids           = "RDS: RDS-EVENT-0091"
}


