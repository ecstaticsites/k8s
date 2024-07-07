{{- define "accesslog.sql" -}}
CREATE TABLE IF NOT EXISTS default.accesslog (
  StatusCode      UInt16,
  StatusCategory  FixedString(3),
  Timestamp       DateTime,
  BytesSent       UInt32,
  RemoteIp        IPv4,
  Host            LowCardinality(String),
  Path            String,
  Referrer        String,
  Device          LowCardinality(String),
  Browser         LowCardinality(String),
  Os              LowCardinality(String),
  Country         LowCardinality(String),
  FileType        LowCardinality(String),
  IsProbablyBot   Bool
) Engine = MergeTree
ORDER BY (Host, Timestamp)
{{- end -}}
