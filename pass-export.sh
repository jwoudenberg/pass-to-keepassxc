#!/usr/bin/env bash

# Create an unencrypted copy of a pass directory in ~/tmp.

set -euox pipefail

pushd ~/.password-store
passwords=$(find -name '*.gpg')
for password in $passwords; do
  password=${password#"./"}
  password=${password%".gpg"}
  exported="$HOME/tmp/$password"
  mkdir -p "$(dirname $exported)"
  if [ -f "$exported" ]; then
    echo "$exported already exists"
  else
    pass show "$password" > "$exported"
  fi
done
