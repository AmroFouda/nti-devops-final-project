provider "aws" {
  region = var.region
}
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}
variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project Name"
  default     = "nti-devops-project"
}