resource "aws_default_security_group" "practSG"{
    vpc_id = var.vpc_id

    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.my_ip]
    }

    ingress{
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []
    }
     tags = {
        Name: "${var.environment}-SG"
    }
}

/*resource "aws_security_group" "practSG"{
    name = "practSG"
    vpc_id = aws_vpc.practice-vpc.id

    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.my_ip]
    }

    ingress{
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []
    }
     tags = {
        Name: var.environment
    }
}*/

data "aws_ami" "linux-image"{
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "root-device-type"
        values = ["ebs"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
    filter {
        name = "name"
        values = [var.image_name]
    }
  
} 

resource "aws_instance" "my-web"{
    ami = data.aws_ami.linux-image.id
    instance_type = var.instance
    subnet_id = var.subnet_id
    availability_zone = var.az
    associate_public_ip_address = true
    key_name = aws_key_pair.ssh-key.key_name
   vpc_security_group_ids = [aws_default_security_group.practSG.id]

   /*user_data = <<EOF
                    #!/bin/bash
                    sudo yum update -y && sudo yum install -y docker
                    sudo systemctl start docker
                    sudo usermod -aG docker ec2-user
                    docker run -p 8080:80 nginx
                EOF
                alternative to using separate script*/

    user_data = file("script.sh")

    /*connection {
        type = "ssh"
        host = self.public_ip
        user = ec2-user
        private_key = file(var.private_key)
    }

    provisioner "file" {
        source = "script.sh"
        destination = "/home/ec2-user/script-on-start.sh"
    }

    provisioner "remote-exec" {
        script = file("script-on-start.sh")
        ]
    }
    use as last resort to run user data script*/


    tags = {
        Name = "${var.environment}-ec2"
    }
}

resource "aws_key_pair" "ssh-key" {
    key_name = "keys"
    public_key = file(var.public_key)
}
