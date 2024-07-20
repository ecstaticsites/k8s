{{- define "accesslog.sql" -}}
CREATE TABLE IF NOT EXISTS default.accesslog (
  PullZoneId     UInt32,
  Timestamp      DateTime,
  BytesSent      UInt32,
  StatusCode     UInt16,
  StatusCategory FixedString(3),
  Host           String,
  Path           String,
  Referrer       String,
  Device         LowCardinality(String),
  Browser        LowCardinality(String),
  Os             LowCardinality(String),
  Country        LowCardinality(String),
  FileType       LowCardinality(String),
  IsProbablyBot  Bool
) Engine = MergeTree
ORDER BY (PullZoneId, Timestamp)
{{- end -}}
