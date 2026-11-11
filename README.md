# Terraform + GitHub Actions CI/CD on AWS EC2

## Project Overview

This project demonstrates how to provision AWS infrastructure using Terraform and automate website deployment using GitHub Actions.

Terraform is used to create the required AWS infrastructure, including a VPC, public subnet, Internet Gateway, route table, security group, and EC2 instance.

GitHub Actions automates website deployment whenever changes are pushed to the `main` branch. It connects to the EC2 instance using SSH, transfers website files using SCP, and executes a deployment script to update the Nginx web server.

## Architecture

**Deployment Flow:**

1. Developer updates website code.
2. Changes are pushed to the GitHub repository.
3. GitHub Actions workflow is triggered.
4. GitHub Actions connects to the AWS EC2 instance using SSH.
5. Website files and deployment script are transferred using SCP.
6. Deployment script updates the Nginx web directory.
7. Updated website becomes available through the EC2 public IP.

## Technologies Used

- **AWS EC2:** Hosts the website.
- **AWS VPC:** Provides network isolation.
- **Terraform:** Provisions AWS infrastructure using Infrastructure as Code (IaC).
- **Git & GitHub:** Version control and source code management.
- **GitHub Actions:** Automates website deployment.
- **Nginx:** Web server hosting the website.
- **Linux / Bash:** Executes deployment commands and manages the web server.
- **SSH:** Provides secure remote access to EC2.
- **SCP:** Transfers website files to EC2.

## Project Structure

```text
terraform-aws-cicd/
│
├── .github/
│   └── workflows/
│       └── deploy.yml
│
├── infrastructure/
│   ├── ec2.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── script.sh
│   ├── sg.tf
│   ├── variables.tf
│   └── vpc.tf
│
├── website/
│   └── index.html
│
├── deploy.sh
├── .gitignore
└── README.md
```

## Infrastructure Provisioning with Terraform

Terraform provisions the following AWS resources:

- Custom VPC.
- Public subnet.
- Internet Gateway.
- Public route table and route association.
- Security group with SSH and HTTP access.
- EC2 instance with a public IP address.
- AWS key pair for SSH authentication.

The EC2 instance is configured with Nginx using a user-data script.

### Terraform Commands

Run these commands from the `infrastructure` directory:

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

After provisioning, retrieve the EC2 public IP:

```bash
terraform output -raw instance_public_ip
```

## Automated Deployment with GitHub Actions

The GitHub Actions workflow is located at:

`.github/workflows/deploy.yml`

The workflow is triggered when changes are pushed to the `main` branch and affect the website, deployment script, or workflow file.

### Deployment Steps

1. Checkout the GitHub repository.
2. Configure the SSH private key.
3. Connect to the EC2 instance.
4. Copy the website directory using SCP.
5. Copy the deployment script using SCP.
6. Execute the deployment script remotely.

## GitHub Repository Secrets

The following repository secrets are required:

| Secret | Description |
|---|---|
| `EC2_SSH_KEY` | EC2 SSH private key |
| `EC2_USER` | EC2 username (`ubuntu`) |
| `EC2_HOST` | EC2 public IP address |

Configure these under:

**GitHub Repository → Settings → Secrets and variables → Actions**

Never upload your private SSH key or AWS credentials to GitHub.

## Deployment Script

The `deploy.sh` script performs the following operations:

- Enables error handling using `set -e`.
- Copies the updated HTML file to `/var/www/html/`.
- Restarts the Nginx service.
- Displays a deployment success message.

## Testing the CI/CD Pipeline

1. Modify the `website/index.html` file.
2. Stage and commit the changes:

```bash
git add website/index.html
git commit -m "Update website content"
```

3. Push the changes:

```bash
git push origin main
```

4. Open the GitHub repository's **Actions** tab.
5. Verify that the deployment workflow completes successfully.
6. Refresh the EC2 public IP in your browser to see the updated website.

## Key Learnings

- Provisioning AWS infrastructure using Terraform.
- Understanding Infrastructure as Code (IaC).
- Configuring AWS networking and EC2 instances.
- Automating deployments using GitHub Actions.
- Connecting to remote servers using SSH.
- Transferring files using SCP.
- Writing Bash deployment scripts.
- Hosting and updating websites using Nginx.

## Future Improvements

- Configure Terraform remote state management using Amazon S3.
- Improve SSH security and host key verification.
- Add automated deployment validation.
- Introduce separate development and production environments.
