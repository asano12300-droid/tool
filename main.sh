#!/bin/bash

echo "1. githubの設定"
echo "2. 日本語化の設定"
echo -n "選択: "
read select

if [[ "$select" == "1" ]]; then
    bash Scripts/github.sh
elif [[ "$select" == "2" ]]; then
    bash Scripts/japanese.sh
fi