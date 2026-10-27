locals {
  region         = "us-east-1"
  account_id     = data.aws_caller_identity.current.account_id
  s3_bucket_name = "${local.account_id}-${local.region}-config-storage"
}
