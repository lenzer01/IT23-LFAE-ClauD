![[Kopfzeile AB.png]]

# Klausur 3. Ausbildungsjahr, 1. Hj. (IT23) - LF10/12 (Gesamtpunkte: 87 Pkt.)

**Name:** 

*Sie arbeiten für die SicherDichAb GmbH in der Anwendungsentwicklung. Das Unternehmen stellt bald eine neue Software für die Landespolizei zur Verfügung, die dabei helfen soll, Ermittlungsverfahren digital abzubilden.*

## Aufgabe 1: Datenbank Ermittlungsverfahren (25 Pkt.)
Die SicherDichAb GmbH soll für eine Polizeikreisbehörde eine Datenbank erstellen, in der die Daten von Ermittlungsverfahren (Vorgängen) erfasst werden, die bislang in folgender Excel-Tabelle gespeichert wurden. Die Namen der Beschuldigten sind geschwärzt.

**Erfassung von Ermittlungsverfahren**

| Vorgangs-ID | Delinquent-ID | Anrede | Delinquent | Geburtsdatum | Adresse | Delikt | Datum | Dokument | Bearbeiter         |
|-------------|--------------|--------|------------|--------------|---------|--------|-------|----------|--------------------|
| 301         | 5645         | Herr   | [geschw.]  | 28.02.1970   | 01234 Astadt, Kernweg 12 | Raub          | 02.04.2017 | Personalausweis, Fahrerlaubnis | Hansen, Klaus       |
| 302         | 1213         | Herr   | [geschw.]  | 06.06.2000   | 02566 Bstadt, Müller-Str. 1 | Drogenmissbrauch | 02.02.2014 | Personalausweis | Müller, Marcel       |
| 303         | 7887         | Herr   | [geschw.]  | 01.07.1988   | 03669 Astadt, Franzgasse 3 | Fahrerflucht, Drogenmissbrauch | 30.03.2017 | Reisepass, Fahrerlaubnis | Hansen, Klaus |
| 304         | 4545         | Frau   | [geschw.]  | 16.08.1991   | 02566 Bstadt, Burgplatz 16 | Drogenmissbrauch | 12.04.2017 | Personalausweis | Wagner, Wolfram      |
| 305         | 1213         | Herr   | [geschw.]  | 06.06.2000   | 02566 Bstadt, Müller-Str. 1 | Körperverletzung | 08.03.2015 | Personalausweis | Hansen, Klaus        |
| ...         | ...          | ...    | ...        | ...          | ...     | ...    | ...   | ...      | ...                |

Erstellen Sie auf einer Extraseite für die neue Software ein relationales Datenmodell in der dritten Normalform.
- Geben Sie den Tabellen und Attributen selbsterklärende Namen.
- Nennen Sie je Tabelle alle erforderlichen Attribute.
- Kennzeichnen Sie Primärschlüssel mit PK und Fremdschlüssel mit FK.
- Zeichnen Sie die Beziehungen mit deren Kardinalitäten ein.

**Hinweis:** Die Adresse des Delinquenten soll in diesem ersten Entwurf noch nicht normalisiert werden.

---
## Aufgabe 2: Ermittlungsverfahren-Datenbank und SQL-Abfragen (18 Pkt.)

Die SicherDichAb GmbH entwickelt ein System zur Verwaltung von Ermittlungsverfahren. Dazu wurde bereits folgende Datenbank entworfen und mit Testdaten gefüllt.

Liste der Tabellen inkl. Relationen:  
- **Person** (`PersonID`, Nachname, Vorname, Straße, PLZ, Ort)  
- **Vorgang** (`VorgangsID`, `PersonID` [FK], DatumVon, DatumBis)  
- **Delikt** (`DeliktID`, Bezeichnung)  
- **Dokument** (`DokumentID`, Bezeichnung)  
- **Bearbeiter** (`BearbeiterID`, Nachname, Vorname)
- **Zuordnung** (VorgangsID [FK], DeliktID [FK], DokumentID [FK], BearbeiterID [FK])

Beispieldaten (Auszug):

**Person**

| PersonID | Nachname | Vorname | Straße       | PLZ   | Ort      |
| -------- | -------- | ------- | ------------ | ----- | -------- |
| 1001     | Schmitt  | Tina    | Blumweg 12   | 10111 | Hamburg  |
| 1002     | Berger   | Lena    | Birkenweg 8  | 44222 | Dortmund |
| 1003     | Wolf     | Markus  | Hauptstr. 90 | 50670 | Köln     |

