##  Azure Kubernetes Service (AKS) Deployment – Wisecow Project

This project demonstrates the deployment of a containerised application on Azure Kubernetes Service (AKS) using the following technologies:

- Azure CLI
- Kubernetes (kubectl)
- Helm (Ingress Controller)

###  Steps Performed

1. **Create AKS Cluster**
   bash
   az aks create -g haja-project -n wisecowAKSCluster \
     --enable-managed-identity \
     --node-count 1 \
     --node-vm-size Standard_DC2ads_v5 \
     --enable-addons monitoring \
     --enable-msi-auth-for-monitoring


2. **Connect to AKS Cluster**

   bash
   az aks get-credentials --resource-group haja-project --name wisecowAKSCluster
   

3. **Install Ingress Controller via Helm**

   bash
   helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
   helm repo update
   helm install nginx-ingress ingress-nginx/ingress-nginx \
     --set controller.replicaCount=2 \
     --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux \
     --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux
   

4. **Deploy Application**

   bash
   kubectl apply -f deployment.yaml
   kubectl apply -f service.yaml
   kubectl apply -f ingress.yaml
   

5. **Attach ACR to AKS Cluster**

   bash
   az aks update -n wisecowAKSCluster -g haja-project --attach-acr acrwisecow
   

###  Deployment Files

* `deployment.yaml` – Kubernetes deployment spec
* `service.yaml` – Service exposure spec
* `ingress.yaml` – Ingress routing definition



###  Monitoring

Azure Monitor is enabled using `--enable-addons monitoring`.
