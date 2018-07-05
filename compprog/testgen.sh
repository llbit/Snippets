#!/bin/bash

interrupted()
{
	exit $?
}

trap interrupted SIGINT

set -eu

# Usage:
# Create scripts gen, ref, and solution to run test case generator.
# Optional: compile script is run before running any tests. Can be used
# to compile gen, ref, solution.
# The current seed is passed as the first argument to the generator.

GENDIR="generated"
if [ ! -d "$GENDIR" ]; then
  mkdir $GENDIR
fi

if [ -f "compile" ]; then
  ./compile
fi

GEN="./gen"
REF="./ref"
SOL="./solution"

if [ ! -f "gen" ]; then
  GEN="pypy gen.py"
fi

if [ ! -f "ref" ]; then
  REF="pypy ref.py"
fi

if [ ! -f "solution" ]; then
  SOL="pypy a.py"
fi

i=0
while true; do
  i=$((i+1))
  echo "SEED = $i"
  in="$GENDIR/$i.in"
  ans="$GENDIR/$i.ans"
  $GEN $i $@ > $in
  $REF < $in > $ans
  $SOL < $in | diff - $ans
done
