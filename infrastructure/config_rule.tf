resource "aws_config_config_rule" "iam_user_mfa_enabled" {
  name        = "iam-user-mfa-enabled"
  description = "Checks whether the AWS Identity and Access Management (IAM) users have multi-factor authentication (MFA) enabled."

  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_MFA_ENABLED"
  }

  scope {
    compliance_resource_types = ["AWS::IAM::User"]
  }

  depends_on = [aws_config_configuration_recorder_status.main]
}