# Secure Infrastructure with Terraform and GitHub Actions

This repository contains Terraform code to deploy a secure AWS infrastructure including S3 bucket configurations and IAM policies. It uses GitHub Actions for automated CI/CD workflows.

## 📚 Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Setup and Deployment](#setup-and-deployment)
- [CI/CD Pipeline](#cicd-pipeline)
- [License](#license)

## 🔍 Overview
This Terraform configuration provisions a secure AWS environment by:

### ✅ Creating an S3 bucket with:
- Versioning enabled
- Server-side encryption
- Lifecycle rules to manage object expiration

### ✅ Enforcing Multi-Factor Authentication (MFA) for IAM users via policy attachment

This project emphasizes security best practices in AWS infrastructure provisioning.

## ⚙️ Prerequisites
Make sure you have the following before deploying:

- **Terraform** installed
- **A GitHub account**
- **An AWS account** with:
  - Sufficient IAM permissions
  - Programmatic access (access key & secret key)

## 🚀 Setup and Deployment

1. **Clone the Repository**
   ```bash
   git clone https://github.com/saniyainayath/terraform-secure-s3.git
   cd terraform-secure-s3
