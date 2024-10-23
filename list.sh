#!/bin/bash

RAW='https://raw.githubusercontent.com/yang-lin94/srv_config/refs/heads/main'

echo '' >README.md
for model in $(ls -d */ | sed 's|/||g'); do
  ls ${model}/ | grep '\.' >${model}/model_name
  while read name; do
    echo "# ${model} ${name}" >>README.md
    echo '' >>README.md
    echo '```bash' >>README.md
    echo "wget -qO - ${RAW}/${model}/${name}/${name}.sh | sudo bash" >>README.md
    echo '```' >>README.md
    echo '' >>README.md
  done <${model}/model_name
done
