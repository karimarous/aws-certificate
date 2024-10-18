variable "domain_name" {
  type = string
}

variable "private" {
  type = bool
  default = false
}

variable "wildcard" {
  type = bool
  default = false
}
