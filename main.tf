provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket        = "bamboo-bucket-7423"
  force_destroy = true
}

resource "aws_s3_bucket" "demo_bucket_2" {
  bucket        = "bamboo-bucket-7423-logs"
  force_destroy = true
}
