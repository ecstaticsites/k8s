{{- define "influxdb.conf" -}}
reporting-disabled = false
bind-address = ":8088"

[meta]
  dir = "/var/lib/influxdb/meta"

[data]
  dir = "/var/lib/influxdb/data"
  wal-dir = "/var/lib/influxdb/wal"

[coordinator]

[retention]

[shard-precreation]

[monitor]

[subscriber]

[http]
  bind-address = ":8086"
  enabled = true
  flux-enabled = true

# TODO: allow multiple graphite listeners

[[graphite]]

# TODO: allow multiple collectd listeners with templates

[[collectd]]

# TODO: allow multiple opentsdb listeners with templates

[[opentsdb]]

# TODO: allow multiple udp listeners with templates

[[udp]]

[continuous_queries]

[logging]

{{- end -}}
