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

variable private_key {}

variable my_ip{
   type = string 
}

variable instance{
   type = string 
}
variable image_name {}