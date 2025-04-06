#!/bin/bash
if ! sudo -l -U "$(whoami)" &>/dev/null; then
  echo "Sorry, user $(whoami) is not allowed to execute 'sudo' on $(hostname)" && exit 1
fi

if ! command -v podman &>/dev/null; then
  echo "please install podman first" && exit 1
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
vip="172.16.1.1"
interface="eth0"
kvipVersion="$(curl -sL https://api.github.com/repos/kube-vip/kube-vip/releases/latest | jq -r .name)"

sudo podman image pull "ghcr.io/kube-vip/kube-vip:${kvipVersion}"
sudo podman run --rm "ghcr.io/kube-vip/kube-vip:${kvipVersion}" manifest pod \
  --interface "${interface}" \
  --address "${vip}" \
  --controlplane \
  --services \
  --arp \
  --leaderElection |
  sed 's|imagePullPolicy: Always|imagePullPolicy: IfNotPresent|g' |
  tee "${script_dir}/kube-vip.yaml" &>/dev/null
