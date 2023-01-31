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
variable vpc_id {}
variable default_route_table_id {}