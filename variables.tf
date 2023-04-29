variable "subnet_id" {
  description = "Zones to launch our instances into"
  type        = string
  default     = ""
}

variable "secondary_ebs_volumes" {
  type = list(object({
    device_name = string
    mount_point = string
    volume_size = number
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
  type = string
  default = null
}
