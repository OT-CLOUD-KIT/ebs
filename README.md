# EBS
[![Opstree Solutions][opstree_avatar]][opstree_homepage]<br/>[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

This terraform module will help users in:
- Creating new EBS volumes and will attach and mount to the EC2 instance
- Attach and mount already existing EBS volumes to EC2 instance

## Prerequisites
- AWS access of root account/management account of control tower with admin privilege
- Terraform
- AWS CLI

## Providers
AWS

## Note
- Before using EBS module you have check [device name](https://github.com/awsdocs/amazon-ec2-user-guide/blob/master/doc_source/device_naming.md) for different instance type.
- There is cloud init script in example directory user that script with your EC2 instance so that EBS volume will automatically mounted on restart of the instance.

## Inputs
| Name | Description | Type | Default | Required |
|-------|----------|------|-----|-----|
|subnet_id| In which subnet your EC2 instance is running or going to run| string | null | yes|
| instance_id | You instance Id to which your instance is going to attach and mount | string | null |yes|
| secondary_ebs_volumes | For creating new EBS volumes | list(object) | null | no|
| secondary_existing_ebs_volumes | For already existing EBS volumes | list(object) | null | no|

## Outputs
| Name | Description |
|------|-------------|
|new_ebs_user_data| User data for new EBS volumes to EC2 instance|
|existing_ebs_user_data |  User data for aleady existing EBS volumes to EC2 instance|
| vol_id | Volume id for newly created EBS volume|

```hcl
module "ebs" {
  source                         = "../modules/ebs"
  subnet_id                      = var.subnet_id
  instance_id                    = "You instance id"
  secondary_ebs_volumes          = var.secondary_ebs_volumes
  secondary_existing_ebs_volumes = var.secondary_existing_ebs_volumes
}

variable "subnet_id" {
  type    = string
  default = "subnet-12345"
}

variable "secondary_ebs_volumes" {
  type = list(object({
    device_name          = string
    mount_point          = string
    volume_size          = number
    encrypted            = optional(bool, false)
    kms_key_id           = optional(string)
    final_snapshot       = optional(bool, false)
    multi_attach_enabled = optional(bool, false)
    outpost_arn          = optional(string)
    type                 = optional(string, "gp2")
    snapshot_id          = optional(string)
    iops                 = optional(number)
    throughput           = optional(number)
    tags                 = optional(map(string))
  }))
  default = [{
    device_name    = "/dev/xvdf"
    mount_point    = "/data"
    volume_size    = 100
    encrypted      = true
    final_snapshot = true
    kms_key_id     = "kms-key-arn"
    tags = {
      "Name" = "EBS-Volume"
    }
    }
  ]
  description = "Variables for creating new EBS volumes"
}

variable "secondary_existing_ebs_volumes" {
  type = list(object({
    device_name = string
    mount_point = string
    volume_id   = string
  }))
  default = [
    {
      device_name = "/dev/xvdj"
      mount_point = "/volume1"
      volume_id   = "vol-123456"
    },
    {
      device_name = "/dev/xvdk"
      mount_point = "/volume2"
      volume_id   = "vol-56789"
    }
  ]
  description = "Variables for already existing EBS volumes"
}

```

### Contributors
[Ashutosh Yadav](https://github.com/ashutoshyadav66)