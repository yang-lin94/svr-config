#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
kubectl kustomize ${script_dir}/portainer/ | tee ${script_dir}/portainer.yaml &>/dev/null
