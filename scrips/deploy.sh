#!/usr/bin/env bash

if [ -z "$CI" ]; then
  echo "This script is intended to be run on Gitlab CI!"
  exit 1
fi

source <(/tools/vault_populate_env)

gcloud config set account $ANSIBLE_ACCOUNT && gcloud config set project $PROJECT
gcloud auth activate-service-account $DEV_ANSIBLE_ACCOUNT --key-file <(echo $ANSIBLE_PASS)

BUCKET=`gcloud composer environments describe $COMPOSER_NAME --location $COMPOSER_REGION --format json | jq -r '.config.dagGcsPrefix'`

for path in dependencies/*; do
  yml="${path}/config/external_vars.yaml"
  j2="${yml}.j2"

  if [ -f "${j2}" ]; then
    /tools/jinjaci "${j2}" > "${yml}" && rm "${j2}"
  fi
done

gsutil cp -r ./dependencies/* $BUCKET/dependencies/
ls *-dag.py | xargs -I dag_file gsutil cp dag_file $BUCKET/dag_file
