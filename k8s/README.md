# DevOps Technical Challenge — Python Application

This repository contains the implementation of the DevOps technical challenge, including containerization, CI/CD pipeline, Kubernetes deployment, and Infrastructure as Code using Terraform. The solution was designed following industry best practices and includes full automation and documentation.

## Overview

The application is a Python (Django) service that exposes a simple API for creating and retrieving users. This repository extends the base application with:

- Docker containerization
- Automated testing and coverage
- CI/CD pipeline using GitHub Actions
- Deployment to a Kubernetes cluster
- Infrastructure provisioning using Terraform (DigitalOcean Kubernetes)
- ConfigMaps, Secrets, Ingress, Service, and Deployment resources
- Load balancer exposure for public access

---

## 1. Dockerization

The project includes an optimized Dockerfile with:

- Python 3.11-slim as the base image
- Non-root execution
- Requirements installation
- Environment variable support
- Port 8000 exposed
- Healthcheck support
- Gunicorn/Django readiness for production environments

**Location:** `Dockerfile`

### Build and Run Locally
```bash
docker build -t devsu-app .
docker run -p 8000:8000 devsu-app
```

---

## 2. CI/CD Pipeline (GitHub Actions)

A complete CI/CD workflow is included that performs:

- Code checkout
- Python dependency installation
- Unit tests
- Test coverage generation
- Docker image build
- Docker image push to Docker Hub
- Automated Kubernetes deployment inside a KinD cluster (running inside the CI runner)

**Location:** `.github/workflows/ci.yml`

**To view pipeline results:** Navigate to the **Actions** tab in the GitHub repository.

---

## 3. Kubernetes Deployment

The application is deployed using the following Kubernetes objects:

- Namespace
- ConfigMap
- Secret
- Deployment (with two replicas)
- Service (LoadBalancer)
- Ingress
- Liveness and Readiness probes

Kubernetes manifests are located in the `k8s/` directory.

### Deploy Manually
```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/secret.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
```

### Verify Deployment
```bash
kubectl get pods -n devsu-app
kubectl get svc -n devsu-app
kubectl get ingress -n devsu-app
```

If running on a cloud provider, the LoadBalancer service will return an external IP to access the application publicly.

**Example endpoint:** `http://<public-ip>/api/users/`

---

## 4. Infrastructure as Code (Terraform)

The repository includes Terraform scripts to provision a Kubernetes cluster on DigitalOcean.

### Included Resources

- Kubernetes Cluster
- Worker Node Pool
- Kubeconfig output

Terraform files are located under `terraform/`:
```
terraform/
├── main.tf
├── provider.tf
├── variables.tf
└── outputs.tf
```

### Usage

**Create a `terraform.tfvars` file** (not included in the repository):
```hcl
do_token     = "YOUR_DIGITALOCEAN_TOKEN"
cluster_name = "devsu-cluster"
region       = "nyc1"
node_size    = "s-1vcpu-2gb"
```

**Initialize Terraform:**
```bash
terraform init
```

**Preview changes:**
```bash
terraform plan
```

**Provision infrastructure:**
```bash
terraform apply
```

**Save kubeconfig:**
```bash
terraform output -raw kubeconfig > devsu-cluster-kubeconfig.yaml
export KUBECONFIG=devsu-cluster-kubeconfig.yaml
```

---

## 5. Application Usage

### Run Locally Without Docker
```bash
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver
```

### Run Tests
```bash
python manage.py test
```

### Code Coverage
```bash
coverage run manage.py test
coverage xml
```

---

## 6. System Architecture

The system includes:

- CI/CD pipeline (GitHub Actions)
- Dockerized Django application
- Artifact push to Docker Hub
- Kubernetes cluster (DigitalOcean)
- Automated deployment
- Public service exposure via LoadBalancer

A diagram can be provided on request.

---

## 7. Required Deliverables (Checklist)

| Requirement | Status |
|------------|--------|
| Public GitHub repository | ✅ Completed |
| Dockerized application | ✅ Completed |
| Unit tests | ✅ Completed |
| Code coverage | ✅ Completed |
| Static code analysis | ⚠️ Optional (can be added) |
| CI Pipeline | ✅ Completed |
| Docker build & push | ✅ Completed |
| Kubernetes deployment | ✅ Completed |
| At least 2 replicas | ✅ Completed |
| ConfigMaps and Secrets | ✅ Completed |
| Ingress | ✅ Completed |
| Public endpoint (LoadBalancer) | ✅ Completed |
| Terraform IaC | ✅ Completed |
| terraform apply output | ✅ Available |
| README documentation | ✅ Completed |
| Screenshots | ⏳ Pending (candidate must attach them) |

---

## 8. Screenshots Required for Submission

Include the following in the ZIP file or repository documentation:

- [ ] GitHub Actions pipeline run (all steps green)
- [ ] Docker Hub repository showing the pushed image
- [ ] Terraform apply output (cluster created)
- [ ] `kubectl get nodes` showing cloud worker nodes
- [ ] `kubectl get pods -n devsu-app` showing running replicas
- [ ] `kubectl get svc -n devsu-app` showing LoadBalancer external IP
- [ ] Public URL returning `/api/users/`

---

## 9. Notes and Considerations

- Secrets are never pushed to the repository
- Terraform state is excluded via `.gitignore`
- CI pipeline includes KinD to simulate deployment
- The project follows production-level DevOps practices

---

## License

This project is part of a technical challenge and is provided as-is for evaluation purposes.

## Contact

For questions or clarifications, please open an issue in this repository.