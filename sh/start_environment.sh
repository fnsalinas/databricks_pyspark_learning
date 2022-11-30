#!/bin/bash

folder_name="databricks_pyspark_learning"
project_name=${folder_name}

actual_path=$(pwd)
dirname=${actual_path##*/}

if [ "$dirname" != "$folder_name" ]; then
    echo "-----------> ERROR <-----------"
    echo "=====> STOP!!! You are not in the right folder. Please go to the $folder_name folder and try again."
    exit 1
fi

echo "-----------> Starting the process on $dirname  <-----------"

echo "=====> Downloading the last version of the code from the repository"
git status;
git pull;

echo "-----------> Creating folders and files <-----------"
mkdir -p "sh"
mkdir -p "src"
test -f "src/__init__.py" || touch "src/__init__.py"
mkdir -p "src/common"
test -f "src/common/__init__.py" || touch "src/common/__init__.py"

mkdir -p "utils"
mkdir -p "data"
mkdir -p "notebooks"

# If setup.py file doesn't exist, create it
if [ ! -f "setup.py" ]; then
    echo "=====> Creating setup.py file"
    echo "" >> setup.py
    echo "from setuptools import setup, find_packages" >> setup.py
    echo "" >> setup.py
    echo "setup(" >> setup.py
    echo "    name='$project_name'," >> setup.py
    echo "    version='1.0'," >> setup.py
    echo "    description='Program to manage the $project_name project.'," >> setup.py
    echo "    author='Fabio Salinas'," >> setup.py
    echo "    author_email='fabio.salinas1982@gmail.com'," >> setup.py
    echo "    license=''," >> setup.py
    echo "    packages=find_packages(" >> setup.py
    echo "        where='src'," >> setup.py
    echo "        include=['src', 'src.*']" >> setup.py
    echo "    )," >> setup.py
    echo "    package_dir={" >> setup.py
    echo "        '':'src'" >> setup.py
    echo "    }," >> setup.py
    echo "    zip_safe=False" >> setup.py
    echo ")" >> setup.py
fi

# if requirements.txt file doesn't exist, create it
if [ ! -f "requirements.txt" ]; then
    echo "=====> Creating requirements.txt file"
    echo "pandas" >> requirements.txt
    echo "tabulate" >> requirements.txt
    echo "pydata_google_auth" >> requirements.txt
    echo "google-cloud-bigquery" >> requirements.txt
    echo "pandas-gbq" >> requirements.txt
    echo "matplotlib" >> requirements.txt
    echo "plotly" >> requirements.txt
    echo "seaborn" >> requirements.txt
    echo "nbformat" >> requirements.txt
    echo "pandas-profiling" >> requirements.txt
    echo "ipywidgets" >> requirements.txt
    echo "cx-Oracle" >> requirements.txt
    echo "pyodbc" >> requirements.txt
    echo "pyspark" >> requirements.txt
fi

# if README.md file doesn't exist, create it
if [ ! -f "README.md" ]; then
    echo "=====> Creating README.md file"
    echo "# $project_name" >> README.md
    echo "" >> README.md
    echo "Program to manage the $project_name project." >> README.md
    echo "" >> README.md
    echo "## Installation" >> README.md
    echo "" >> README.md
fi

echo "-----------> Starting the environment <-----------"
echo "=====> Installing the dependencies..."
echo "=====> Running the command: pipenv install"
pipenv install;

echo "=====> Running the command: pipenv install -r requirements.txt"
pipenv install -r requirements.txt;

echo "=====> Running the command: pipenv install -e ."
pipenv install -e .;

echo "=====> Uploading the new files to the repository"
bash sh/push.sh;