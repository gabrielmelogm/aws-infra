variable "vpc_cidr_block" {
  description = "Bloco CIDR da VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "Bloco CIDR da sub-rede pública"
  default     = "10.0.1.0/24"
}

variable "ami_id" {
  description = "ID da AMI (Amazon Machine Image) para a instância EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instância EC2"
  default     = "t3.small"
}

variable "key_name" {
  description = "Nome da chave SSH para acessar a instância"
  type        = string
}

variable "public_key" {
  description = "Chave pública SSH para acesso à instância"
  type        = string
}

variable "availability_zone" {
  description = "Zona de disponibilidade para a sub-rede"
  default     = "us-east-1a"
}

variable "domain" {
  description = "Domain"
  default     = "gabrielmelo.shop"
}

variable "sub_domain" {
  description = "Sub Domain"
  default     = "www.gabrielmelo.shop"
}
