#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
kubectl kustomize ${script_dir}/metallb/ | tee ${script_dir}/metallb.yaml &>/dev/null
