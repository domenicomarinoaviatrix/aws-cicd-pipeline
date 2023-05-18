variable "aws_region" {
  description = "AWS Region where to spin up the Controller"
  type        = string
  default     = "eu-west-1"
}

variable "vpc_controller" {
  description = "VPC where to spin up the Controller in"
  type        = string
  default     = "vpc-0a0d30848ef411cb7"
}

variable "subnet_controller" {
  description = "Subnet where to spin up the Controller in"
  type        = string
  default     = "subnet-0698a0316aa277f74"
}

variable "keypair_name_controller" {
  description = "Keypair for the Controller"
  type        = string
  default     = "Niko_Controller"
}

variable "ec2role_controller" {
  description = "IAM Role for the Controller"
  type        = string
  default     = "aviatrix-role-ec2" #added BYOL-
}

variable "controller_password" {
  description = "Controller password"
  type        = string
}
variable "account_name" {
  description = "Account Name"
  type        = string
}

variable "customer_license_id" {
  type        = string
  description = "Customer license ID"
  default     = "avx-dev-1613002716.89"
}

variable "controller_version" {
  type        = string
  default     = "6.9"  # "latest"
  description = "The version in which you want launch Aviatrix controller"
}

variable "type" {
  default     = "byol"
  type        = string
  description = "Type of billing, can be 'Metered', 'MeteredPlatinum', 'MeteredPlatinumCopilot', 'VPNMetered', BYOL' or 'Custom'."

  validation {
    condition     = contains(["metered", "meteredplatinum", "meteredplatinumcopilot", "vpnmetered", "byol", "custom"], lower(var.type))
    error_message = "Invalid billing type. Choose 'Metered', 'MeteredPlatinum', 'MeteredPlatinumCopilot', 'VPNMetered', BYOL' or 'Custom'."
  }
}