/*terraform {
  required_providers {
    aviatrix = {
      source = "aviatrixsystems/aviatrix"
    }  
  }  
}*/  
/*provider "aws" {
  region = var.aws_region
}*/

#data "aws_caller_identity" "current" {}

/*module "aviatrix-iam-roles" {
  source = "github.com/AviatrixSystems/terraform-modules.git//aviatrix-controller-iam-roles?ref=master"
}*/

module "aviatrix-controller-build2" {
  source            = "git::https://github.com/domenicomarinoaviatrix/aws-cicd-pipeline.git//aviatrix-controller-build"
  vpc               = var.vpc_controller
  subnet            = var.subnet_controller
  keypair           = var.keypair_name_controller
  type              = var.type
  controller_name   = "NewController"
  ec2role           = module.aviatrix-iam-roles.aviatrix-role-ec2-name
  incoming_ssl_cidr = ["10.20.30.0/24","0.0.0.0/0"] /*review!!!!!!!!*/
}

provider "aviatrix2" {
  username      = "admin"
  password      = module.aviatrix-controller-build2.private_ip
  controller_ip = module.aviatrix-controller-build2.public_ip
}

module "aviatrix-controller-initialize2" {
  source              = "github.com/AviatrixSystems/terraform-modules.git//aviatrix-controller-initialize?ref=master"
  admin_password      = var.controller_password
  admin_email         = "dmarino@aviatrix.com"
  private_ip          = module.aviatrix-controller-build2.private_ip
  public_ip           = module.aviatrix-controller-build2.public_ip
  access_account_name = var.account_name
  aws_account_id      = data.aws_caller_identity.current.account_id
  vpc_id              = module.aviatrix-controller-build2.vpc_id
  subnet_id           = module.aviatrix-controller-build2.subnet_id
  customer_license_id = var.customer_license_id
  controller_version  = var.controller_version
}

output "result2" {
  value = module.aviatrix-controller-initialize2.result
}

output "controller_private_ip2" {
  value = module.aviatrix-controller-build2.private_ip
}

output "controller_public_ip2" {
  value = module.aviatrix-controller-build2.public_ip
}