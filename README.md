Secure Infrastructure with Terraform and GitHub Actions
This repository contains Terraform code to deploy a secure AWS infrastructure including S3 bucket configurations and IAM policies. It uses GitHub Actions for automated CI/CD workflows.

📚 Table of Contents
Overview

Prerequisites

Setup and Deployment

CI/CD Pipeline

License

🔍 Overview
This Terraform configuration provisions a secure AWS environment by:

Creating an S3 bucket with:

Versioning enabled

Server-side encryption

Lifecycle rules to manage object expiration

Enforcing Multi-Factor Authentication (MFA) for IAM users via policy attachment

This project emphasizes security best practices in AWS infrastructure provisioning.

⚙️ Prerequisites
Make sure you have the following before deploying:

Terraform installed

A GitHub account

An AWS account with:

Sufficient IAM permissions

Programmatic access (access key & secret key)

Setup and Deployment

1. Clone the Repository
bash
Copy
Edit
git clone https://github.com/saniyainayath/terraform-secure-s3.git
cd terraform-secure-s3
2. Configure AWS Credentials
There are two ways to provide credentials:

🔐 If Using GitHub Actions (Recommended):
Go to your repo → Settings → Secrets and variables → Actions and add:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

These are used in the GitHub Actions workflow to authenticate with AWS.

💻 If Running Locally:
Use environment variables or the AWS CLI:

bash
Copy
Edit
export AWS_ACCESS_KEY_ID=your_access_key
export AWS_SECRET_ACCESS_KEY=your_secret_key
Or:

aws configure

3. Initialize and Apply Terraform

terraform init
terraform plan
terraform apply

⚙️ CI/CD Pipeline
The repository includes a GitHub Actions workflow that:

Runs terraform init, plan, and apply on push to main

Uses secrets to authenticate securely with AWS

Automates infrastructure provisioning and updates

💡 You can customize the workflow in .github/workflows/main.yml.
