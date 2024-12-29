#!/bin/bash
alias ping='ping -c 4 '
alias pingdup='sudo arping -D -I eth0 -c 2 '
alias ll='ls -alh '
alias poweroff='sudo poweroff; sleep 5'
alias reboot='sudo reboot; sleep 5'
alias cls='clear'
alias kt='kubectl top'
alias kg='kubectl get'
alias ka='kubectl apply'
alias kd='kubectl delete'
alias kc='kubectl create'
alias ks='kubectl get pods -n kube-system'
alias pc='sudo podman system prune -a -f'