variable "vpc_id" {
  description = "El ID de la VPC"
  type        = string
}

variable "internet_gateway_id" {
  description = "El ID del Internet Gateway"
  type        = string
}

variable "public_subnet_id" {
  description = "El ID de la Subnet Pública"
  type        = string
}

variable "name" {
  description = "Nombre de la Tabla de Rutas"
  type        = string
}