**Vorgang**

| VorgangsID | PersonID | DatumVon | DatumBis |
|------------|----------|----------|----------|
| 501        | 1001     | 01.04.2022 | 10.04.2022 |
| 502        | 1002     | 05.06.2022 | 10.06.2022 |
| 503        | 1003     | 11.07.2022 | 20.07.2022 |

**Delikt**

| DeliktID | Bezeichnung          |
|----------|---------------------|
| 1        | Raub                |
| 2        | Drogenmissbrauch    |

**Dokument**

| DokumentID | Bezeichnung         |
|------------|--------------------|
| 1          | Personalausweis    |
| 2          | Führerschein       |

**Bearbeiter**

| BearbeiterID | Nachname   | Vorname   |
|--------------|------------|-----------|
| 10           | Hansen     | Klaus     |
| 11           | Meier      | Sabine    |

**Zuordnung**

| VorgangsID | DeliktID | DokumentID | BearbeiterID |
|------------|----------|------------|--------------|
| 501        | 1        | 1          | 10           |
| 502        | 2        | 2          | 11           |
| 503        | 2        | 1          | 10           |

---

**Aufgabenstellung (jeweils 6 Pkt.):**  
Erstellen Sie die SQL-Anweisungen für folgende Ausgaben:

a) Listen Sie alle Ermittlungsverfahren mit zugehörigen Personen- und Deliktdaten, jeweils aufsteigend sortiert nach Nachname und Deliktsbezeichnung.  

b) Listen Sie alle Vorgänge und ergänzen Sie jeweils die zugehörigen Bearbeiterdaten sowie die betroffenen Dokumente. Vorgänge ohne Bearbeiter/Dokument sind dennoch anzuzeigen 

c) Ermitteln Sie die Anzahl Ermittlungsverfahren pro Delikt.  

---
## Aufgabe 3: Bearbeitungszeiten optimieren (25 Pkt.)

*Die SicherDichAb GmbH möchte die Bearbeitung von Ermittlungsverfahren besser anhand der tatsächlichen Bearbeitungszeiten analysieren. Dazu wurden die Bearbeitungszeiten eines Ermittlungsverfahrens an den einzelnen Bearbeitungsschritten für mehrere Fälle an mehreren Tagen gemessen.*

Für jeden Tag ist festgehalten, wann das Verfahren die nachfolgenden Bearbeitungsschritte verlässt (siehe Array **zeiten**).

#### Beispielhafter Ablauf eines Ermittlungsverfahrens:

Bearbeitungsschritt 0 → Bearbeitungsschritt 1 → … → Bearbeitungsschritt 14 → Abschluss

Für die einzelnen Tage ist gespeichert, wie lange ein Verfahren für jeden Schritt gebraucht hat.

Es existiert eine Klasse **Bearbeitungszeit**, mit den Attributen ein Datum, eine Schritt-Nummer, die geplante Bearbeitungszeit (in Minuten seit Mitternacht) und die tatsächliche Bearbeitungszeit (ebenfalls in Minuten). Für den Abschlussschritt sind die geplanten/tatsächlichen Abschlusszeiten gespeichert.

**Klasse Bearbeitungszeit**

| Attribut          | Typ    | Beschreibung                          |
|-------------------|--------|---------------------------------------|
| datum             | Date   | Datum der Verfahrensbearbeitung       |
| schrittNr         | Integer| Nummer des Bearbeitungsschritts       |
| planBearbeitung   | Integer| geplante Zeit in Minuten seit Mitternacht |
| istBearbeitung    | Integer| tatsächliche Zeit in Minuten seit Mitternacht |

Für jedes Attribut ist eine öffentliche Get-Methode vorhanden.

In einem eindimensionalen Array **zeiten** vom Typ **Bearbeitungszeit** sind die Daten des zu untersuchenden Zeitraums gespeichert. In jeder Zeile sind die Daten eines **Bearbeitungszeit**-Objekts aufgeführt.

**Beispielliste der Daten des Arrays zeiten**

| Datum      | Schritt Nummer | Geplante Bearbeitung | Tatsächliche Bearbeitung |
|------------|---------------|----------------------|-------------------------|
| 1.9.2024   | 0             | 480                  | 480                     |
| 1.9.2024   | 1             | 483                  | 483                     |
| 1.9.2024   | 2             | 485                  | 486                     |
| ...        | ...           | ...                  | ...                     |
| 1.9.2024   | 15            | 579                  | 583                     |
| 2.9.2024   | 0             | 480                  | 480                     |
| ...        | ...           | ...                  | ...                     |
| 2.9.2024   | 15            | 579                  | 582                     |

