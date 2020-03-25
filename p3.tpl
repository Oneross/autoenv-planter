// Inspired by:
// - Tip Hopper's Conda Workflow: http://stiglerdiet.com/blog/2015/Nov/24/my-python-environment-workflow-with-conda/
// - Brett Terpstra's Planter: http://brettterpstra.com/projects/planter/
// - Kenneth Reitz's autoenv: https://github.com/kennethreitz/autoenv
// - Conda's env documentation: http://conda.pydata.org/docs/using/envs.html
//
// Prerequisite:
// - OSX
// - Continuum's Anaconda Python Distribution: https://www.continuum.io/downloads
// - Planter: http://brettterpstra.com/projects/planter/ (place on your path)
// - Autoenv: make-able, but `brew install autoenv' works
//
// Setup
// This repo represents my ~/.planter directory.  I have 2 basic 'plant environments', p2 and p3.
// They will use Brett Terpstraa's "Planter" functionality to create a few basic directories & copy files in.
// Additionally, they will build conda's environment.env and autoenv's .env files,
//    build the environment, and open my editor on that directory.
// The environment.env file is buit by composition, stitching together:
// - a project specific header than defines a new conda environment
// - a python-version specific '.dependendencies' file (in case 'six' is always needed, etc.)
// - a common '.dependencies' file (for things like numpy and ipython that I can't imagine living without)

%%1%% 
    images
    data
---
# Build conda dependencies file
puts "Building conda environment.yml"
puts "- creating header"
%x{echo "name: %%1%%\ndependencies:"> %%1%%/environment.yml}
puts "- Injecting python 3 dependency"
%x{cat ~/.planter/p3.dependencies >> %%1%%/environment.yml}
puts "- Injecting common dependencies"
%x{cat ~/.planter/common.dependencies >> %%1%%/environment.yml}

# Create conda env
puts "Creating conda environment (be patient, downloading dependencies)"
puts "    (if this hangs on visigoth, make sure proxy is set)"
%x{cd %%1%%; conda env create}

# Build autoenv config file
# autoenv available via brew: brew install autoenv
# full details at: https://github.com/kennethreitz/autoenv
puts "Building autoenv config file"
%x{cd %%1%%; echo "source activate %%1%%" > .env}

# Git
puts "Initializing git repo"
%x{cd %%1%%; git init; git add .; git commit -m "initial commit"}

# Open files for editing
puts "Opening directory for editing"
%x{cd %%1%%; subl .}