#!/bin/bash

git remote remove origin
commit='first push of everything'
#reponame=''
url="https://github.com/hary868867/Notes-$1.git"
git init
git add .
git commit -m "$commit"
git branch -M main
git remote add origin $url
git push -u origin main

