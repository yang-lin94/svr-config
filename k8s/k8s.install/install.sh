#!/bin/bash
if ! sudo -l -U "$(whoami)" &>/dev/null; then
  echo "Sorry, user $(whoami) is not allowed to execute 'sudo' on $(hostname)" && exit 1
fi

if ! command -v kubectl &>/dev/null; then
  echo 'Please install "kubectl"' && exit 1
fi


# 取得 crictl.yaml 中的 endpoint 設定
if [ -f "/etc/crictl.yaml" ]; then
  criSocket=$(awk '!seen[$2]++ && /endpoint:/ {gsub(/"/, "", $2); print $2; exit}' /etc/crictl.yaml)
  if [ -z "$criSocket" ]; then
    echo "無法從 /etc/crictl.yaml 讀取 endpoint" && exit 1
  fi
  export criSocket
else
  echo "/etc/crictl.yaml 不存在" && exit 1
fi

if hostname | grep -qxE 'km1'; then
  # init
  export kubeversion=$(sudo kubeadm version -o json | jq -r .clientVersion.gitVersion)

  if [ "${kubeversion}" == "" ]; then
    echo "kubeadm not found" && exit 1
  fi

  if [ "${clustername}" == "" ]; then
    echo "clustername is not set" && exit 1
  fi

  if [ "${vip}" == "" ]; then
    echo "vip is not set" && exit 1
  fi


  wget -qO - https://raw.githubusercontent.com/yang-lin94/svr-config/refs/heads/main/k8s/k8s.install/init-config.yaml | envsubst > /tmp/init-config.yaml
  sudo kubeadm init --config=/tmp/init-config.yaml



  # copy cluster token to home
  mkdir -p "${HOME}"/.kube
  sudo cp -i /etc/kubernetes/admin.conf "${HOME}"/.kube/config
  sudo chown "$(id -u)":"$(id -g)" "${HOME}"/.kube/config

  # setup canal
  wget -qO - https://raw.githubusercontent.com/yang-lin94/svr-config/refs/heads/main/k8s/cni.canal/canal.yaml | kubectl apply -f -


  # set master can run pod
  kubectl taint nodes --all node-role.kubernetes.io/control-plane- node-role.kubernetes.io/master-

  # echo worker join command
  join="sudo $(kubeadm token create --print-join-command)"
  echo "${join}"
fi

wget -qO - https://raw.githubusercontent.com/yang-lin94/svr-config/refs/heads/main/k8s/download | bash