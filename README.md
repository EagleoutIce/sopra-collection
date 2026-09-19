[![made-with-latex](https://img.shields.io/badge/Made%20with-LaTeX-1f425f.svg)](https://www.latex-project.org/) [![GPL license](https://img.shields.io/badge/License-GPL-blue.svg)](http://perso.crans.org/besson/LICENSE.html) ![Compile all documentations and examples](https://github.com/EagleoutIce/sopra-collection/workflows/Compile%20all%20documentations%20and%20examples/badge.svg)

# sopra-collection

## Motivation

This is a collection of (hopefully) wonderful LaTeX2e classes and packages for the Softwaregrundprojekt
as part of the computer science studies at Ulm University in the 2019/20 winter semester and the following
summer semester.
Some packages, such as `sopra-listings`, were subsequently developed significantly further.

Greetings: Florian (`team-020`).

## Table of Contents

- [sopra-collection](#sopra-collection)
  - [Motivation](#motivation)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
    - [Standalone Installation](#standalone-installation)
    - [Installation with sltx](#installation-with-sltx)
  - [Package Overview](#package-overview)
    - [sopra-base (Documentation)](#sopra-base-documentation)
    - [sopra-documentation (Documentation)](#sopra-documentation-documentation)
    - [sopra-models (Documentation)](#sopra-models-documentation)
    - [sopra-requirements (Documentation)](#sopra-requirements-documentation)
    - [sopra-tables (Documentation)](#sopra-tables-documentation)
    - [sopra-attachments (Documentation)](#sopra-attachments-documentation)
    - [sopra-listings (Documentation)](#sopra-listings-documentation)
    - [sopra-changelog (Documentation)](#sopra-changelog-documentation)
    - [sopra-standard (Documentation)](#sopra-standard-documentation)
    - [sopra-paper (Documentation)](#sopra-paper-documentation)
    - [sopra-seraphim (Documentation)](#sopra-seraphim-documentation)
    - [sopra-ntts (Documentation)](#sopra-ntts-documentation)

## Installation

### Standalone Installation

Installation can be done either according to the respective documentation, or via the included Python script. With
an installed Python 3.5+ interpreter, it suffices to run:
`python3 installer.py`.

More detailed information on specifying the path can be found here: [wikibooks](https://en.wikibooks.org/wiki/LaTeX/Installing_Extra_Packages).

### Installation with sltx

The collection is also shipped with [sltx](https://github.com/EagleoutIce/sltx).
It can be found there among the suggested package sources, and in the Docker container starting from `tx-default`.
Its usage is set up there via [lithie-util](https://github.com/EagleoutIce/lithie-util).

## Package Overview

So far, this repository contains the following classes and packages, each of which has its own documentation
and can largely be used independently of one another:

### sopra-base ([Documentation](https://raw.githubusercontent.com/EagleoutIce/sopra-collection/gh-pages/sopra-base/sopra-base.doc.pdf))

The base document class: [sopra-base](sopra-base):
  Here, `sopra-base.cls` defines the base class for all documents within the project.
  It is free to be extended and/or modified in terms of its appearance during the course of the work.
  In doing so, compatibility with documents already created should not be broken:

- [sopra-base.cls](sopra-base/sopra-base.cls): This is the promised class file.
- [sopra-base.doc.tex](sopra-base/sopra-base.doc.tex): This document generates the corresponding documentation. For it, the `sopra-listings` package is used, if installed; then it suffices to run: `pdflatex sopra-base.doc.tex`.

### sopra-documentation ([Documentation](https://raw.githubusercontent.com/EagleoutIce/sopra-collection/gh-pages/sopra-documentation/sopra-documentation.doc.pdf))

Documenting with: [sopra-documentation](sopra-documentation):
  This package defines all commands used for documentation (including those for the documentation of this package itself :smile:)

- [sopra-documentation.sty](sopra-documentation/sopra-documentation.sty): This is the promised package.
- [sopra-documentation.doc.tex](sopra-documentation/sopra-documentation.doc.tex): For it, the `sopra-listings` package is used, if installed; then it suffices to run: `pdflatex sopra-documentation.doc.tex`.

### sopra-models ([Documentation](https://raw.githubusercontent.com/EagleoutIce/sopra-collection/gh-pages/sopra-models/sopra-models.doc.pdf))

Modeling with: [sopra-models](sopra-models):
  This package, together with the integrated (modified) [tikz-uml](https://perso.ensta-paris.fr/~kielbasi/tikzuml/), allows (UML) models to be typeset.

- [sopra-models.sty](sopra-models/sopra-models.sty): This is the promised package.
- [sopra-models.doc.tex](sopra-models/sopra-models.doc.tex): For it, the `sopra-listings` package is used, if installed; then it suffices to run: `pdflatex sopra-models.doc.tex`.

### sopra-requirements ([Documentation](https://raw.githubusercontent.com/EagleoutIce/sopra-collection/gh-pages/sopra-requirements/sopra-requirements.doc.pdf))

Requirement definitions with: [sopra-requirements](sopra-requirements):
  This package allows functional and non-functional requirements to be defined and referenced.

- [sopra-requirements.sty](sopra-requirements/sopra-requirements.sty): This is the promised package.
- [sopra-requirements.doc.tex](sopra-requirements/sopra-requirements.doc.tex): For it, the `sopra-listings` package is used, if installed; then it suffices to run: `pdflatex sopra-requirements.doc.tex`.

### sopra-tables ([Documentation](https://raw.githubusercontent.com/EagleoutIce/sopra-collection/gh-pages/sopra-tables/sopra-tables.doc.pdf))

Tables with: [sopra-tables](sopra-tables):
  This package allows tables to be styled nicely:

- [sopra-tables.sty](sopra-tables/sopra-tables.sty): This is the promised package.
- [sopra-tables.doc.tex](sopra-tables/sopra-tables.doc.tex): For it, the `sopra-listings` package is used, if installed; then it suffices to run: `pdflatex sopra-tables.doc.tex`.

### sopra-attachments ([Documentation](https://raw.githubusercontent.com/EagleoutIce/sopra-collection/gh-pages/sopra-attachments/sopra-attachments.doc.pdf))

Embedding files with: [sopra-attachments](sopra-attachments):
  This package allows documents to be embedded into a PDF:

- [sopra-attachments.sty](sopra-attachments/sopra-attachments.sty): This is the promised package.
- [sopra-attachments.doc.tex](sopra-attachments/sopra-attachments.doc.tex): For it, the `sopra-listings` package is used, if installed; then it suffices to run: `pdflatex sopra-attachments.doc.tex`.

### sopra-listings ([Documentation](https://raw.githubusercontent.com/EagleoutIce/sopra-collection/gh-pages/sopra-listings/sopra-listings.doc.pdf))

Listings with: [sopra-listings](sopra-listings):
  This package allows source code to be typeset in PDF with syntax highlighting:

- [sopra-listings.sty](sopra-listings/sopra-listings.sty): This is the promised package.
- [sopra-listings.doc.tex](sopra-listings/sopra-listings.doc.tex): For it, the package itself is required, then it suffices: `pdflatex sopra-listings.doc.tex`.

The package offers support for [color-palettes](https://github.com/EagleoutIce/color-palettes); examples can be found [here](https://raw.githubusercontent.com/EagleoutIce/sopra-collection/gh-pages/sopra-listings/examples/cp-listings.example.pdf) and [here](https://raw.githubusercontent.com/EagleoutIce/sopra-collection/gh-pages/sopra-tables/examples/cp-tables.example.pdf).

### sopra-changelog ([Documentation](https://raw.githubusercontent.com/EagleoutIce/sopra-collection/gh-pages/sopra-changelog/sopra-changelog.doc.pdf))

Changelogs with: [sopra-changelog](sopra-changelog):
  This package allows changes in documents to be recorded:

- [sopra-changelog.sty](sopra-changelog/sopra-changelog.sty): This is the promised package.
- [sopra-changelog.doc.tex](sopra-changelog/sopra-changelog.doc.tex): For it, the `sopra-listings` package is used, if installed; then it suffices to run: `pdflatex sopra-changelog.doc.tex`.

### sopra-standard ([Documentation](https://raw.githubusercontent.com/EagleoutIce/sopra-collection/gh-pages/sopra-standard/sopra-standard.doc.pdf))

Sopra standard with: [sopra-standard](sopra-standard):
  This package was used for the standardization document:

- [sopra-standard.sty](sopra-standard/sopra-standard.sty): This is the promised package.
- [sopra-standard.doc.tex](sopra-standard/sopra-standard.doc.tex): For it, the `sopra-listings` package is used, if installed; then it suffices to run: `pdflatex sopra-standard.doc.tex`.

### sopra-paper ([Documentation](https://raw.githubusercontent.com/EagleoutIce/sopra-collection/gh-pages/sopra-paper/sopra-paper.doc.pdf))

The document layout with: [sopra-paper](sopra-paper):
  This document class was used for the standard, and the milestones of Team020:

- [sopra-paper.cls](sopra-paper/sopra-paper.cls): This is the promised document class.
- [sopra-paper.doc.tex](sopra-listings/sopra-paper.doc.tex): For it, the package itself is required, then it suffices: `pdflatex sopra-paper.doc.tex`.

### sopra-seraphim ([Documentation](https://raw.githubusercontent.com/EagleoutIce/sopra-collection/gh-pages/sopra-seraphim/sopra-seraphim.doc.pdf))

Presentations with: [sopra-seraphim](sopra-seraphim):
  This document class was used for the telegrams and the final presentation of Team020:

- [sopra-seraphim.cls](sopra-changelog/sopra-seraphim.cls): This is the promised document class.
- [sopra-seraphim.doc.tex](sopra-changelog/sopra-seraphim.doc.tex): For it, the `sopra-listings` package is used, if installed; then it suffices to run: `pdflatex sopra-seraphim.doc.tex`.

### sopra-ntts ([Documentation](https://raw.githubusercontent.com/EagleoutIce/sopra-collection/gh-pages/sopra-ntts/sopra-ntts.doc.pdf))

Lettering with: [sopra-ntts](sopra-ntts):
  This package contains the ntts lettering.

- [sopra-ntts.cls](sopra-changelog/sopra-ntts.cls): This is the promised document class.
- [sopra-ntts.doc.tex](sopra-changelog/sopra-ntts.doc.tex): For it, the `sopra-listings` package is used, if installed; then it suffices to run: `pdflatex sopra-ntts.doc.tex`.
