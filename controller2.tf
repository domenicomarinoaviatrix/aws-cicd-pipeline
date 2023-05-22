module "aviatrix-controller-build2" {
  source            = "git::https://github.com/domenicomarinoaviatrix/aws-cicd-pipeline.git//aviatrix-controller-build"
  vpc               = "vpc-0a0d30848ef411cb7"
  subnet            = "subnet-0698a0316aa277f74"
  keypair           = "Niko_Controller"
  type              = "byol"
  controller_name   = "NewController"
  ec2role           = module.aviatrix-iam-roles.aviatrix-role-ec2-name
  incoming_ssl_cidr = ["10.20.30.0/24","0.0.0.0/0"] 
}