variable "subnet_id" {
  type    = string
  default = "subnet-12345"
}

variable "secondary_ebs_volumes" {
  type = list(object({
    device_name = string
    mount_point = string
    volume_size = number
  }))
  default = [{
    device_name = "/dev/xvdf"
    mount_point = "/data"
    volume_size = 100
    },
    {
      device_name = "/dev/xvdi"
      mount_point = "/mnt/ebs1"
      volume_size = 300
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

