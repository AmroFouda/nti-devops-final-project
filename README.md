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
├── ansible/              # Jenkins setup and CloudWatch agent
├── docker/               # Dockerfiles for frontend and backend
├── kubernetes/           # K8s manifests + network policies
├── terraform/            # AWS infra setup (EKS, RDS, EC2, S3, Backup, etc.)
├── jenkins/              # Jenkins pipeline configuration
├── README.md
└── .gitignore
