#!/bin/bash
# Replace file extension for all files in directory.
for f in DIR/*.txt; do
  nf="${f%*.txt}.foo"
  mv $f $nf
done
