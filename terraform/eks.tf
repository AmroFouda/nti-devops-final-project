resource "aws_iam_role" "eks_role" {
  name = "${var.project_name}-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks-policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_cluster" "nti_eks" {
  name     = "${var.project_name}-eks-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = aws_subnet.public_subnets[*].id
  }

  depends_on = [aws_iam_role_policy_attachment.eks-policy]
}
# IAM Role لـ Worker Nodes
resource "aws_iam_role" "eks_worker_role" {
  name = "${var.project_name}-eks-worker-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "worker-policy" {
  role       = aws_iam_role.eks_worker_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "cni-policy" {
  role       = aws_iam_role.eks_worker_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ecr-access" {
  role       = aws_iam_role.eks_worker_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Launch Template
resource "aws_launch_template" "eks-node-lt" {
  name = "${var.project_name}-eks-node-lt"

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 20
      volume_type = "gp2"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-eks-node"
    }
  }

  image_id      = "ami-0dc3a08bd93f84a35" 
  instance_type = "t3.medium"
  key_name      = aws_key_pair.jenkins-key.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.worker_profile.name
  }

  user_data = base64encode(<<EOF
#!/bin/bash
echo "Environment=\"prod\"" >> /etc/default/kubelet
EOF
  )
 
 
}

resource "aws_iam_instance_profile" "worker_profile" {
  name = "${var.project_name}-worker-profile"
  role = aws_iam_role.eks_worker_role.name
}

# Auto Scaling Group
resource "aws_autoscaling_group" "eks-worker-asg" {
  name             = "${var.project_name}-eks-workers"
  launch_template {
    id      = aws_launch_template.eks-node-lt.id
    version = "$Latest"
  }
  min_size     = 2
  max_size     = 4
  desired_capacity = 2
  vpc_zone_identifier = aws_subnet.public_subnets[*].id

  tag {
    key                 = "Name"
    value               = "${var.project_name}-eks-worker"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.project_name}-eks-cluster"
    value               = "owned"
    propagate_at_launch = true
  }
}