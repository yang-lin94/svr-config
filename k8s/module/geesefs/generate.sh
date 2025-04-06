#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
kubectl kustomize "${script_dir}/geesefs/" | tee "${script_dir}/geesefs.yaml" &>/dev/null
