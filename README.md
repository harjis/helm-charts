# How to:

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
