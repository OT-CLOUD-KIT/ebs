output "new_ebs_user_data" {
  value       = var.secondary_ebs_volumes != null ? data.template_file.new_ebs.*.rendered : null
  description = "User data for EC2 instance of newly created EBS volumes"
}

output "existing_ebs_user_data" {
  value       = var.secondary_existing_ebs_volumes != null ? data.template_file.existing_ebs_volumes.*.rendered : null
  description = "User data for EC2 instance of already existing EBS volumes"
}

output "vol_id" {
  value       = var.secondary_ebs_volumes != null ? aws_ebs_volume.additional.*.id : null
  description = "EBS volume id of newly created volumes"
}