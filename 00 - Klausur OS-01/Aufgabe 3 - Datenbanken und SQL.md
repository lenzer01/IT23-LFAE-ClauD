Bitte bepunkte mir folgende Klausuraufgabe sinnvoll:
## 3: Analyse von Verkaufsdaten

Sie haben Zugriff auf eine Datenbank eines Einzelhandelsunternehmens mit folgenden Tabellen:

**Tabelle: Produkte**

- produkt_id
- produktname
- kategorie
- preis

**Tabelle: Verkäufe**

- verkaufs_id
- produkt_id
- kunde_id
- verkaufsdatum
- menge
- umsatz

**Tabelle: Kunden**

- kunde_id
- name
- adresse
- email
- telefon

Ihre Aufgabe ist es, verschiedene Analysen zu den Verkaufsdaten durchzuführen und die Ergebnisse in SQL-Abfragen darzustellen.

1. **Umsatz pro Produktkategorie**
    
    - Erstellen Sie eine Abfrage, die den Gesamtumsatz für jede Produktkategorie ausgibt.
    - Sortieren Sie das Ergebnis absteigend nach dem Gesamtumsatz.
2. **Topprodukte nach Umsatz**
    
    - Schreiben Sie eine Abfrage, die die 5 umsatzstärksten Produkte ausgibt.
    - Zeigen Sie dafür den Produktnamen, den Preis und den Gesamtumsatz an.


Hinweise:

- Verwenden Sie geeignete JOIN-Befehle, um die Tabellen miteinander zu verknüpfen.
- Nutzen Sie Aggregatfunktionen wie SUM(), AVG(), COUNT() etc., um die gewünschten Berechnungen durchzuführen.
- Verwenden Sie Aliasnamen für eine übersichtliche Darstellung der Ergebnisse.

---

Musterlösung für die Analyse von Verkaufsdaten:

```sql
-- 1. Umsatz pro Produktkategorie
SELECT 
  p.kategorie,
  SUM(v.umsatz) AS gesamtumsatz
FROM Verkäufe v
JOIN Produkte p ON v.produkt_id = p.produkt_id
GROUP BY p.kategorie
ORDER BY gesamtumsatz DESC;

-- 2. Topprodukte nach Umsatz
SELECT 
  p.produktname,
  p.preis,
  SUM(v.umsatz) AS gesamtumsatz
FROM Verkäufe v
JOIN Produkte p ON v.produkt_id = p.produkt_id
GROUP BY p.produkt_id
ORDER BY gesamtumsatz DESC
LIMIT 5;

```

Erläuterungen:

1. **Umsatz pro Produktkategorie**:
    
    - Verknüpfung der Tabellen `Verkäufe` und `Produkte` über `produkt_id`
    - Gruppierung nach Produktkategorie und Berechnung des Gesamtumsatzes pro Kategorie
    - Sortierung absteigend nach dem Gesamtumsatz
2. **Topprodukte nach Umsatz**:
    
    - Verknüpfung der Tabellen `Verkäufe` und `Produkte` über `produkt_id`
    - Gruppierung nach Produkt und Berechnung des Gesamtumsatzes pro Produkt
    - Auswahl der Top 5 Produkte nach Gesamtumsatz



### Bewertungskriterien und Punktevergabe

1. **Umsatz pro Produktkategorie (maximal 5 Punkte)**
   - **Verwendung der richtigen Joins (1 Punkt):** Die korrekte Verknüpfung der Tabellen `Verkäufe` und `Produkte` über `produkt_id`.
   - **Verwendung von Aggregatfunktionen (1 Punkt):** Nutzung der Funktion `SUM()` zur Berechnung des Gesamtumsatzes.
   - **Gruppierung nach Kategorie (1 Punkt):** Richtige Gruppierung der Daten nach `kategorie`.
   - **Sortierung des Ergebnisses (1 Punkt):** Absteigende Sortierung nach dem Gesamtumsatz.
   - **Benennung und Klarheit der Spalten (1 Punkt):** Verwendung eines Alias für die Umsatzspalte (`gesamtumsatz`) für eine klare Darstellung.

2. **Topprodukte nach Umsatz (maximal 5 Punkte)**
   - **Verwendung der richtigen Joins (1 Punkt):** Die korrekte Verknüpfung der Tabellen `Verkäufe` und `Produkte` über `produkt_id`.
   - **Verwendung von Aggregatfunktionen (1 Punkt):** Nutzung der Funktion `SUM()` zur Berechnung des Gesamtumsatzes.
   - **Gruppierung nach Produkt (1 Punkt):** Richtige Gruppierung der Daten nach `produkt_id`.
   - **Sortierung und Begrenzung des Ergebnisses (1 Punkt):** Absteigende Sortierung nach dem Gesamtumsatz und Begrenzung auf die Top 5 Produkte mittels `LIMIT 5`.
   - **Auswahl relevanter Spalten mit Aliassen (1 Punkt):** Anzeige von `produktname`, `preis`, und Verwendung eines Alias für den Umsatz (`gesamtumsatz`) für Klarheit.

