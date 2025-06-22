
resource "aws_security_group" "jenkins-sg" {
  name        = "${var.project_name}-jenkins-sg"
  description = "Allow HTTP and SSH access to Jenkins"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-jenkins-sg"
  }
}

resource "tls_private_key" "jenkins_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "jenkins-key" {
  key_name   = "${var.project_name}-jenkins-key"
  public_key = tls_private_key.jenkins_ssh.public_key_openssh
}

resource "local_sensitive_file" "jenkins_private_key" {
  content  = tls_private_key.jenkins_ssh.private_key_pem
  filename = "${path.module}/jenkins-key.pem"
}

resource "aws_instance" "jenkins-server" {
  ami                    = "ami-020cba7c55df1f615" # Ubuntu 20.04
  instance_type            = "t2.medium"
  key_name               = aws_key_pair.jenkins-key.key_name
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  subnet_id              = element(aws_subnet.public_subnets[*].id, 0)
    associate_public_ip_address = true
    user_data = <<-EOF
            #!/bin/bash
sudo apt update -y
sudo apt install openjdk-17-jdk git docker.io -y

# Add Jenkins repo
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt-get install jenkins -y

# Enable and start Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Add Jenkins to Docker group
sudo usermod -aG docker jenkins

            EOF

  tags = {
    Name = "${var.project_name}-jenkins-server"
  }
}
