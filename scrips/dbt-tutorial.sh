#!/usr/bin/env bash
echo "# dbt-tutorial" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:bytetrend/dbt-tutorial.git
git push -u origin main
