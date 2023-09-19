resource "aws_dynamodb_table" "terraform-lock" {
  name           = "terraform_state_doi"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    name = "DynamoDB Terraform State Lock Table for DOI",
    environment = "DOI"
  }
}