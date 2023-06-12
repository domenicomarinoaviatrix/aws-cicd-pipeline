
# Security keys
##########################################################################

resource "tls_private_key" "avx_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "avx_key" {
  key_name   = "avx-controller"
  public_key = tls_private_key.avx_key.public_key_openssh

}

# Aviatrix IAM Roles 
########################################################################

# create roles
module "iam_roles" {
  #source = "github.com/AviatrixSystems/terraform-modules.git//aviatrix-controller-iam-roles?ref=terraform_0.14"
  source = "./aviatrix-controller-iam-roles"
  #secondary-account-ids = ["504080832914","590522406935","425467298012","181545098683","354819307327","997591977519","379680446365","905651102640"]
  secondary-account-ids = var.secondary_account_ids
}


# Controller
########################################################################

# create controller
module "aviatrix-controller-build" {
  source  = "github.com/AviatrixSystems/terraform-modules.git//aviatrix-controller-build"
  keypair = aws_key_pair.avx_key.key_name
  ec2role = module.iam_roles.aviatrix-role-ec2-name
  vpc     = var.vpc_id
  subnet  = var.subnet_id
  incoming_ssl_cidr = var.incoming_ssl_cidr_controller
  type              = "BYOL"
  controller_name   = "avx-controller-eu"
  instance_type     = "t3.large"
}

# CoPilot
########################################################################

# create eni
/*resource "aws_network_interface" "eni-copilot" {
  subnet_id       = var.subnet_id
  #security_groups = [aws_security_group.AviatrixSecurityGroupCPLT.id]
  security_groups = concat([aws_security_group.AviatrixSecurityGroupCPLT.id],var.add_copilot_security_group_ids)
}*/

# create instance
/*resource "aws_instance" "aviatrixcopilot" {

  ami           = "ami-0dcc06cc81c5168dc" ###it was: "ami-0863c862a9cefd8ae" # This is AMI in eu-central-1
  instance_type = "t3.2xlarge"            # 32GB RAM minimum
  key_name      = aws_key_pair.avx_key.key_name

  network_interface {
    network_interface_id = aws_network_interface.eni-copilot.id
    device_index         = 0
  }
  tags = {
    Name      = "avx-copilot-eu"
  }

  lifecycle {
    ignore_changes = [
      ami
    ]
  }
}

# create EIP
resource "aws_eip" "copilot_eip" {
  vpc = true
  tags = { Name = "avx-copilot-eu" }
}

# associate EIP
resource "aws_eip_association" "eip_assoc_cplt" {
  instance_id   = aws_instance.aviatrixcopilot.id
  allocation_id = aws_eip.copilot_eip.id
}*/


# Export SSM Parameters
########################################################################

/*resource "aws_ssm_parameter" "aviatrix-role-app-name" {
  name      = "/aviatrix-shared/prod/aviatrix/aviatrix_role_app_name"
  type      = "SecureString"
  overwrite = true
  value     = "arn:aws:iam::${var.aws_controller_account}:role/${module.iam_roles.aviatrix-role-app-name}"
}

resource "aws_ssm_parameter" "aviatrix-role-ec2-name" {
  name      = "/aviatrix-shared/prod/aviatrix/aviatrix_role_ec2_name"
  type      = "SecureString"
  overwrite = true
  value     = "arn:aws:iam::${var.aws_controller_account}:role/${module.iam_roles.aviatrix-role-ec2-name}"
}

resource "aws_ssm_parameter" "aviatrix_ctrl_ip" {
  name      = "/aviatrix-shared/prod/aviatrix/controller_ip"
  type      = "SecureString"
  overwrite = true
  value     = module.aviatrix-controller-build.public_ip
}

resource "aws_ssm_parameter" "aviatrix_copilot_ip" {
  name      = "/aviatrix-shared/prod/aviatrix/copilot_ip"
  type      = "SecureString"
  overwrite = true
  value     = aws_eip.copilot_eip.public_ip
}

resource "aws_ssm_parameter" "aviatrix_vpc_id" {
  name      = "/aviatrix-shared/prod/aviatrix/vpc_id"
  type      = "SecureString"
  overwrite = true
  value     = var.vpc_id
}

resource "aws_ssm_parameter" "aviatrix_subnet_id" {
  name      = "/aviatrix-shared/prod/aviatrix/subnet_id"
  type      = "SecureString"
  overwrite = true
  value     = var.subnet_id
}*/