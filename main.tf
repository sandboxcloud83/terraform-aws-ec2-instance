# /main.tf

resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids  = var.vpc_security_group_ids
  iam_instance_profile    = var.iam_instance_profile_name
  key_name                = var.key_name
  user_data_base64        = var.user_data_base64
  ebs_optimized           = var.ebs_optimized
  monitoring              = var.monitoring

  associate_public_ip_address = var.associate_public_ip_address

  # Secure-by-default: Enforce IMDSv2
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    instance_metadata_tags      = var.instance_metadata_tags_enabled ? "enabled" : "disabled"
  }

  # Secure-by-default: Enable EBS encryption for the root volume
  root_block_device {
    encrypted   = true
    kms_key_id  = var.kms_key_id_for_ebs
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
  }

  tags = merge(
    { "Name" = var.instance_name },
    var.tags
  )

  lifecycle {
    ignore_changes = [ami]
  }
}
