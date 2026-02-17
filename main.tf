############################################
# Terraform Backend Configuration
############################################
terraform {
  backend "s3" {
    bucket         = "terraform-state-bamboo-7423"
    key            = "s3-deployment/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

############################################
# Provider
############################################
provider "aws" {
  region = "ap-south-1"
}

############################################
# First Bucket
############################################
resource "aws_s3_bucket" "demo_bucket" {
  bucket        = "bamboo-bucket-7423"
  force_destroy = true

  tags = {
    Name        = "Bamboo Terraform Demo"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning_1" {
  bucket = aws_s3_bucket.demo_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

############################################
# Second Bucket
############################################
resource "aws_s3_bucket" "demo_bucket_2" {
  bucket        = "bamboo-bucket-7423-logs"
  force_destroy = true

  tags = {
    Name        = "Bamboo Terraform Demo Logs"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning_2" {
  bucket = aws_s3_bucket.demo_bucket_2.id

  versioning_configuration {
    status = "Enabled"
  }
}

############################################
# Identity Check
############################################
data "aws_caller_identity" "current" {}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}
