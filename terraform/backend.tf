terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "varun-cicd-tfstate"
    key            = "cicd-pipeline/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "varun-cicd-tflock"
    encrypt        = true
  }
}

