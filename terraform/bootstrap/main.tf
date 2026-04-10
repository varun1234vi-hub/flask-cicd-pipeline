provider "aws" {
  region = "ap-south-1"
}

# S3 bucket for Terraform state
resource "aws_s3_bucket" "tfstate" {
  bucket = "varun-cicd-tfstate"
}

# Enable versioning on the bucket
resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

# DynamoDB table for state locking
resource "aws_dynamodb_table" "tflock" {
  name         = "varun-cicd-tflock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

