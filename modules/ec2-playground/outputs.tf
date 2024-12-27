output "instance_id" {
  description = "IP da instância EC2"
  value       = aws_instance.ec2_instance.public_ip
}
