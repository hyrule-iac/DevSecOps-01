# Módulo para el Cluster local con K3d
module "cluster" {
  source       = "./modules/cluster"
  cluster_name = var.lab_name
  nodes        = var.worker_nodes
}

# Módulo para el despliegue progresivo con Argo Rollouts
module "delivery" {
  source     = "./modules/delivery"
  depends_on = [module.cluster] # No instalamos Argo si no hay cluster
}

# Módulo para el Stack de Observabilidad
module "monitoring" {
  source     = "./modules/monitoring"
  namespace  = "monitoring"
  depends_on = [module.cluster]
}