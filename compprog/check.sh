#!/bin/bash

interrupted()
{
	exit $?
}

trap interrupted SIGINT
set -u

if [ -f "compile" ]; then
  ./compile
fi

SOL="./solution"

if [ ! -f "solution" ]; then
  SOL="pypy a.py"
fi

dir=${1-data}
for in in $dir/*.in; do
  filename="${in%.*}"
  ans="${filename}.ans"
  echo "$in"
  $SOL < $in | diff - $ans
done
