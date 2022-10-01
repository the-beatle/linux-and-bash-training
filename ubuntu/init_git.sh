#!/bin/bash

sudo apt update
sudo apt install git
git --version

git config --global user.name "the-beatle"
git config --global user.email "marcae7@gmail.com"

git config --list

ssh-keygen -t rsa -C "marcae7@gmail.com"

cat ~/.ssh/id_rsa.pub
