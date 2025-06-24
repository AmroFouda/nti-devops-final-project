# 🚀 NTI DevOps Final Project  

This project showcases a full DevOps pipeline implementation using modern tools and best practices, as part of the NTI DevOps program.

---

## 🎯 Project Goals

- Deploy a 3-tier Node.js application (frontend, backend, database) using Infrastructure as Code.
- Implement a CI/CD pipeline using Jenkins and GitHub.
- Apply security, monitoring, and scalability best practices.

---

## 🛠️ Tech Stack

- **Infrastructure:** Terraform, AWS (EKS, EC2, RDS, S3, ECR, Secrets Manager, Backup)
- **Configuration Management:** Ansible
- **Containerization:** Docker, Docker Compose
- **Orchestration:** Kubernetes (EKS), Helm
- **CI/CD:** Jenkins, GitHub
- **Security:** Trivy, AWS IAM, Network Policies
- **Monitoring:** Prometheus, Grafana, AWS CloudWatch
- **Code Quality:** SonarQube

---

## 📁 Project Structure

```bash
nti-devops-final-project/
├── 3tier-nodejs/             # Frontend & backend application code
│   ├── frontend/             # React frontend app
│   └── backend/              # Node.js backend app
│
├── ansible/                  # Ansible for configuration management
│   ├── inventory.ini
│   └── playbooks/
│       └── jenkins-setup.yaml
│
├── docker/                   # Dockerfiles for local development
│   ├── frontend/
│   └── backend/
│
├── kubernetes/               # Kubernetes manifests for EKS
│   ├── frontend-deployment.yaml
│   └── backend-deployment.yaml
│
├── terraform/                # Terraform IaC files
│   ├── main.tf
│   ├── vpc.tf
│   ├── eks.tf
│   ├── rds.tf
│   ├── jenkins.tf
│   ├── ecr.tf
│   ├── outputs.tf
│   └── jenkins-key.pem (ignored)
│
├── docker-compose.yml        # Run app locally
├── .gitignore                # Ignore sensitive/unnecessary files
└── README.md

## 🚀 How to Use

### 1. Infrastructure Provisioning (Terraform)

cd terraform/
terraform init
terraform plan
terraform apply



---

## 🔧 Infrastructure Setup with Terraform

Provision the entire AWS environment using:

- EKS cluster (2 nodes + auto scaling group + ELB)
- RDS (MySQL/PostgreSQL) with credentials in Secrets Manager
- EC2 instance for Jenkins
- S3 bucket for ELB access logs
- ECR for Docker images
- AWS Backup to take daily snapshots of Jenkins instance


cd terraform
terraform init
terraform apply
🤖 Configuration Management with Ansible
Install Jenkins and CloudWatch agent:
cd ansible
ansible-playbook playbooks/jenkins-setup.yaml -i inventory.ini
🐳 Local Development with Docker Compose
docker compose up --build
☸️ Kubernetes Deployment
kubectl apply -f kubernetes/
🔁 Jenkins CI/CD Pipeline
Jenkins pipeline is triggered on GitHub pushes and includes:

1-SonarQube Code Quality Scan

2-Trivy Docker Image Scan

3-Build and Push Docker Image to ECR

4-Deploy to Kubernetes using Helm

📊 Monitoring & Alerting
Prometheus monitors pods and nodes.

Grafana provides dashboards with app metrics.

Alerts are triggered if any pod exceeds 80% CPU or memory.

🛡️ Security Measures
.gitignore ensures sensitive and auto-generated files are excluded (e.g., .pem, .tfstate, .terraform/, node_modules/, venv/, .env)

RDS credentials stored in AWS Secrets Manager.

Network Policies restrict communication between Kubernetes pods.

CI pipeline fails if SonarQube or Trivy scans fail.

📸 Screenshots / Architecture Diagram
(Add screenshots of: Jenkins pipeline, Grafana dashboards, AWS architecture diagram, etc. if available)

👤 Author
Amro Fouda
GitHub: @AmroFouda



