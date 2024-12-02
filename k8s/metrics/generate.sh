#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
kubectl kustomize ${script_dir}/metrics/ | tee ${script_dir}/metrics.yaml &>/dev/null
