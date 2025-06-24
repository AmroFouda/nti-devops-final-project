resource "aws_dynamodb_table" "users_table" {
  name           = "Users"
  billing_mode   = "PAY_PER_REQUEST" 
  hash_key       = "UserID"

  attribute {
    name = "UserID"
    type = "S"
  }

  attribute {
    name = "email"
    type = "S"
  }

  global_secondary_index {
    name               = "email-index"
    hash_key           = "email"
    projection_type    = "ALL"
  }

  tags = {
    Name        = "${var.project_name}-users-table"
    Environment = "dev"
  }
}
