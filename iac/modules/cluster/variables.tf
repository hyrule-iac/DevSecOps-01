variable "cluster_name" {
  description = "Nombre del cluster de k3d"
  type        = string
}

variable "nodes" {
  description = "Cantidad de nodos worker"
  type        = number
}