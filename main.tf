provider "aws" {
  region = "ap-south-1"
}

# First Bucket
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "bamboo-bucket-7423"

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name        = "Bamboo Terraform Demo"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.demo_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Second Bucket
resource "aws_s3_bucket" "demo_bucket_2" {
  bucket = "bamboo-bucket-7423-logs"

  lifecycle {
    prevent_destroy = false
  }

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

# Identity Check
data "aws_caller_identity" "current" {}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

