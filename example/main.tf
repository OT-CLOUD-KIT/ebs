module "ebs" {
  source                         = "../modules/ebs"
  subnet_id                      = var.subnet_id
  instance_id                    = module.instance.instance_id
  secondary_ebs_volumes          = var.secondary_ebs_volumes
  secondary_existing_ebs_volumes = var.secondary_existing_ebs_volumes
}

module "instance" {
  source          = "../modules/ec2-instance"
  .....


  user_data = join("\n",
    [file("${path.module}/cloud_init_script.sh")],
    module.ebs.new_ebs_user_data,
    module.ebs.existing_ebs_user_data
  )
}