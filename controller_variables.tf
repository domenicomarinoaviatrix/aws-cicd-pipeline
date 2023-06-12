
variable "aws_controller_account" {
  type        = string
  description = "The AWS Aviatrix Controller Account"
  default     = ""
}

variable "region" {
  type        = string
  description = "The name of the AWS EU Region"
  default     = ""
}

variable "incoming_ssl_cidr_copilot" {
  type        = list(string)
  description = "allowed IP ranges"
  default     = []
}


variable "incoming_ssl_cidr_controller" {
  type        = list(string)
  description = "allowed IP ranges"
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for Controller and CoPilot"
  default     = ""
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for Controller and CoPilot"
  default     = ""
}

variable "secondary_account_ids" {
  type        = list(string)
  description = "assumable accounts"
  default     = []
}

variable "add_controller_security_group_ids" {
  type        = list(string)
  description = "additional security groups"
  default     = []
}

variable "add_copilot_security_group_ids" {
  type        = list(string)
  description = "additional security groups"
  default     = []
}