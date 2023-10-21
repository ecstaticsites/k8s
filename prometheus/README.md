```sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm upgrade --install prometheus -f values.yaml prometheus-community/prometheus
```

Then for web UI:

```sh
kubectl port-forward pod/prometheus-server-0 9090:9090
```
