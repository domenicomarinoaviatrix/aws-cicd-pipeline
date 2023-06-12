# Security Group: Copilot


resource "aws_security_group" "AviatrixSecurityGroupCPLT" {
  name        = "AviatrixSecurityGroupCPLT"
  description = "Aviatrix - Copilot Security Group"
  vpc_id      = var.vpc_id

}

resource "aws_security_group_rule" "ingress_rule_ssl" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.incoming_ssl_cidr_copilot
  security_group_id = aws_security_group.AviatrixSecurityGroupCPLT.id
}


resource "aws_security_group_rule" "ingress_rule_syslog" {
  type              = "ingress"
  from_port         = 5000
  to_port           = 5000
  protocol          = "udp"
  cidr_blocks       = var.incoming_ssl_cidr_copilot
  security_group_id = aws_security_group.AviatrixSecurityGroupCPLT.id
}


resource "aws_security_group_rule" "ingress_rule_netflow" {
  type              = "ingress"
  from_port         = 31283
  to_port           = 31283
  protocol          = "udp"
  cidr_blocks       = var.incoming_ssl_cidr_copilot
  security_group_id = aws_security_group.AviatrixSecurityGroupCPLT.id
}

resource "aws_security_group_rule" "egress_rule_cplt" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.AviatrixSecurityGroupCPLT.id
}
