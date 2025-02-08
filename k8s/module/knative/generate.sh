#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
kubectl kustomize ${script_dir}/knative/ | tee ${script_dir}/knative.yaml &>/dev/null
