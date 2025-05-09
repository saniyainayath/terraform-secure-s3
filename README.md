# Secure Infrastructure with Terraform and GitHub Actions

This repository contains Terraform code to deploy a secure AWS infrastructure including S3 bucket configurations and IAM policies. It uses GitHub Actions for automated CI/CD workflows.

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Setup and Deployment](#setup-and-deployment)
- [CI/CD Pipeline](#cicd-pipeline)
- [License](#license)

## Overview
This Terraform configuration provisions a secure AWS environment by:

### Creating an S3 bucket with:
- Versioning enabled
- Server-side encryption
- Lifecycle rules to manage object expiration

### Enforcing Multi-Factor Authentication (MFA) for IAM users via policy attachment

This project emphasizes security best practices in AWS infrastructure provisioning.

## ⚙️ Prerequisites
Make sure you have the following before deploying:

- **Terraform** installed
- **A GitHub account**
- **An AWS account** with:
  - Sufficient IAM permissions
  - Programmatic access (access key & secret key)

## Setup and Deployment

### Clone the Repository
```bash
git clone https://github.com/saniyainayath/terraform-secure-s3.git
cd terraform-secure-s3
--> Configure AWS Credentials
There are two ways to provide credentials:

If Using GitHub Actions (Recommended):

-->Go to your GitHub repository → Settings → Secrets and variables → Actions.

Add the following secrets:

AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
These secrets will be used in the GitHub Actions workflow to authenticate securely with AWS.

-->If Running Locally:

You can configure AWS credentials by using environment variables or the AWS CLI.

Using Environment Variables:

Set the AWS credentials as environment variables:

export AWS_ACCESS_KEY_ID=your_access_key
export AWS_SECRET_ACCESS_KEY=your_secret_key

       Or

Configure via AWS CLI:

Run the AWS CLI configuration command to set up your credentials:

aws configure

--> Initialize and Apply Terraform
Once the credentials are configured, initialize Terraform and apply the configuration:

terraform init
terraform plan
terraform apply

⚙️ CI/CD Pipeline
The repository includes a GitHub Actions workflow that:

--Runs terraform init, plan and apply on push to the main branch.
--Uses the secrets to authenticate securely with AWS.
--Automates infrastructure provisioning and updates.

💡 You can customize the workflow in .github/workflows/main.yml.
