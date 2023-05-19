terraform {
  required_providers {
    aviatrix = {
      source = "aviatrixsystems/aviatrix"
    }  
  }  
}  
/*provider "aws" {
  region = var.aws_region
}*/

data "aws_caller_identity" "current" {}

/*module "aviatrix-iam-roles" {
  source = "github.com/AviatrixSystems/terraform-modules.git//aviatrix-controller-iam-roles?ref=master"
}*/

module "aviatrix-iam-roles" {
  source = "git::https://github.com/domenicomarinoaviatrix/aws-cicd-pipeline.git//aviatrix-controller-iam-roles"
}


/*module "aviatrix-controller-build" {
  source            = "github.com/AviatrixSystems/terraform-modules.git//aviatrix-controller-build?ref=master"
  vpc               = var.vpc_controller
  subnet            = var.subnet_controller
  keypair           = var.keypair_name_controller
  type              = var.type
  ec2role           = module.aviatrix-iam-roles.aviatrix-role-ec2-name
  incoming_ssl_cidr = ["10.20.30.0/24","0.0.0.0/0"] 
}

provider "aviatrix" {
  username      = "admin"
  password      = module.aviatrix-controller-build.private_ip
  controller_ip = module.aviatrix-controller-build.public_ip
}

module "aviatrix-controller-initialize" {
  source              = "github.com/AviatrixSystems/terraform-modules.git//aviatrix-controller-initialize?ref=master"
  admin_password      = var.controller_password
  admin_email         = "dmarino@aviatrix.com"
  private_ip          = module.aviatrix-controller-build.private_ip
  public_ip           = module.aviatrix-controller-build.public_ip
  access_account_name = var.account_name
  aws_account_id      = data.aws_caller_identity.current.account_id
  vpc_id              = module.aviatrix-controller-build.vpc_id
  subnet_id           = module.aviatrix-controller-build.subnet_id
  customer_license_id = var.customer_license_id
  controller_version  = var.controller_version
}

output "result" {
  value = module.aviatrix-controller-initialize.result
}

output "controller_private_ip" {
  value = module.aviatrix-controller-build.private_ip
}

output "controller_public_ip" {
  value = module.aviatrix-controller-build.public_ip
}*/