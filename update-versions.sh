#!/usr/bin/env bash
set -euo pipefail

curl -sf https://endoflife.date/api/v1/products/kubernetes \
  | yq -pjson '{
    "kubectl_version": [
      .result.releases[] | select(.isMaintained) | "v" + .latest.name
    ],
    "include": [
      {
        "kubectl_version": "v" + .result.releases.0.latest.name,
        "is_latest": true
      }
    ]
  }' \
  | tee versions.yaml
