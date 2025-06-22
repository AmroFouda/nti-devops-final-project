# NTI DevOps Final Project

This project showcases a full DevOps pipeline implementation using modern tools and best practices, as part of the NTI DevOps program.

---

## 🚀 Project Goals

- Deploy a 3-tier Node.js application (frontend, backend, database) using infrastructure as code.
- Implement CI/CD pipeline using Jenkins and GitHub.
- Apply security, monitoring, and scalability best practices.

---

## 🛠️ Tech Stack

- **Infrastructure:** Terraform, AWS (EKS, EC2, RDS, S3, ECR, Secrets Manager, Backup)
- **Configuration Management:** Ansible
- **Containerization:** Docker, Docker Compose
- **Orchestration:** Kubernetes (EKS), Helm
- **CI/CD:** Jenkins, GitHub
- **Security:** Trivy, AWS IAM
- **Monitoring:** Prometheus, Grafana, AWS CloudWatch
- **Quality Gates:** SonarQube

---

## 🧱 Project Structure

```bash
.
pre><code> 📁 nti-devops-final-project/ ├── 3tier-nodejs/ # Source code for frontend & backend apps │ ├── frontend/ # React frontend app │ └── backend/ # Node.js backend app │ ├── ansible/ # Ansible automation │ ├── inventory.ini # Ansible inventory file │ └── playbooks/ │ └── jenkins-setup.yaml │ ├── docker/ # Dockerfiles for local testing │ ├── frontend/ │ └── backend/ │ ├── kubernetes/ # Kubernetes manifests for EKS │ ├── frontend-deployment.yaml │ └── backend-deployment.yaml │ ├── terraform/ # Terraform IaC for AWS resources │ ├── main.tf # Entry point │ ├── vpc.tf # VPC setup │ ├── eks.tf # EKS cluster │ ├── rds.tf # RDS DB │ ├── jenkins.tf # Jenkins EC2 setup │ ├── ecr.tf # ECR registry │ ├── outputs.tf # Output variables │ └── jenkins-key.pem # SSH private key (ignored in Git) │ ├── docker-compose.yml # Run the full app locally ├── .gitignore # Ignore unnecessary/sensitive files └── README.md </code></pre>

## 🚀 How to Use

### 1. Infrastructure Provisioning (Terraform)

```bash
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

```bash
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



