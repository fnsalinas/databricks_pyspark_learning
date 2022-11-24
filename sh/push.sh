#!/bin/bash

cd ~/workspace/fsalinas/databricks_pyspark_learning


# lt=$(timedatectl | grep -i "Local time")
lt=$(date)
commit_msg=$lt" - Pushing changes to GitHub";

echo "===============> Running git status...";
git status;

echo "===============> Running git add...";
git add . -A;
git add .;

echo "===============> Running git status...";
git status;

echo "===============> Running git commit... "$commit_msg;
git commit -m "$commit_msg";

echo "===============> Running git push origin master...";
git push;

echo "===============> Git push complete.";