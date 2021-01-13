# How to develop:

package charts
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

Install authenticator with
````shell script
helm install authenticator harjis-charts/authenticator -f authenticator_values.yaml
````
