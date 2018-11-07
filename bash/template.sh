#!/bin/bash

set -eu

interrupted()
{
	exit $?
}

trap interrupted SIGINT

if [ "$#" -lt 1 ]; then
  echo "Usage: test <PATH>"
  exit 1
fi

