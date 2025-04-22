provider "aws" {
  region = "us-east-1"
}

resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_s3_bucket" "test_bucket" {
  bucket        = "my-unique-bucket-${random_id.bucket_id.hex}"
  force_destroy = true
}

# Enable S3 Bucket Versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.test_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable Lifecycle Rule (Guardrail)
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.test_bucket.id

  rule {
    id     = "expire-noncurrent-versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }
}

# Enable Default Server-Side Encryption (Guardrail)
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.test_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# IAM Group and MFA Policy
resource "aws_iam_group" "mfa_enforced_group" {
  name = "MFAEnforcedGroup"
}

# Policy to enforce MFA
resource "aws_iam_policy" "enforce_mfa_policy" {
  name        = "EnforceMFA"
  path        = "/"
  description = "Policy to enforce MFA"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowViewAccountInfo",
        Effect = "Allow",
        Action = [
          "iam:GetAccountPasswordPolicy",
          "iam:ListVirtualMFADevices"
        ],
        Resource = "*"
      },
      {
        Sid    = "AllowManageOwnPasswords",
        Effect = "Allow",
        Action = [
          "iam:ChangePassword",
          "iam:GetUser"
        ],
        Resource = "arn:aws:iam::*:user/${aws:username}"
      },
      {
        Sid    = "AllowManageOwnAccessKeys",
        Effect = "Allow",
        Action = [
          "iam:CreateAccessKey",
          "iam:DeleteAccessKey",
          "iam:ListAccessKeys",
          "iam:UpdateAccessKey",
          "iam:GetAccessKeyLastUsed"
        ],
        Resource = "arn:aws:iam::*:user/${aws:username}"
      },
      {
        Sid    = "AllowManageOwnSigningCertificates",
        Effect = "Allow",
        Action = [
          "iam:DeleteSigningCertificate",
          "iam:ListSigningCertificates",
          "iam:UpdateSigningCertificate",
          "iam:UploadSigningCertificate"
        ],
        Resource = "arn:aws:iam::*:user/${aws:username}"
      },
      {
        Sid    = "AllowManageOwnSSHPublicKeys",
        Effect = "Allow",
        Action = [
          "iam:DeleteSSHPublicKey",
          "iam:GetSSHPublicKey",
          "iam:ListSSHPublicKeys",
          "iam:UpdateSSHPublicKey",
          "iam:UploadSSHPublicKey"
        ],
        Resource = "arn:aws:iam::*:user/${aws:username}"
      },
      {
        Sid    = "AllowManageOwnGitCredentials",
        Effect = "Allow",
        Action = [
          "iam:CreateServiceSpecificCredential",
          "iam:DeleteServiceSpecificCredential",
          "iam:ListServiceSpecificCredentials",
          "iam:ResetServiceSpecificCredential",
          "iam:UpdateServiceSpecificCredential"
        ],
        Resource = "arn:aws:iam::*:user/${aws:username}"
      },
      {
        Sid    = "AllowManageOwnVirtualMFADevice",
        Effect = "Allow",
        Action = [
          "iam:CreateVirtualMFADevice"
        ],
        Resource = "arn:aws:iam::*:mfa/*"
      },
      {
        Sid    = "AllowManageOwnUserMFA",
        Effect = "Allow",
        Action = [
          "iam:DeactivateMFADevice",
          "iam:EnableMFADevice",
          "iam:ListMFADevices",
          "iam:ResyncMFADevice"
        ],
        Resource = "arn:aws:iam::*:user/${aws:username}"
      },
      {
        Sid       = "DenyAllExceptListedIfNoMFA",
        Effect    = "Deny",
        NotAction = [
          "iam:CreateVirtualMFADevice",
          "iam:EnableMFADevice",
          "iam:GetUser",
          "iam:GetMFADevice",
          "iam:ListMFADevices",
          "iam:ListVirtualMFADevices",
          "iam:ResyncMFADevice",
          "sts:GetSessionToken"
        ],
        Resource = "*",
        Condition = {
          BoolIfExists = {
            "aws:MultiFactorAuthPresent" = "false"
          }
        }
      }
    ]
  })
}

# Attach MFA policy to the IAM group
resource "aws_iam_group_policy_attachment" "attach_mfa_policy" {
  group      = aws_iam_group.mfa_enforced_group.name
  policy_arn = aws_iam_policy.enforce_mfa_policy.arn
}
