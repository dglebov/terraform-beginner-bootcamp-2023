variable "terratowns_endpoint" {
 type = string
}

variable "terratowns_token" {
 type = string
}

variable "user_uuid" {
 type = string
}

variable "fallout" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "borch" {
  type = object({
    public_path = string
    content_version = number
  })
}