Die Bearbeitungsdauer für einen Schritt ist die Differenz der Bearbeitungszeiten zweier aufeinanderfolgender Schritte.
Eine Verzögerung liegt vor, wenn die Bearbeitungsdauer mehr als zwei Minuten länger war als die geplante Bearbeitungsdauer.

**Aufgabe:**  
Entwickeln Sie einen Algorithmus für eine Funktion:

ermittleVerzoegerungen(Bearbeitungszeit[] zeiten) : Integer[]

… der für jeden der 15 Bearbeitungsschritte die Anzahl an Verzögerungen ermittelt.

Die Häufigkeiten der Verzögerungen sollen in einem eindimensionalen Array vom Typ Integer gespeichert und von der Funktion zurückgegeben werden.

**Beispiel Ergebnisarray:**

| Index | Anzahl Verzögerungen > 2 | Kommentar                          |
|-------|--------------------------|-------------------------------------|
| [0]   | 0                        | auf Schritt 0                       |
| [1]   | 1                        | auf Schritt 1                       |
| [2]   | 4                        | auf Schritt 2                       |
| ...   | ...                      | ...                                 |
| [14]  | 3                        | auf Schritt 14                      |

Stellen Sie den Algorithmus in Pseudocode dar.

---
## Aufgabe 4: Datenformate und Datenaustausch (14 Pkt.)

*Neben der Verwaltung von Ermittlungsverfahren selbst soll auch die erfassungsdienstliche Lagerverwaltung mit in das System integriert werden. Dazu bedarf es einiger Überlegungen zum Thema Datenaustauschformate.*

a) 
Gegeben ist folgender XML-Datensatz, der in der neuen Software zur digitalen Bearbeitung von Bestellungen für erkenntungsdienstliche Instrumente und Materialien verwendet wird:

```xml
<bestellung id="1001">
  <kunde name="Anna Müller" email="anna.mueller@polizei.de"/>
  <produkt artikelnummer="P789" anzahl="2" preis="49.90"/>
  <produkt artikelnummer="P123" anzahl="1" preis="89.50"/>
  <versand adresse="Musterstraße 12, 12345 Berlin" prioritaet="normal"/>
</bestellung>
```

**Aufgabe (5 Pkt.):**  
Konvertieren Sie den obigen XML-Datensatz in ein semantisch äquivalentes JSON-Objekt.

---
b)
Im Rahmen deiner Tätigkeit in der Anwendungsentwicklung der SicherDichAb GmbH wird eine neue Schnittstelle zwischen dem Lagerverwaltungssystem und dem ERP-System eingeführt. Der Lieferant übermittelt seine verfügbaren Artikel zukünftig im XML-Format.  

Die Daten lauten:
- Lieferant: Name „TechSupply GmbH“, ID „LS007“, E-Mail „info@techsupply.de“
- Artikel 1: Artikelnummer „A1001“, Bezeichnung „USB-C Kabel 2m“, Lagerbestand 150, Preis 12.99 €
- Artikel 2: Artikelnummer „A1002“, Bezeichnung „Mechanische Tastatur“, Lagerbestand 35, Preis 89.90 €

**Aufgabe (5 Pkt.):**  
Erstellen Sie ein gültiges XML-Dokument, das diese Daten strukturiert darstellt. Verwenden Sie Attribute sinnvoll (z. B. für IDs oder Zahlenwerte).

---
c)
**Aufgabe (4 Pkt):**  
In welchen betrieblichen oder technischen Szenarien sollte **XML** gegenüber **JSON** bevorzugt werden? Nennen Sie zwei konkrete Gründe und erklären Sie sie kurz.

---

# Aufgabe 5: Design Pattern (5 Pkt.)

*Ihr Vorgesetzter hat noch nie von Design Pattern in der Software-Entwicklung gehört und fragt nun Sie nach dem Begriff.*

Erläutern Sie kurz, was man unter einem "Design Pattern" in der Softwareentwicklung versteht.  
Nennen Sie anschließend ein konkretes Beispiel für ein bekanntes Design Pattern und beschreiben Sie dessen Zweck in eigenen Worten.