resource "aws_config_configuration_recorder" "main" {
  name     = "aws-config-recorder"
  role_arn = aws_iam_role.config.arn

  recording_group {
    all_supported                 = false
    include_global_resource_types = false

    resource_types = ["AWS::IAM::User"]
  }
}

resource "aws_config_delivery_channel" "main" {
  name           = "aws-config-delivery-channel"
  s3_bucket_name = aws_s3_bucket.config_storage.id
  depends_on     = [aws_config_configuration_recorder.main]
}


resource "aws_config_configuration_recorder_status" "main" {
  name       = aws_config_configuration_recorder.main.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.main]
}
