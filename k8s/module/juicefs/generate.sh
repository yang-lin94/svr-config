#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
kubectl kustomize "${script_dir}/juicefs/" | tee "${script_dir}/juicefs.yaml" &>/dev/null
kubectl kustomize "${script_dir}/redis/" | tee "${script_dir}/redis.yaml" &>/dev/null
