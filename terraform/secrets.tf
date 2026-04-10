resource "aws_secretsmanager_secret" "dockerhub" {
  name                    = "flask-cicd/dockerhub"
  description             = "DockerHub credentials for flask-cicd-pipeline"
  recovery_window_in_days = 0  # Allow immediate deletion
}

resource "aws_secretsmanager_secret_version" "dockerhub" {
  secret_id     = aws_secretsmanager_secret.dockerhub.id
  secret_string = jsonencode({
    username = var.docker_username
    password = var.docker_password
  })
}

