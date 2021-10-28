#!/usr/bin/env bash

# Create a keepassxc-compatible csv file from an unencrypted pass directory in
# ~/tmp.

set -euox pipefail

pushd ~/tmp
passwords=$(find -type f)
substitution='s/"/""/g'

csv="$HOME/passwords.csv"
rm -f "$csv"
for password in $passwords; do
  category=$(basename $(dirname $password) | sed 's/^.$//')
  echo "\"$(basename $password)\",$category,\"$(head -n 1 $password | sed "$substitution")\",\"$(tail -n+2 $password | sed "$substitution")\"" >> "$csv"
done
