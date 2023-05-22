module "aviatrix-controller-build2" {
  source            = "git::https://github.com/domenicomarinoaviatrix/aws-cicd-pipeline.git//aviatrix-controller-build"
  vpc               = var.vpc_controller
  subnet            = var.subnet_controller
  keypair           = var.keypair_name_controller
  type              = var.type
  controller_name   = "NewController"
  ec2role           = module.aviatrix-iam-roles.aviatrix-role-ec2-name
  incoming_ssl_cidr = ["10.20.30.0/24","0.0.0.0/0"] 
}