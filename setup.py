
from setuptools import setup, find_packages

setup(
    name='databricks_pyspark_learning',
    version='1.0',
    description='Program to manage the databricks_pyspark_learning project.',
    author='Fabio Salinas',
    author_email='fabio.salinas1982@gmail.com',
    license='',
    packages=find_packages(
        where='src',
        include=['src', 'src.*']
    ),
    package_dir={
        '':'src'
    },
    zip_safe=False
)
