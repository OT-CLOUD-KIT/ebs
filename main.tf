data "template_file" "new_ebs" {
  count    = var.secondary_ebs_volumes != null ? length(var.secondary_ebs_volumes) : 0
  template = file("${path.module}/user-data.sh.tpl")
  vars = {
    device_name = var.secondary_ebs_volumes[count.index].device_name
    mount_point = var.secondary_ebs_volumes[count.index].mount_point
  }
}

data "template_file" "existing_ebs_volumes" {
  count    = var.secondary_existing_ebs_volumes != null ? length(var.secondary_existing_ebs_volumes) : 0
  template = file("${path.module}/user-data.sh.tpl")
  vars = {
    device_name = var.secondary_existing_ebs_volumes[count.index].device_name
    mount_point = var.secondary_existing_ebs_volumes[count.index].mount_point
  }
}

data "aws_subnet" "id" {
  count = var.secondary_ebs_volumes != null ? 1 : 0
  id    = var.subnet_id
}

resource "aws_ebs_volume" "additional" {
  count             = var.secondary_ebs_volumes != null ? length(var.secondary_ebs_volumes) : 0
  availability_zone = data.aws_subnet.id[0].availability_zone
  size              = var.secondary_ebs_volumes[count.index].volume_size
}

resource "aws_volume_attachment" "ebs" {
  count       = var.secondary_ebs_volumes != null ? length(var.secondary_ebs_volumes) : 0
  device_name = var.secondary_ebs_volumes[count.index].device_name
  volume_id   = aws_ebs_volume.additional[count.index].id
  instance_id = var.instance_id
}

resource "aws_volume_attachment" "existing_ebs_volumes" {
  count       = var.secondary_existing_ebs_volumes != null ? length(var.secondary_existing_ebs_volumes) : 0
  device_name = var.secondary_existing_ebs_volumes[count.index].device_name
  volume_id   = var.secondary_existing_ebs_volumes[count.index].volume_id
  instance_id = var.instance_id
}