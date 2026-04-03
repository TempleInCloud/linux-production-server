# Linux Production Server with k3s Deployment

## 🚀 Project Overview

This project demonstrates how to provision and configure a production-ready Linux server, automate system setup, and deploy containerized applications using k3s (lightweight Kubernetes).

It showcases core platform engineering practices including system hardening, automation, container orchestration, and service exposure.

---

## 🔧 What This Project Covers

- Linux server setup and configuration
- User and permission management
- System hardening (basic security practices)
- Bash scripting for automation
- Docker installation and container runtime setup
- k3s (lightweight Kubernetes) installation
- Kubernetes resource deployment
- Service exposure using NodePort
- Git version control and GitHub integration

---

## 🏗️ Architecture

The application flow follows a simple Kubernetes service exposure model:

- **Client** sends request to server IP and NodePort  
- **NodePort** exposes the service externally  
- **Service** routes traffic inside the cluster  
- **Pod** runs the Nginx container serving content

## 📁 Project Structure

```
linux-production-server/
├── docs/
│   ├── security-setup.log
│   └── users-setup.log
│
├── scripts/
│   ├── base.sh                  # Base system setup
│   ├── docker.sh                # Docker installation
│   ├── k3s.sh                   # Kubernetes (k3s) setup
│   ├── users.sh                 # User creation & permissions
│   ├── security.sh              # Server hardening
│   ├── nginx-nodeport.yaml      # Kubernetes NodePort service
│   ├── nginx-route.yaml         # Gateway API route (experimental)
│   └── web-gateway.yaml         # Gateway configuration
```
---

## ⚙️ Setup Steps

### 1. Server Preparation
- Provision Ubuntu server
- Update system packages

### 2. User & Security Setup
- Create a non-root user
- Configure permissions
- Apply basic hardening

### 3. Install Docker
Run the Docker setup script:
bash scripts/docker.sh

### 4. Install k3s
Run the Kubernetes setup script:
bash scripts/k3s.sh

### 5. Deploy Application (Nginx)
Create the deployment:
```
sudo k3s kubectl create deployment nginx --image=nginx
```

Expose using NodePort:
```
sudo k3s kubectl expose deployment nginx --type=NodePort --port=80
```

### 6. Verify Deployment
Check pods:
```
sudo k3s kubectl get pods
```

Check services:
```
sudo k3s kubectl get svc
```

### 7. Access Application
```
curl http://192.168.64.2:30007
```

## 📸 Screenshots

### 🚀 Nginx Deployment Running
![Nginx Deployment](https://github.com/TempleInCloud/linux-production-server/blob/a10b3a46d96cef34f5a0a2076e28bbebbb8c40bd/docs/application%20access.png)

### 📦 Kubernetes Resources
![Pods and Services](https://github.com/TempleInCloud/linux-production-server/blob/da811cd41990592ada2e5bae8733f58cc074cfdd/docs/kubernetes%20resources%201.png)

### 🔧 Project Structure
![Project Structure](https://github.com/TempleInCloud/linux-production-server/blob/a87d493abf1a7855e29f6063628879d1fb38ea5c/docs/Project%20Structure.png)

---

## 👤 Author

**Temple Osaroejiji**

Platform Engineer | Cloud & DevOps Engineer 

- 🔗 GitHub: https://github.com/TempleInCloud  
- 🔗 LinkedIn: https://www.linkedin.com/in/temple-osaroejiji 

---

💡 *This project demonstrates my ability to provision, secure, and run production-ready infrastructure using Linux, Docker, and Kubernetes (k3s).*
