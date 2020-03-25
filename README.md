# Autoenv-planter

Mike's autoenv-conda-planter, inspired in part by an private group post from Dec 2, 2015:

> I'm thinking about switching back to conda for Python package/environment management: http://stiglerdiet.com/blog/2015/Nov/24/my-python-environment-workflow-with-conda/. #fixingforafight #andrewbaiting 

## Inspired by:
- Tip Hopper's Conda Workflow: http://stiglerdiet.com/blog/2015/Nov/24/my-python-environment-workflow-with-conda/
- Brett Terpstra's Planter: http://brettterpstra.com/projects/planter/
- Kenneth Reitz's autoenv: https://github.com/kennethreitz/autoenv
- Conda's env documentation: http://conda.pydata.org/docs/using/envs.html

## Prerequisites:
- OSX (probably not a hard dependency)
- Continuum's Anaconda Python Distribution: https://www.continuum.io/downloads (but there's a brew for that)
- Planter: http://brettterpstra.com/projects/planter/ (place on your path)
- Autoenv: make-able, but `brew install autoenv` works; 2020 update - zsh's dotenv plugin works as well

## Setup
This repo represents my ~/.planter directory.  I have 2 basic plant environments, p2 and p3.

They will use Brett Terpstraa's "Planter" functionality to create a few basic directories & copy files in.

Additionally, they will build conda's environment.env and autoenv's .env files,
   build the environment, and open my editor on that directory.

The environment.env file is buit by composition, stitching together:

- a project specific header than defines a new conda environment
- a python-version specific '.dependendencies' file (in case 'six' is always needed, etc.)
- a common '.dependencies' file (for things like numpy and ipython that I can't imagine living without)

**Note:** This can use a lot of cleanup.  Right now, you HAVE to `git clone git@github.com:Oneross/autoenv-planter.git ~/.planter` and have all the pre-requisites in place.  This should be automated and easier.  But I wanted to share. :)

## Usage

Think about a new project, decide you want python 2:

```
cd ~/dev
plant p2 myawesomeproject
cd myawesomeproject
```

Now you need python 3

```
cd ~/dev
plant p3 mynewawesomep3project
cd mynewawesomep3project
```

With conda, autoenv, and planter installed, this will:
- create a project directory
- create a default conda environment.env file based on python version and common dependencies
- create a conda environment from the environment.env file
- create an autoenv .env file which will activate the conda env on cd'ing into the project directory
- open sublime text in the directory