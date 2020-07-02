variable "cidr_block" {
  default = ""
  type    = string
}

variable "public_subnet_cidr_blocks" {
  default = []
  type    = list(string)
}

variable "client_name" {
  default = ""
  type    = string
}
