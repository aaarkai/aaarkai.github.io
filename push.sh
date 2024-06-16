#!/bin/bash
# Temporarily store uncommited changes
git stash

# Verify correct branch
git checkout develop
git pull

# make sure node path contains global
export NODE_PATH=$(npm root --quiet -g)

# make sure katex_cli is here
# cp /Users/kai/ref/katex_cli/target/debug/katex_cli katex_cli
# Build new files
stack build --ghc-options=-O2
stack exec kaisite clean
stack exec kaisite build

# make python environment
# python3 -m venv venv
# source venv/bin/activate
# pip3 install -r requirements.txt
# Build index
python3 pub.py > _site/index.html

# Get previous files
git fetch --all
git checkout -b main --track origin/main

# Overwrite existing files with new files
rsync -a --checksum --filter='P _site/' --filter='P _cache/' --filter='P .git/' --filter='P .stack-work/' --filter='P .gitignore' --filter='P .gitattributes' --delete-excluded _site/ .
rm -rf drafts

# Commit
touch .nojekyll
git add -A
git commit -m "Publish."

# Push
git push origin main:main

# Restoration
git checkout develop
git branch -D main
git stash pop
