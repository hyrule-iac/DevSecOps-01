variable "namespace" {
  description = "Namespace donde se instalará el stack de monitoreo"
  type        = string
  default     = "monitoring"
}

variable "enable_grafana" {
  description = "Flag para habilitar o deshabilitar Grafana"
  type        = bool
  default     = true
}