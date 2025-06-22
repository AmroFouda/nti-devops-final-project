
output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main_vpc.id
}

output "jenkins_public_ip" {
  description = "Jenkins Server Public IP"
  value       = aws_instance.jenkins-server.public_ip
}

output "jenkins_private_key_path" {
  description = "Private Key Path for Jenkins Server"
  value       = local_sensitive_file.jenkins_private_key.filename
}

output "ecr_repository_url" {
  description = "ECR Repository URL"
  value       = aws_ecr_repository.app_repo.repository_url
}

output "connect_to_jenkins" {
  description = "Command to connect via SSH"
  value       = "ssh -i ${local_sensitive_file.jenkins_private_key.filename} ubuntu@${aws_instance.jenkins-server.public_ip}"
}

output "docker_login_command" {
  description = "Docker login command for ECR"
  value       = "aws ecr get-login-password | docker login --username AWS --password-stdin ${aws_ecr_repository.app_repo.repository_url}"
}
output "rds_endpoint" {
  description = "RDS Instance Endpoint"
  value       = aws_db_instance.nti_db.endpoint
}