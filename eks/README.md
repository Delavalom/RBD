# Configuración de Kubernetes para AWS EKS

Sigue estos pasos para configurar Kubernetes en tu entorno de producción en AWS EKS.

## GitHub Workflow

Para configurar Kubernetes con AWS EKS, debes agregar las siguientes líneas de código a tu archivo de flujo de trabajo (GitHub Workflow) `cd.yml`. Asegúrate de seguir estos pasos:

### Antes de configurar tus credenciales de AWS, agrega:

```yaml
- name: Install kubectl
  uses: azure/setup-kubectl@v1
  with:
    version: 'v1.21.3'
  id: install
```
Esto instalará la versión de kubectl necesaria.

### Al final del proceso, agrega:

```yaml

- name: Update kube config
  run: aws eks update-kubeconfig --name simple-bank --region eu-west-1
```
Esto actualizará tu archivo de configuración de kube para que apunte a tu clúster AWS EKS.

### Luego:

```yaml

- name: Deploy image to Amazon EKS
  run: |
    kubectl apply -f eks/aws-auth.yaml
    kubectl apply -f eks/deployment.yaml
    kubectl apply -f eks/service.yaml
    kubectl apply -f eks/issuer.yaml
    kubectl apply -f eks/ingress.yaml
```
Esto desplegará tus aplicaciones y servicios en AWS EKS.
### Configuración adicional

Además de las líneas de código anteriores, también debes seguir las instrucciones proporcionadas por Kubernetes para configurar ingress y desplegar tus aplicaciones con certificados TLS. Asegúrate de seguir las recomendaciones específicas para tu aplicación.

¡Listo! Ahora tienes Kubernetes configurado en AWS EKS. Si tienes alguna pregunta o encuentras problemas, no dudes en buscar ayuda en la documentación de AWS o Kubernetes, o abre un issue.

¡Buena suerte en producción!