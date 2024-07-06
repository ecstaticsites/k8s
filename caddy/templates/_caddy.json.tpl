{{- define "caddy.json" -}}
{
  "admin": {
    "disabled": true
  },
  "apps": {
    "http": {
      "servers": {
        "metric": {
          "listen": [
            ":2019"
          ],
          "routes": [
            {
              "handle": [
                {
                  "handler": "subroute",
                  "routes": [
                    {
                      "handle": [
                        {
                          "handler": "metrics"
                        }
                      ],
                      "match": [
                        {
                          "path": [
                            "/metrics"
                          ]
                        }
                      ]
                    }
                  ]
                }
              ],
              "terminal": true
            }
          ]
        },
        "srv0": {
          "listen": [
            ":443"
          ],
          "logs": {
            "logger_names": {
              "api.cbnr.xyz": "default",
              "git.cbnr.xyz": "default",
              "query.cbnr.xyz": "default"
            }
          },
          "routes": [
          {{- range $i, $svc := list "api" "git" "query" }}
            {
              "handle": [
                {
                  "handler": "subroute",
                  "routes": [
                    {
                      "handle": [
                        {
                          "handler": "reverse_proxy",
                          "dynamic_upstreams": {
                            "source": "a",
                            "name": "{{ $svc }}.default",
                            "port": "8080",
                            "refresh": "10s",
                            "versions": {
                              "ipv4": true,
                              "ipv6": false
                            }
                          }
                        }
                      ]
                    }
                  ]
                }
              ],
              "match": [
                {
                  "host": [
                    "{{ $svc }}.cbnr.xyz"
                  ]
                }
              ],
              "terminal": true
            }{{ eq $i 2 | ternary "" "," }}
          {{- end }}
          ],
          "metrics": {}
        }
      }
    },
    "layer4": {
      "servers": {
        "srv1": {
          "listen": [
            "tcp/:517"
          ],
          "routes": [
            {
              "handle": [
                {
                  "handler": "proxy",
                  "upstreams": [
                    {
                      "dial": [
                        "tcp/intake.default:8517"
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
      }
    },
    "tls": {
      "automation": {
        "policies": [
          {
            "issuers": [
              {
                "email": "brandon@willett.io",
                "module": "acme"
              },
              {
                "email": "brandon@willett.io",
                "module": "zerossl"
              }
            ],
            "subjects": [
              "api.cbnr.xyz"
            ]
          }
        ]
      }
    }
  },
  "logging": {
    "logs": {
      "default": {
        "encoder": {
          "format": "console"
        },
        "level": "debug"
      }
    }
  },
  "storage": {
    "module": "redis",
    "address": "redis.default:6379",
    "username": "",
    "password": "",
    "db": 1,
    "key_prefix": "caddytls",
    "value_prefix": "caddy-storage-redis",
    "timeout": 5,
    "tls_enabled": false,
    "tls_insecure": true
  }
}
{{- end -}}
