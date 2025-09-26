output "instance_private_ip" {
  description = "The private IP address of the example EC2 instance."
  value       = module.app_server.private_ip
}
