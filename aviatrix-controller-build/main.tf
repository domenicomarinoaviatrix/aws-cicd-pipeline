/*resource "aws_eip" "controller_eip" {
  count = var.num_controllers
  vpc   = true
  tags  = local.common_tags
}*/

data "aws_eip" "controller_eip" {
  public_ip = "18.203.91.19"
}

resource "aws_eip_association" "eip_assoc" {
  count         = var.num_controllers
  instance_id   = aws_instance.aviatrixcontroller[count.index].id
  allocation_id = data.aws_eip.controller_eip.id
}

resource "aws_network_interface" "eni-controller" {
  count           = var.num_controllers
  subnet_id       = var.subnet
  security_groups = [aws_security_group.AviatrixSecurityGroup.id]
  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}Aviatrix Controller interface : ${count.index}"
  })
  lifecycle {
    ignore_changes = [tags, security_groups, subnet_id]
  }
}

resource "aws_instance" "aviatrixcontroller" {
  count                   = var.num_controllers
  ami                     = local.ami_id
  instance_type           = var.instance_type
  key_name                = var.keypair
  iam_instance_profile    = var.ec2role
  disable_api_termination = var.termination_protection

  network_interface {
    network_interface_id = aws_network_interface.eni-controller[count.index].id
    device_index         = 0
  }

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
    encrypted   = var.root_volume_encrypted
    kms_key_id  = var.root_volume_kms_key_id
    delete_on_termination = true
  }

  tags = merge(local.common_tags, {
    Name = var.controller_name != "" ? count.index == 0 ? var.controller_name : "${var.controller_name}-${count.index}" : "${local.name_prefix}AviatrixController-${count.index}"
  })

  lifecycle {
    ignore_changes = [
      ami, key_name, user_data, network_interface
    ]
  }
}