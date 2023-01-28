provider "aws" {
    region = "us-east-1"
}

variable "cidr_block" {
  type        = list(string)
  description = "vpc cidr block"
}
variable "environment"{
    description = "vpc environment"
}
resource "aws_vpc" "practice-vpc"{
    cidr_block = var.cidr_block[0]
    tags = {
        Name: var.environment
    }
}

resource "aws_subnet" "pra-subnet"{
    vpc_id = aws_vpc.practice-vpc.id
    cidr_block = var.cidr_block[1]
    availability_zone = "us-east-1c"
}
output vpc_id {
  value       = "aws_vpc.practice-vpc.id"
  description = "vpc id"
}
