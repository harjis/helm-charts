# How to develop:

Create new package
```shell script
helm create helm-chart-sources/<package_name>
```

Package charts
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

## Authenticator

1. Create values.yaml file in the repository 
where authenticator is going to be installed from

```yaml
backendHost: backend-cluster-ip-service
backendPort: 3000
```

2. Create secrets for okta
```shell script
kubectl create secret generic oktaclientid --from-literal OKTA_CLIENTID=my-id
kubectl create secret generic oktaissuer --from-literal OKTA_ISSUER=my-issuer
```

3. Install authenticator with
````shell script
helm install authenticator harjis-charts/authenticator -f authenticator_values.yaml
````

5. Route all backend traffic through the authenticator:

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

          - path: /api/
            pathType: Prefix
            backend:
              service:
                name: authenticator-cluster-ip-service
                port:
                  number: 5000 
```

6. Can be uninstalled with
````shell script
helm uninstall authenticator
````
