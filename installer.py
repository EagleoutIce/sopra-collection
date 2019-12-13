#!/usr/bin/python3

# Installer for 'sopra-*' LaTeX Packages

import os
import sys
from pathlib import Path
from shutil import copyfile

print("Please enter your texmf home path!")
print("Note, if you don't know the path, there are defaults:")
print("     - texlive on linux: '<home>/texmf/'")
print("     - macTeX on Darwin: '/Users/<yourUsername>/Library/texmf/'")

target_path = os.path.expanduser(input('TEXMF> '))

print("Using: '%s'" % (target_path))

if not os.path.isdir(target_path):
    print("The Path you've specified does not exist!")
    print("Should it be created?")
    create = input("[y/N] ")
    if(create.lower() == "y"):
        os.mkdir(target_path)
    else:
        print("Cancel.")
        sys.exit(1)


print("Generating texmf-tree...")
target_fm = Path(target_path) / 'tex' / 'latex' / 'sopra-packages'
(target_fm).mkdir(parents=True,exist_ok=True)


def getPkgClsName(dirname : str):
    # Check if dirname is a class or package
    if os.path.isfile(Path.cwd() / Path(dirname) / (dirname + '.sty')):
        return dirname + '.sty'
    else:
        return dirname + '.cls'

# Walk current path and filter for sopra'
for root, dirs, files in os.walk("."):
    for dirname in dirs:
        if "sopra-" in dirname:
            
            filename = getPkgClsName(dirname)
            target_file = Path.cwd() / Path(dirname) / filename
            if not os.path.isfile(target_fm/filename):
                print("Installing: '%s'" % filename)
                copyfile(target_file,target_fm / filename)
            elif os.path.getmtime(target_file) > os.path.getmtime(target_fm/filename):
                print("Updating: '%s'" % filename)
                copyfile(target_file,target_fm / filename)
            else:
                print("Is up to date: '%s'" % filename)
