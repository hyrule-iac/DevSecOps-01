terraform {
  required_version = "~> 1.14.0"

  required_providers {
    k3d = {
      source  = "sneakybugs/k3d"
      version = ">= 1.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25.0"
    }
  }
}

############################################
# Kubernetes provider ☸️ (usa module.cluster)
############################################

provider "kubernetes" {
  host                   = module.cluster.host
  client_certificate     = base64decode(module.cluster.client_certificate)
  client_key             = base64decode(module.cluster.client_key)
  cluster_ca_certificate = base64decode(module.cluster.cluster_ca_certificate)
}

############################################
# Helm provider ⛵ (mismo cluster)
############################################

provider "helm" {
  kubernetes {
    host                   = module.cluster.host
    client_certificate     = base64decode(module.cluster.client_certificate)
    client_key             = base64decode(module.cluster.client_key)
    cluster_ca_certificate = base64decode(module.cluster.cluster_ca_certificate)
  }
}