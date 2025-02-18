######################################
# VPC
######################################

variable "cidr" {
  description = "pass the cidr value of vpc"
  type        = string
}

variable "vpc_tags" {
  description = "The standard name of vpc"
  type = object({
    Name        = string
    Environment = string
  })
}

variable "zone" {
  description = "Availability zone which are used"
  type        = list(string)
}

# Public subnet
variable "pub_subnet_cidr" {
  description = "pass the cidr value of subnet"
  type        = list(string)
}

variable "subnet_tag_pub" {
  type = object({
    Name        = string
    Environment = string
  })
}

variable "environment" {
  default = "dev"
}

# private subnet

variable "private_subnet_cidr" {
  description = "pass the cidr value of subnet"
  type        = list(string)
}

variable "subnet_tag_private" {
  type = object({
    Name        = string
    Environment = string
  })
}

# Internet Gateway
variable "internet_ip" {
  description = "Allow connection to the internet"
  type        = string
}

# instance

variable "instance_type" {
  type = string
}

variable "instance_tag" {
  description = "A standard name of instance"
  type = object({
    Name        = string
    Environment = string
  })
}



