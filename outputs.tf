# /outputs.tf

output "instance_id" {
  description = "The ID of the EC2 instance."
  value       = aws_instance.this.id
}

output "arn" {
  description = "The ARN of the EC2 instance."
  value       = aws_instance.this.arn
}

output "private_ip" {
  description = "The private IP address assigned to the instance."
  value       = aws_instance.this.private_ip
}

output "public_ip" {
  description = "The public IP address assigned to the instance, if applicable."
  value       = aws_instance.this.public_ip
}

output "primary_network_interface_id" {
  description = "The ID of the primary network interface."
  value       = aws_instance.this.primary_network_interface_id
}
