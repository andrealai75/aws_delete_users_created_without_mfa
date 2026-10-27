resource "aws_s3_bucket" "config_storage" {
  bucket        = local.s3_bucket_name
  force_destroy = true

  tags = {
    Name = local.s3_bucket_name
  }
}

resource "aws_s3_bucket_public_access_block" "config_storage_privacy" {
  bucket = aws_s3_bucket.config_storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "config_storage_enforcement" {
  bucket = aws_s3_bucket.config_storage.id

  depends_on = [aws_s3_bucket_public_access_block.config_storage_privacy]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "EnforceTLSRequestsOnly"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.config_storage.arn,
          "${aws_s3_bucket.config_storage.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}
