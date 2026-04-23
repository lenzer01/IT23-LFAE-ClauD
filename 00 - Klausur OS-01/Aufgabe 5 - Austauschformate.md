## Aufgabe: Austauschformate XML und JSON

### Teil 1: XML zu JSON konvertieren (10 Minuten)

Gegeben ist folgender XML-Datensatz, der eine Bestellung repräsentiert:

```xml
<bestellung id="1001">
  <kunde name="Anna Müller" email="anna.mueller@beispiel.de"/>
  <produkt artikelnummer="P789" anzahl="2" preis="49.90"/>
  <produkt artikelnummer="P123" anzahl="1" preis="89.50"/>
  <versand adresse="Musterstraße 12, 12345 Berlin" prioritaet="normal"/>
</bestellung>
```

**Aufgabe:**  
Konvertiere den obigen XML-Datensatz in ein semantisch äquivalentes JSON-Objekt.

---

### Teil 2: Betriebliche Situation – XML-Struktur erstellen (5–7 Minuten)

In deinem Ausbildungsbetrieb wird eine neue Schnittstelle zwischen dem Lagerverwaltungssystem und dem ERP-System eingeführt. Der Lieferant übermittelt seine verfügbaren Artikel zukünftig im XML-Format. Du sollst eine XML-Struktur erstellen, die folgende Informationen für einen Lieferanten und seine Artikel enthält:

- Lieferant: Name „TechSupply GmbH“, ID „LS007“, E-Mail „info@techsupply.de“
- Artikel 1: Artikelnummer „A1001“, Bezeichnung „USB-C Kabel 2m“, Lagerbestand 150, Preis 12.99 €
- Artikel 2: Artikelnummer „A1002“, Bezeichnung „Mechanische Tastatur“, Lagerbestand 35, Preis 89.90 €

**Aufgabe:**  
Erstelle ein gültiges XML-Dokument, das diese Daten strukturiert darstellt. Verwende Attribute sinnvoll (z. B. für IDs oder Zahlenwerte).

---

### Teil 3: Anwendungsbereiche vergleichen (3–5 Minuten)

**Frage:**  
In welchen betrieblichen oder technischen Szenarien wird **XML** gegenüber **JSON** bevorzugt? Nenne zwei konkrete Gründe und erkläre sie kurz.

---
## Musterlösung: Austauschformate XML und JSON

### Teil 1: XML zu JSON konvertieren

```json
{
  "bestellung": {
    "id": "1001",
    "kunde": {
      "name": "Anna Müller",
      "email": "anna.mueller@beispiel.de"
    },
    "produkt": [
      {
        "artikelnummer": "P789",
        "anzahl": "2",
        "preis": "49.90"
      },
      {
        "artikelnummer": "P123",
        "anzahl": "1",
        "preis": "89.50"
      }
    ],
    "versand": {
      "adresse": "Musterstraße 12, 12345 Berlin",
      "prioritaet": "normal"
    }
  }
}
```

> Hinweis: Alternativ können `produkt`, `kunde` und `versand` als Attribute oder gemischt dargestellt sein. Vollständige Äquivalenz ist das Ziel.

---

### Teil 2: XML-Struktur für Lieferantendaten

```xml
<lieferant id="LS007" name="TechSupply GmbH" email="info@techsupply.de">
  <artikel artikelnummer="A1001" bezeichnung="USB-C Kabel 2m" lagerbestand="150" preis="12.99"/>
  <artikel artikelnummer="A1002" bezeichnung="Mechanische Tastatur" lagerbestand="35" preis="89.90"/>
</lieferant>
```

> Alternativ kann `<artikel>` auch als Container mit Unterelementen formuliert werden. Attribute sind hier sinnvoll für suchbare/metadatenhafte Werte wie Artikelnummer und Zahlen.

---

### Teil 3: Wann wird XML gegenüber JSON bevorzugt?

1. **Schema-Validierung durch XSD:**  
    In betrieblichen Systemen (z. B. Rechnungsaustausch, E-Invoicing) wird XML oft bevorzugt, weil mit XSD (XML Schema Definition) streng definierte Formate erzwungen werden können. Das erhöht die Datenintegrität und erleichtert die automatische Verarbeitung.
    
2. **Komplexe Dokumentstrukturen und Metadaten:**  
    XML eignet sich besser für textbasierte Dokumente mit tiefer Hierarchie und Annotationen (z. B. in Behörden, Gesetzesdaten, technische Dokumentation). Es unterstützt Kommentare, Namespaces und erlaubt eine feinere Strukturierung als JSON.
