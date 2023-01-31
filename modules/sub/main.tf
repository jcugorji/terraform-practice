resource "aws_subnet" "pra-subnet"{
    vpc_id = var.vpc_id
    cidr_block = var.cidr_block[1]
    availability_zone = var.az

    tags = {
        Name: "${var.environment}-subnet"
    }
}

/*resource "aws_route_table" "practice_RT"{
    vpc_id = aws_vpc.practice-vpc.id

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.practice_IGW.id
    }
    tags = {
        Name: var.environment
    }
}*/

resource "aws_internet_gateway" "practice_IGW"{
    vpc_id = var.vpc_id

    tags = {
        Name: "${var.environment}-IGW"
    }
}

/*resource "aws_route_table_association" "RT-assoc"{
    subnet_id = aws_subnet.pra-subnet.id
    route_table_id = aws_route_table.practice_RT.id
}*/

resource "aws_default_route_table" "main-rt"{
    default_route_table_id = var.default_route_table_id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.practice_IGW.id
    }
    tags = {
        Name: "${var.environment}-RT"
    }
}