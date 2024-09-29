variable "domain_name" {
  type = string
}

variable "private_zone" {
  type = bool
  default = false
}

variable "wildcard" {
  type = bool
  default = false
}
