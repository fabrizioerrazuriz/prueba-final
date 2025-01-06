variable "ami_id" {
  description = "ID de la AMI para la instancia"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
}

variable "iam_instance_profile" {
  description = "Nombre del IAM Instance Profile"
  type        = string
}

variable "subnet_id" {
  description = "ID de la subnet donde se lanzará la instancia"
  type        = string
}

variable "security_group_id" {
  description = "ID del Security Group asociado"
  type        = string
}

variable "name" {
  description = "Nombre de la instancia EC2"
  type        = string
}

variable "key_name" {
  description = "Nombre de la clave para acceder a la instancia"
  type        = string
}