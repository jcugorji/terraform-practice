variable "cidr_block" {
  type        = list(string)
  description = "vpc cidr block"
}
variable "environment"{
    description = "vpc environment"
}
variable az {
  type        = string
  description = "description"
}

variable public_key {
    type = string
}

variable my_ip{
   type = string 
}

variable instance{
   type = string 
}
variable vpc_id {}
variable image_name {}
variable subnet_id {}
