```sh
helm repo add influxdata https://helm.influxdata.com/
helm upgrade --install influxdb -f values.yaml influxdata/influxdb
```

Then for CLI:

```sh
kubectl exec -it influxdb-0 -- influx
```
