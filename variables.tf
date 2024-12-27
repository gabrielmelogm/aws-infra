variable "region" {
  description = "Região da AWS onde os recursos serão criados"
  default     = "us-east-1"
}

variable "key_name" {
  description = "Nome da chave SSH para acessar a instância"
  type        = string
}

variable "public_key" {
  description = "Chave pública SSH para acesso à instância"
  type        = string
  sensitive   = true
}

variable "availability_zone" {
  description = "Zona de disponibilidade para a sub-rede"
  default     = "us-east-1a"
}
