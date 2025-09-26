# /variables.tf

variable "instance_name" {
  description = "The name of the EC2 instance, will be used as the Name tag."
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to use for the instance."
  type        = string
}

variable "instance_type" {
  description = "The instance type to use."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the instance in."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with the instance."
  type        = list(string)
  default     = []
}

variable "iam_instance_profile_name" {
  description = "The name of the IAM instance profile to associate with the instance."
  type        = string
  default     = null
}

variable "key_name" {
  description = "The key name of the Key Pair to use for the instance."
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "If true, the instance will have a public IP address."
  type        = bool
  default     = false
}

variable "user_data_base64" {
  description = "The user data to provide when launching the instance, encoded in base64."
  type        = string
  default     = null
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled."
  type        = bool
  default     = false
}

variable "ebs_optimized" {
  description = "If true, the instance is launched as an EBS-optimized instance."
  type        = bool
  default     = false
}

variable "kms_key_id_for_ebs" {
  description = "The ARN of the KMS key to use for EBS encryption. If not specified, the default AWS managed key is used."
  type        = string
  default     = null
}

variable "root_volume_size" {
  description = "The size of the root volume in gigabytes."
  type        = number
  default     = 8
}

variable "root_volume_type" {
  description = "The type of root volume. Can be 'gp2', 'gp3', 'io1', 'io2', 'st1', 'sc1', or 'standard'."
  type        = string
  default     = "gp3"
}

variable "instance_metadata_tags_enabled" {
  description = "Whether the EC2 instance metadata tags are enabled."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
