output "ec2_public_ip" {
    value = module.my-web.instance.public_ip

}