variable "domain_urls" {
  default = []
  type    = list(string)
}

variable "client_name" {
  default = ""
  type    = string
}

variable "mx_records" {
  default = []
  type    = list(string)
}

variable "txt_records" {
  default = []
  type    = list(string)
}
