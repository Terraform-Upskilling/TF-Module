output "vpc-id" {
  value =aws_vpc.data
  description = "This block is for vpc id"
}

output "public-subnet_id" {
  value = aws_subnet.pub-net[0].id
  description = "This block is for public subnet id"
}

output "public-subnet_id2" {
  value = aws_subnet.pub-net[1].id
  description = "This block is for public subnet id"
}

output "private-subnet_id" {
  value = aws_subnet.private-net[0].id
  description = "This block is for private subnet id"
}

output "private-subnet_id2" {
  value = aws_subnet.private-net[1].id
  description = "This block is for private subnet id"
}

output "igw-id" {
  value = aws_internet_gateway.igw
  description = "This block is for igw id"
}


output "instance-id" {
  value = aws_instance.data-instance
  description = "This block is for instance id"
}

output "elastic-id" {
  value = aws_eip.elastic-ip
  description = "This block is for elastic id"
}

output "sg-id" {
  value =aws_security_group.sg
  description = "This block is for sg id"
}