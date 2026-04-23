Trend Application - End-to-End DevSecOps Pipeline
This repository contains a full-stack web application deployed on AWS EKS using a robust CI/CD pipeline. The project demonstrates the integration of Terraform for IaC, Docker for containerization, Jenkins for automation, and Kubernetes for orchestration.

🚀 Project Overview
Application: Trend Web App (Node.js/React based)

Infrastructure: AWS (VPC, EC2, IAM)

CI/CD: Jenkins (Declarative Pipeline)

Orchestration: Kubernetes (EKS)

🛠 Tech Stack

Tool	Purpose
Terraform	Infrastructure as Code (Provisioning VPC, EC2)
Docker	Containerization of the application
Jenkins	Automation server for CI/CD
AWS EKS	Managed Kubernetes Service

🏗 Infrastructure Setup (Terraform)

The infrastructure is provisioned using Terraform scripts located in the /terraform directory.

Initialize Terraform: terraform init

Plan the deployment: terraform plan

Apply changes: terraform apply --auto-approve
This creates the VPC, IAM Roles for EKS, a Jenkins Server (EC2).

CI/CD Pipeline Flow
The Jenkins pipeline is defined in the Jenkinsfile and follows these stages:

Git Checkout: Clones the code from GitHub.

Build: Builds the Docker image from the Dockerfile.

Push: Tags and pushes the image to DockerHub.

K8s Deploy: Updates the Kubernetes manifest and deploys to EKS using kubectl.

Webhook Integration
Go to GitHub Repository Settings > Webhooks.

Add the Jenkins URL: http://35.154.99.23/:8080/github-webhook/.

Trigger: Just the push event.


📦 Deployment Instructions
Dockerizing Locally
To run the app in a container:

docker build -t dugyalaravali28/trend-app:latest .
docker run -d -p 3000:3000 dugyalaravali28/trend-app:latest

Kubernetes Deployment
Apply the manifests:

kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

📊 Monitoring
We have implemented Prometheus and Grafana to monitor cluster health.

Prometheus: Scrapes metrics from EKS nodes and pods.

Grafana: Visualizes CPU, Memory usage, and Network traffic.

🔗 Project Deliverables
Application URL: http:// a610e1bda9d3449028a281141a72955a-928990213.ap-south-1.elb.amazonaws.com :3000

DockerHub Repo: https://hub.docker.com/repository/docker/dugyalaravali28/trend-app

monitoring URL :http://a848e2cc8ad624b6cb9323398c5ff2ae-1980784692.ap-south-2.elb.amazonaws.com

Jenkins Pipeline Screenshots: (Check /screenshots folder)
