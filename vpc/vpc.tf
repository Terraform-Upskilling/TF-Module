#############################################
#vpc
#############################################

resource "aws_vpc" "data" {
  cidr_block = var.cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"
  tags = var.vpc_tags
}

#############################################
# Public Subnet
#############################################

resource "aws_subnet" "pub-net" {
  count = length(var.pub_subnet_cidr)
  vpc_id = aws_vpc.data.id
  cidr_block = element(var.pub_subnet_cidr,count.index )
  availability_zone = element(var.zone,count.index )
  map_public_ip_on_launch = true
  tags = {
    Name        ="Public_subnet-${count.index}"
    Environment = var.environment
  }
}

#############################################
# Pravite Subnet
#############################################

resource "aws_subnet" "private-net" {
  count = length(var.private_subnet_cidr)
  vpc_id = aws_vpc.data.id
  cidr_block = element(var.private_subnet_cidr,count.index )
  availability_zone = element(var.zone,count.index)
  map_public_ip_on_launch = false
  tags = {
    Name="Private_subnet-${count.index}"
    Environment= var.environment
  }
}

#############################################
#internet gateway
#############################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.data.id
  tags = {
    Name="IGW"

  }
}

#############################################
#public RT
#############################################

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.data.id
  route {
    cidr_block = var.internet_ip
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name= "Public-RT"
  }
}

#############################################
#Publit RT Association
#############################################

resource "aws_route_table_association" "pub-ass1" {
  count = length(var.pub_subnet_cidr)
  route_table_id = aws_route_table.public_rt.id
  subnet_id =aws_subnet.pub-net[count.index].id
}

#############################################
#Private RT
#############################################

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.data.id
  tags = {
    Name="Private-RT"
  }

}

#############################################
#Private RT Asscociation
#############################################

resource "aws_route_table_association" "pri-ass1" {
  count =length(var.private_subnet_cidr)
  route_table_id = aws_route_table.private-rt.id
  subnet_id = aws_subnet.private-net[count.index].id
}

#############################################
# instance
#############################################

data "aws_ami" "task2-ami" {
   owners = ["amazon"]
    most_recent = true
   filter {
     name = "name"
     values = ["al2023*x86_64"]
   }
   filter {
     name = "virtualization-type"
     values = ["hvm"]
   }
   filter {
     name = "root-device-type"
     values = ["ebs"]
   }
}

resource "aws_instance" "data-instance" {
  ami = data.aws_ami.task2-ami.id
  instance_type = var.instance_type
  tags = var.instance_tag
  vpc_security_group_ids = [aws_security_group.sg.id]
}

#############################################
# Security Group
#############################################

resource "aws_security_group" "sg" {
  name = "sg"
  description = "Web security group for HTTP"
  ingress {
    from_port =80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#############################################
#Elastic ip
#############################################

resource "aws_eip" "elastic-ip" {
instance = aws_instance.data-instance.id
}