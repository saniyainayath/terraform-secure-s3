# Secure Infrastructure with Terraform and GitHub Actions

This repository contains Terraform code to deploy a secure AWS infrastructure with IAM policies and S3 bucket configurations. It utilizes GitHub Actions for continuous integration and continuous deployment (CI/CD).

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Setup and Deployment](#setup-and-deployment)
- [CI/CD Pipeline](#cicd-pipeline)
- [License](#license)

## Overview

This repository sets up a secure AWS infrastructure by:
- Creating a unique S3 bucket with versioning, encryption, and lifecycle rules.
- Enforcing MFA for IAM users through policy attachment.

The goal of this project is to implement secure infrastructure practices using Terraform, ensuring best practices like encryption and access control are in place.

## Prerequisites

Before you begin, ensure you have the following:
- **Terraform** installed on your local machine. Follow the [Terraform installation guide](https://www.terraform.io/docs/install).
- **GitHub account** to store and manage your Terraform code.
- **AWS account** and configured **AWS credentials** to allow Terraform to interact with AWS services.

## Setup and Deployment

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/terraform-secure-infra.git
   cd terraform-secure-infra
