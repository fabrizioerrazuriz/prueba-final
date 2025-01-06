variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "Rango CIDR para la subnet pública"
  type        = string
}

variable "public_subnet_name" {
  description = "Nombre de la subnet pública"
  type        = string
}

variable "private_subnet_cidr_block" {
  description = "Rango CIDR para la subnet privada"
  type        = string
}

variable "private_subnet_name" {
  description = "Nombre de la subnet privada"
  type        = string
}