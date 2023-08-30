```sh
helm repo add influxdata https://helm.influxdata.com/
helm upgrade --install influxdb -f values.yaml influxdata/influxdb
```

InfluxDB can be accessed via port 8086 on the following DNS name from within your cluster:

  http://influxdb.default:8086

You can connect to the remote instance with the influx CLI. To forward the API port to localhost:8086, run the following:

  kubectl port-forward --namespace default $(kubectl get pods --namespace default -l app=influxdb -o jsonpath='{ .items[0].metadata.name }') 8086:8086

You can also connect to the influx CLI from inside the container. To open a shell session in the InfluxDB pod, run the following:

  kubectl exec -i -t --namespace default $(kubectl get pods --namespace default -l app=influxdb -o jsonpath='{.items[0].metadata.name}') /bin/sh
