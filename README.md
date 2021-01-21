# How to develop:

Create new package
```shell script
helm create helm-chart-sources/<package_name>
```

Package a chart
```shell script
helm package helm-chart-sources/<package_name>
```

Package all charts
```shell script
helm package helm-chart-sources/*
```

Generate new index:
```shell script
helm repo index --url https://harjis.github.io/helm-charts/ .
```

Merge to existing index:
```shell script
helm repo index --url https://harjis.github.io/helm-charts/ --merge index.yaml .
```

# How to use:

```shell script
helm repo add harjis-charts https://harjis.github.io/helm-charts/
```

# How to install

## Authentication-service

1. Create values.yaml file in the repository 
where authentication-service is going to be installed from. These values should point to the routing backend
proxy or the actual backend itself (if there is only one backend)

authentication_service_values.yaml:
```yaml
backendHost: backend-cluster-ip-service
backendPort: 3000
```

2. Create secrets for okta
```shell script
kubectl create secret generic oktaclientid --from-literal OKTA_CLIENTID=my-id
kubectl create secret generic oktaissuer --from-literal OKTA_ISSUER=my-issuer
```

3. Install authentication-service with
````shell script
helm install authentication-service harjis-charts/authentication-service -f authentication_service_values.yaml
````

5. Route all backend traffic through the authenticator & expose the frontend on root path:

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-service
  annotations:
    kubernetes.io/ingress.class: nginx
spec:
  rules:
    - http:
        paths:
          -
            path: /
            backend:
              serviceName: authentication-service-frontend-cluster-ip-service
              servicePort: 3001
          - path: /api/
            pathType: Prefix
            backend:
              service:
                name: authentication-service-frontend-cluster-ip-service
                port:
                  number: 3000
```

6. Can be uninstalled with
````shell script
helm uninstall authentication-service
````

## Folder-service

1. Install all the services

```shell script
helm install folder-service harjis-charts/folder-service
```
