provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "practice-vpc"{
    cidr_block = var.cidr_block[0]
    tags = {
        Name: "${var.environment}-vpc"
    }
}
module "my-subnet" {
    source = "./modules/sub"
    cidr_block = var.cidr_block
    environment = var.environment
    az = var.az
    vpc_id = aws_vpc.practice-vpc.id
    default_route_table_id = aws_vpc.practice-vpc.default_route_table_id
}

module "my-web" {
    source = "./modules/web"
    cidr_block = var.cidr_block
    environment = var.environment
    az = var.az
    public_key = var.public_key
    my_ip = var.my_ip
    instance = var.instance
    vpc_id = aws_vpc.practice-vpc.id
    image_name = var.image_name
    subnet_id = module.my-subnet.subnet.id
}