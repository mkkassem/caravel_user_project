#!/bin/bash

# Install github CLI
# MacOS/Windows : https://cli.github.com/manual/installation
# Linux         : https://github.com/cli/cli/blob/trunk/docs/install_linux.md

# Login to your github account to authenticate cli to access your repos
# This will display a an 8-letter code and ask you to confirm openning your default broewser
#
# gh auth login -p https -h github.com -w

# Variable Definitions

export MPW_TAG=$1
export MY_REPO_NAME=$2
export PROJECTS=/ciic/designs
export MPW_PROJECTS=$PROJECTS/${MPW_TAG::-1}-projects
export OPENLANE_ROOT=$MPW_PROJECTS/openlane
export PDK_ROOT=$MPW_PROJECTS/pdk

mkdir -p $MPW_PROJECTS && cd $MPW_PROJECTS

git clone -b $MPW_TAG https://github.com/efabless/caravel_user_project $MY_REPO_NAME ;

cd $MPW_PROJECTS/$MY_REPO_NAME

# Rename origin to upstream
git remote rename origin upstream

# Create a new branch, you can name it anything
git checkout -b main

## gh auth refresh -h github.com -s delete_repo
gh repo delete  $MY_REPO_NAME --confirm

gh repo create  $MY_REPO_NAME --public --push --source $MPW_PROJECTS/$MY_REPO_NAME

make setup




