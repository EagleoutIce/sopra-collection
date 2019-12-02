# sopra-collection

## Motivation
Dies ist eine Ansammlung (hoffentlich) wundertoller LaTeX2e Klassen und Pakete, für das Softwaregrundprojekt
im Rahmen des Informatikstudiums an der Universität Ulm im Wintersemester 2019/20 sowie dem sich anschließendem
Sommersemester. Es grüßt: `team-020`.

## Was es so alles gibt

Bisher verfügt dieses Repository über die folgenden Klassen und Pakete, die alle jeweils ihre eigene Dokumentation
besitzen und weitestgehend unabhängig voneinander verwendet werden können:

- [Die Basis Dokumentklasse: sopra-base](sopra-base):
    Hier wird mittels `sopra-base.cls` die Basisklasse
    für alle Dokumente im Rahmen der Arbeit definiert.
    Es steht frei sie während der Arbeit hinsichtlich
    ihres Erscheinungsbild zu erweitern und/oder zu
    modifizieren. Hierbei soll die Kompatibiltät mit
    bereits erstellten Dokumenten nicht verletzt
    werden:
    - [sopra-base.cls](sopra-base/sopra-base.cls): Dies ist die versprochene Klassendatei.
    - [sopra-base.doc.tex](sopra-base/sopra-base.doc.tex): Dieses Dokument erzeugt die zugehörige Dokumentation. Für sie wird das [LILLY-Framework](https://github.com/EagleoutIce/LILLY) benötigt - sofern es genügt ist, reicht: `pdflatex sopra-base.doc.tex`.
        Eine kompilierte Variante sollte allerdings auch jeweils den Veröffentlichungen (Releases) beiliegen.
- [Dokumentieren mit: sopra-documentation](sopra-documentation):
    Dieses Paket definiert alle Befehle die für die Dokumentation verwendet werden (auch die, für die Dokumentation über dieses Paket :smile:)
    - [sopra-documentation.sty](sopra-documentation/sopra-documentation.sty): Dies ist das versprochene Paket.
    - [sopra-documentation.doc.tex](sopra-documentation/sopra-documentation.doc.tex): Dieses Dokument erzeugt die zugehörige Dokumentation. Für sie wird das [LILLY-Framework](https://github.com/EagleoutIce/LILLY) benötigt - sofern es installiert ist, reicht: `pdflatex sopra-documentation.doc.tex`.
        Eine kompilierte Variante sollte allerdings auch jeweils den Veröffentlichungen (Releases) beiliegen.
- [Modelle mit: sopra-models](sopra-models):
    Dieses Paket erlaubt es, gemeinsam mit dem integrierten (modifizierten) [tikz-uml](https://perso.ensta-paris.fr/~kielbasi/tikzuml/) (UML)-Modelle zu setzen.
    - [sopra-models.sty](sopra-models/sopra-models.sty): Dies ist das versprochene Paket.
    - [sopra-models.doc.tex](sopra-models/sopra-models.doc.tex): Dieses Dokument erzeugt die zugehörige Dokumentation. Für sie wird das [LILLY-Framework](https://github.com/EagleoutIce/LILLY) benötigt - sofern es installiert ist, reicht: `pdflatex sopra-models.doc.tex`.
        Eine kompilierte Variante sollte allerdings auch jeweils den Veröffentlichungen (Releases) beiliegen.

## Aktuelle ToDo's

Weil ich doch immer so viel vergesse:

- Es soll ein Paket für die automatische Definition von (nicht-)funktionalen, welches
  weiter unabhängig ist, hinzugefügt werden.
- tikz-uml oder vergleichbares soll dem Sammelsurium hinzugefügt werden.
- Das Dokument soll bezüglich seines Layouts hübscher werden.
- Es muss ein Beamer-Layout estellt werden (präsentationen und so :smiley:).
- Listings paket anpassen, zum einen damit abhängigkit von Lilly auflösen
  zum anderen Farblich an das Farbthema der Uni anpassen.