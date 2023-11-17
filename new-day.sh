#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -eq 0 ] ; then
    echo "What day is it?"
    read today
else
    today=$1
fi

mkdir -p "day$today"
cp template/dayXXX.exs "day$today/day$today.exs"
touch "day$today/test-day"$today".txt"
touch "day$today/input-day"$today".txt"

sed -i "s/XXX/$today/g" day$today/*
