#!/bin/bash
VENV='.venv'

git stash
rm -rf output/ .cache/

source $VENV/bin/activate

sphinx-build -a -E -b slides source output

rm -rf /tmp/build_output
mv output /tmp/build_output

git checkout -b build

rm -rf ./*
mv /tmp/build_output/* ./

git add .
git commit -m "Site compiled on `date`"
git push origin build
git checkout source
git stash pop
