locals {
  vpc_name      = "cmtr-6pajwelx-vpc"
  instance_name = "cmtr-6pajwelx-ec2"
  sg_name       = "cmtr-6pajwelx-sg"
  subnet_name   = "cmtr-6pajwelx-public_subnet"


}
data "aws_vpc" "this_vpc" {
  filter {
    name   = "tag:Name"
    values = [local.vpc_name]

  }
}

data "aws_subnet" "public_a" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this_vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = [local.subnet_name]
  }
  filter {
    name   = "cidr-block"
    values = ["10.0.1.0/24"]
  }
}


data "aws_security_group" "this_sg" {
  filter {
    name   = "tag:Name"
    values = [local.sg_name]
  }
}



resource "aws_instance" "this_instance" {
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = "t3.micro"

  key_name = aws_key_pair.this_key_pair.key_name

  subnet_id                   = data.aws_subnet.public_a.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [data.aws_security_group.this_sg.id]


  tags = {
    name = "${local.instance_name}"
  }
}

