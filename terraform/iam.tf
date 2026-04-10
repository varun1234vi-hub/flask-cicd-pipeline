# IAM Role for EC2
resource "aws_iam_role" "flask_role" {
  name = "flask-cicd-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Attach CloudWatch policy (for monitoring/logging)
resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.flask_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Secrets Manager read policy (for DockerHub credentials)
resource "aws_iam_role_policy" "secrets_read" {
  name = "secrets-read"
  role = aws_iam_role.flask_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["secretsmanager:GetSecretValue"]
      Resource = aws_secretsmanager_secret.dockerhub.arn
    }]
  })
}

# Instance profile (wraps the IAM role for EC2 use)
resource "aws_iam_instance_profile" "flask_profile" {
  name = "flask-cicd-profile"
  role = aws_iam_role.flask_role.name
}

