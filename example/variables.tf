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

