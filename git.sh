#!/bin/bash

git remote remove origin
commit='third push of everything'
#reponame=''
url="https://github.com/hary8678/Notes-$1.git"
git init
git add .
git commit -m "$commit"
git branch -M main
git remote add origin $url
git push -u origin main
