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
(target_fm).mkdir(parents=True, exist_ok=True)


def get_pkg_cls_name(dirname: str) -> str:
    # Check if dirname is a class or package
    if os.path.isfile(Path.cwd() / Path(dirname) / (dirname + '.sty')):
        return dirname + '.sty'
    else:
        return dirname + '.cls'


def update_or_install_component(source_file: Path, tar_dirname: Path, tar_filename: str, indent: int) -> None:
    # Check for dir creation:
    (tar_dirname/tar_filename).parent.mkdir(parents=True, exist_ok=True)
    # print("called with: " + tar_filename)
    if not os.path.isfile(tar_dirname/tar_filename):
        print(" "*indent + "Installing: '%s'" % tar_filename)
        copyfile(source_file, tar_dirname / tar_filename)
    elif os.path.getmtime(source_file) > os.path.getmtime(tar_dirname/tar_filename):
        print(" "*indent + "Updating: '%s'" % tar_filename)
        copyfile(source_file, tar_dirname / tar_filename)
    else:
        print(" "*indent + "Is up to date: '%s'" % tar_filename)


# Walk current path and filter for sopra'
for root, dirs, files in os.walk("."):
    for dirname in dirs:
        if "sopra-" in dirname:
            filename = get_pkg_cls_name(dirname)
            source_dir = Path.cwd() / Path(dirname)
            source_file = source_dir / filename
            update_or_install_component(source_file, target_fm, filename, 0)
            # We'll now check, if there are additional installer-files
            extra_f = source_dir/".install-extras"
            if os.path.isfile(extra_f):
                print("  * Package has extras!")
                with open(extra_f) as read_extras:
                    for f in read_extras.readlines():
                        f = f.replace("\n", "")
                        update_or_install_component(
                            source_dir/f, target_fm, f, 4)
