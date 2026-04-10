output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.flask_server.public_ip
}

output "app_url" {
  description = "URL to access the Flask app"
  value       = "http://${aws_instance.flask_server.public_ip}:5000"
}

output "prometheus_url" {
  description = "URL to access Prometheus"
  value       = "http://${aws_instance.flask_server.public_ip}:9090"
}

output "grafana_url" {
  description = "URL to access Grafana"
  value       = "http://${aws_instance.flask_server.public_ip}:3000"
}

