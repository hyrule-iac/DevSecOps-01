terraform {
  required_version = "~> 1.14.0"
  required_providers {
    k3d = {
      source  = "pvreese/k3d"
      version = "~> 0.0.6"
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

provider "k3d" {}
provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}