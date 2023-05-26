variable "subnet_id" {
  description = "Zones to launch our instances into"
  type        = string
  default     = ""
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
  default = null
}

variable "secondary_existing_ebs_volumes" {
  type = list(object({
    device_name = string
    mount_point = string
    volume_id   = string
  }))
  default = null
}

variable "instance_id" {
  type    = string
  default = null
}
