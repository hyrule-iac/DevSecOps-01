---

# Demo DevSecOps Lab

A professional-grade DevSecOps ecosystem designed for high-availability deployments, progressive delivery, and observability. This project serves as a technical showcase for implementing modern cloud-native patterns using **.NET 10**, **Argo Rollouts**, and **Prometheus**.

## 🏗️ Architecture Overview

The laboratory implements a **Canary Deployment** strategy where traffic is incrementally shifted to new versions while being monitored by an automated analysis engine.



### Key Components
* **Application:** .NET 10 Web API with custom Prometheus instrumentation for business and error metrics.
* **Infrastructure:** Local Kubernetes cluster managed via **k3d** and **Terraform**.
* **Observability:** Full Prometheus & Grafana stack for real-time metric collection and visualization.
* **Progressive Delivery:** **Argo Rollouts** utilizing `AnalysisTemplates` to execute automated rollbacks based on live telemetry.

## 📂 Project Structure

```text
/demo-devsecops-lab
├── src/
│   └── DevSecOpsApi/          # .NET 10 Source Code & Instrumentation
├── iac/                       # Infrastructure as Code (Terraform)
│   ├── k3d.tf                 # Local Cluster definition
│   └── monitoring.tf          # Prometheus/Grafana Helm charts
├── k8s/                       # GitOps & Kubernetes Manifests
│   └── rollouts/              # Canary, Analysis & Service definitions
├── .github/                   # CI/CD Workflows (GitHub Actions)
└── Dockerfile                 # Multi-stage secure container build
```

## 🚀 Getting Started

### Prerequisites
* .NET 10 SDK
* Docker & k3d
* Terraform
* kubectl & argo-rollouts plugin

### 1. Local Development
To run the application locally and verify the Prometheus instrumentation:
```bash
cd src/DevSecOpsApi
dotnet build
dotnet run
```
Access `http://localhost:5000/metrics` to verify the telemetry stream.

### 2. Infrastructure Provisioning
Initialize the local environment and the observability stack:
```bash
cd iac
terraform init
terraform apply
```

### 3. Progressive Deployment
Deploy the application using the Canary strategy:
```bash
kubectl apply -f k8s/rollouts/
```
To visualize the deployment progress in real-time:
```bash
kubectl argo rollouts get rollout demo-devsecops-api -w
```


## 🛡️ DevSecOps Patterns

### Automated Canary Analysis
The system employs an `AnalysisTemplate` that executes PromQL queries every 30 seconds. If the error rate exceeds a **5% threshold** during the canary phase, Argo Rollouts will autonomously abort the promotion and restore the last known stable version.

### Interactive Chaos Engineering
The demo UI includes a **"Simulate Error"** trigger. This allows engineers to manually inject synthetic failures during a deployment window to demonstrate the platform's self-healing and automated decision-making capabilities.

## Author
**Aldo Raul Sanchez Estrada**
*Senior Cloud Engineer*
---