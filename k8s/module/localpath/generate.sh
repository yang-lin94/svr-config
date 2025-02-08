#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
kubectl kustomize ${script_dir}/localpath/ | tee ${script_dir}/localpath.yaml &>/dev/null
