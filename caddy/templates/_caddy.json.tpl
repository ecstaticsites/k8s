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
              "git.cbnr.xyz": "default"
            }
          },
          "routes": [
            {
              "handle": [
                {
                  "handler": "subroute",
                  "routes": [
                    {
                      "handle": [
                        {
                          "handler": "reverse_proxy",
                          "upstreams": [
                            {
                              "dial": "query.default:8080"
                            }
                          ]
                        }
                      ],
                      "match": [
                        {
                          "path": [
                            "/query"
                          ]
                        }
                      ]
                    }
                  ]
                }
              ],
              "match": [
                {
                  "host": [
                    "api.cbnr.xyz"
                  ]
                }
              ],
              "terminal": true
            },
            {
              "handle": [
                {
                  "handler": "subroute",
                  "routes": [
                    {
                      "handle": [
                        {
                          "handler": "reverse_proxy",
                          "upstreams": [
                            {
                              "dial": "gitserver.default:8080"
                            }
                          ]
                        }
                      ]
                    }
                  ]
                }
              ],
              "match": [
                {
                  "host": [
                    "git.cbnr.xyz"
                  ]
                }
              ],
              "terminal": true
            }
          ],
          "metrics": {}
        }
      }
    },
    "layer4": {
      "servers": {
        "srv1": {
          "listen": [
            "udp/:517"
          ],
          "routes": [
            {
              "handle": [
                {
                  "handler": "proxy",
                  "upstreams": [
                    {
                      "dial": [
                        "udp/intake.default:8517"
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
