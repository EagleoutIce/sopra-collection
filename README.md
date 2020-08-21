# sopra-collection

## Motivation

Dies ist eine Ansammlung (hoffentlich) wundertoller LaTeX2e Klassen und Pakete, für das Softwaregrundprojekt
im Rahmen des Informatikstudiums an der Universität Ulm im Wintersemester 2019/20 sowie dem sich anschließendem
Sommersemester. Es grüßt: `team-020`.

## Installation

Die Installation kann entweder je nach Dokumentation, oder durch das mitgelieferte python-skript erfolgen. Bei
einem installierten python3.5+ interpreter genügt:
`python3 installer.py`

Genauere Informationen zur Angabe des Pfades lassen sich hier finden: [wikibooks](https://en.wikibooks.org/wiki/LaTeX/Installing_Extra_Packages).

## Was es so alles gibt

Bisher verfügt dieses Repository über die folgenden Klassen und Pakete, die alle jeweils ihre eigene Dokumentation
besitzen und weitestgehend unabhängig voneinander verwendet werden können:

- [Die Basis Dokumentklasse: sopra-base](sopra-base):
  Hier wird mittels `sopra-base.cls` die Basisklasse
  für alle Dokumente im Rahmen der Arbeit definiert.
  Es steht frei sie während der Arbeit hinsichtlich
  ihres Erscheinungsbild zu erweitern und/oder zu
  modifizieren. Hierbei soll die Kompatibilität mit
  bereits erstellten Dokumenten nicht verletzt
  werden:
  - [sopra-base.cls](sopra-base/sopra-base.cls): Dies ist die versprochene Klassendatei.
  - [sopra-base.doc.tex](sopra-base/sopra-base.doc.tex): Dieses Dokument erzeugt die zugehörige Dokumentation. Für sie wird das `sopra-listings`-Paket - sofern es installiert ist, reicht: `pdflatex sopra-base.doc.tex`.

- [Dokumentieren mit: sopra-documentation](sopra-documentation):
  Dieses Paket definiert alle Befehle die für die Dokumentation verwendet werden (auch die, für die Dokumentation über dieses Paket :smile:)
  - [sopra-documentation.sty](sopra-documentation/sopra-documentation.sty): Dies ist das versprochene Paket.
  - [sopra-documentation.doc.tex](sopra-documentation/sopra-documentation.doc.tex): Für sie wird das `sopra-listings`-Paket - sofern es installiert ist, reicht: `pdflatex sopra-documentation.doc.tex`.

- [Modelle mit: sopra-models](sopra-models):
  Dieses Paket erlaubt es, gemeinsam mit dem integrierten (modifizierten) [tikz-uml](https://perso.ensta-paris.fr/~kielbasi/tikzuml/) (UML)-Modelle zu setzen.
  - [sopra-models.sty](sopra-models/sopra-models.sty): Dies ist das versprochene Paket.
  - [sopra-models.doc.tex](sopra-models/sopra-models.doc.tex): Für sie wird das `sopra-listings`-Paket - sofern es installiert ist, reicht: `pdflatex sopra-models.doc.tex`.

- [Anforderungsdefinitionen mit: sopra-requirements](sopra-requirements):
  Dieses Paket erlaubt es, funktionale und nicht-funktionale Anforderungen zu definieren und zu referenzieren.
  - [sopra-requirements.sty](sopra-requirements/sopra-requirements.sty): Dies ist das versprochene Paket.
  - [sopra-requirements.doc.tex](sopra-requirements/sopra-requirements.doc.tex): Für sie wird das `sopra-listings`-Paket - sofern es installiert ist, reicht: `pdflatex sopra-requirements.doc.tex`.

- [Tabellen mit: sopra-tables](sopra-tables):
  Dieses Paket erlaubt es, Tabellen hübsch zu gestalten:
  - [sopra-tables.sty](sopra-tables/sopra-tables.sty): Dies ist das versprochene Paket.
  - [sopra-tables.doc.tex](sopra-tables/sopra-tables.doc.tex): Für sie wird das `sopra-listings`-Paket - sofern es installiert ist, reicht: `pdflatex sopra-tables.doc.tex`.

- [Dateien einbetten mit: sopra-attachments](sopra-attachments):
  Dieses Paket erlaubt es, Dokumente in eine PDF einzubetten:
  - [sopra-attachments.sty](sopra-attachments/sopra-attachments.sty): Dies ist das versprochene Paket.
  - [sopra-attachments.doc.tex](sopra-attachments/sopra-attachments.doc.tex): Für sie wird das `sopra-listings`-Paket - sofern es installiert ist, reicht: `pdflatex sopra-attachments.doc.tex`.

- [Listings mit: sopra-listings](sopra-listings):
  Dieses Paket erlaubt es, Quellcode in PDF mit Syntaxhighlighting zu setzen:
  - [sopra-listings.sty](sopra-listings/sopra-listings.sty): Dies ist das versprochene Paket.
  - [sopra-listings.doc.tex](sopra-listings/sopra-listings.doc.tex): Für sie wird das Paket selbst benötigt, dann reicht: `pdflatex sopra-listings.doc.tex`.

- [Changelogs mit: sopra-changelog](sopra-changelog):
  Dieses Paket erlaubt es, Änderungen in Dokumenten festzuhalten:
  - [sopra-changelog.sty](sopra-changelog/sopra-changelog.sty): Dies ist das versprochene Paket.
  - [sopra-changelog.doc.tex](sopra-changelog/sopra-changelog.doc.tex): Für sie wird das `sopra-listings`-Paket - sofern es installiert ist, reicht: `pdflatex sopra-changelog.doc.tex`.

- [Sopra-Standard mit: sopra-standard](sopra-standard):
  Dieses Paket wurde für das Standardisierungsdokument verwendet:
  - [sopra-standard.sty](sopra-standard/sopra-standard.sty): Dies ist das versprochene Paket.
  - [sopra-standard.doc.tex](sopra-standard/sopra-standard.doc.tex): Für sie wird das `sopra-listings`-Paket - sofern es installiert ist, reicht: `pdflatex sopra-standard.doc.tex`.

- [Das Dokumentlayout mit: sopra-paper](sopra-paper):
  Diese Dokumentklasse wurde für den Standard, und die Meilensteine von Team020 verwendet:
  - [sopra-paper.cls](sopra-paper/sopra-paper.cls): Dies ist die versprochene Dokumentklasse.
  - [sopra-paper.doc.tex](sopra-listings/sopra-paper.doc.tex): Für sie wird das Paket selbst benötigt, dann reicht: `pdflatex sopra-paper.doc.tex`.

- [Präsentationen mit: sopra-seraphim](sopra-seraphim):
  Diese Dokumentklasse wurde für die Telegramme und die Abschlusspräsentation von Team020 verwendet:
  - [sopra-seraphim.cls](sopra-changelog/sopra-seraphim.cls): Dies ist das versprochene Dokumentklasse.
  - [sopra-seraphim.doc.tex](sopra-changelog/sopra-seraphim.doc.tex): Für sie wird das `sopra-listings`-Paket - sofern es installiert ist, reicht: `pdflatex sopra-seraphim.doc.tex`.
