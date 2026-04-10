variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type for the server"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "EC2 Key Pair name to use for SSH access"
  type        = string
  default     = "flask-cicd-key"
}

variable "docker_username" {
  description = "DockerHub username for pulling images"
  type        = string
}

variable "docker_password" {
  description = "DockerHub password for pulling images"
  type        = string
  sensitive   = true
}

variable "security_group_name" {
  description = "Name of the security group for the EC2 instance"
  type        = string
  default     = "flask-cicd-sg"
}

variable "project_name" {
  description = "Project name for tagging AWS resources"
  type        = string
  default     = "flask-cicd"
}

