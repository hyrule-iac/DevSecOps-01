variable "lab_name" {
  description = "Nombre del proyecto DevSecOps"
  type        = string
  default     = "Argo-cluster"
}

variable "worker_nodes" {
  description = "Número de nodos worker para el cluster k3d"
  type        = number
  default     = 2
}

variable "app_port" {
  description = "Puerto externo para acceder a la API de .NET"
  type        = number
  default     = 8080
}

variable "grafana_port" {
  description = "Puerto para visualizar los dashboards de monitoreo"
  type        = number
  default     = 3000
}