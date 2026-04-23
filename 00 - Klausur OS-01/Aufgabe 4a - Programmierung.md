### 4: Kundenverwaltungssystem

**Hintergrund:**  
Sie arbeiten an einem Kundenverwaltungssystem für ein kleines Unternehmen. Das System soll in der Lage sein, Kundeninformationen zu speichern und eine einfache Suche nach Kunden durchzuführen. Achten Sie auch darauf, grobe Fehler abzufangen.

**Aufgabenstellung:**  
Implementieren Sie einen Pseudocode für die folgenden Anforderungen:

1. **Datenstruktur:**  
    Erstellen Sie eine Datenstruktur `Kunde`, die die folgenden Attribute enthält:
    
    - `KundenID` (eindeutige Identifikationsnummer)
    - `Name` (Name des Kunden)
    - `Email` (E-Mail-Adresse des Kunden)
2. **Kundenliste:**  
    Erstellen Sie eine Liste, um mehrere Kundenobjekte zu speichern.
    
3. **Kunde hinzufügen:**  
    Schreiben Sie eine Funktion `KundeHinzufuegen(KundenListe, KundenID, Name, Email)`, die einen neuen Kunden zur Liste hinzufügt. Überprüfen Sie, ob die `KundenID` bereits existiert. Wenn ja, geben Sie eine Fehlermeldung aus.
    
4. **Kunde suchen:**  
    Schreiben Sie eine Funktion `KundeSuchen(KundenListe, KundenID)`, die einen Kunden anhand seiner `KundenID` sucht und die Informationen des Kunden zurückgibt. Wenn der Kunde nicht gefunden wird, geben Sie eine entsprechende Nachricht aus.
    
5. **Kunde entfernen:**  
    Schreiben Sie eine Funktion `KundeEntfernen(KundenListe, KundenID)`, die einen Kunden anhand seiner `KundenID` aus der Liste entfernt. Geben Sie eine Bestätigung aus, wenn der Kunde erfolgreich entfernt wurde, oder eine Fehlermeldung, wenn der Kunde nicht gefunden wurde.
    
6. **Zusatzfrage:**  
    Welche bekannte Datenstruktur ist besonders gut geeignet für die Realisierung dieser Aufgabe und warum?

Hier ist ein einfaches Beispiel, wie die Funktionen verwendet werden könnten:


```plaintext
// Hauptprogramm
KundenListe = []

KundeHinzufuegen(KundenListe, 1, "Max Mustermann", "max@beispiel.de")
KundeHinzufuegen(KundenListe, 2, "Erika Mustermann", "erika@beispiel.de")

KundeSuchen(KundenListe, 1)  // Sollte Max Mustermann finden
KundeEntfernen(KundenListe, 1)  // Sollte Max Mustermann entfernen
KundeSuchen(KundenListe, 1)  // Sollte "Kunde nicht gefunden" ausgeben
```


**Hinweis:**  
Die Implementierung sollte in Pseudocode (oder einer bekannte Programmiersprache) erfolgen und alle Funktionen sollten klar beschrieben sein.

### Musterlösung: Kundenverwaltungssystem

#### 1. Datenstruktur

Zuerst definieren wir die Struktur für einen Kunden.


```plaintext
Struktur Kunde:
    KundenID
    Name
    Email
```

#### 2. Kundenliste

Wir erstellen eine Liste, um mehrere Kundenobjekte zu speichern. In Pseudocode könnte dies so aussehen:


```plaintext
Liste KundenListe = []
```

#### 3. Kunde hinzufügen

Die Funktion `KundeHinzufuegen` überprüft, ob die `KundenID` bereits existiert und fügt einen neuen Kunden hinzu.


```plaintext
Funktion KundeHinzufuegen(KundenListe, KundenID, Name, Email):
    Wenn KundenID existiert in KundenListe:
        Ausgabe "Fehler: KundenID existiert bereits."
    Sonst:
        NeuerKunde = Kunde(KundenID, Name, Email)
        Füge NeuerKunde zu KundenListe hinzu
        Ausgabe "Kunde erfolgreich hinzugefügt."
```

#### 4. Kunde suchen

Die Funktion `KundeSuchen` sucht einen Kunden anhand seiner `KundenID`.

```plaintext
Funktion KundeSuchen(KundenListe, KundenID):
    Für jeden Kunde in KundenListe:
        Wenn Kunde.KundenID == KundenID:
            Ausgabe "Kunde gefunden: " + Kunde.Name + ", " + Kunde.Email
            Rückgabe Kunde
    Ausgabe "Kunde nicht gefunden."
    Rückgabe Null
```

#### 5. Kunde entfernen

Die Funktion `KundeEntfernen` entfernt einen Kunden aus der Liste.

```plaintext
Funktion KundeEntfernen(KundenListe, KundenID):
    Für jeden Kunde in KundenListe:
        Wenn Kunde.KundenID == KundenID:
            Entferne Kunde von KundenListe
            Ausgabe "Kunde erfolgreich entfernt."
            Rückgabe
    Ausgabe "Kunde nicht gefunden."
```

#### 6. Beispiel zur Verwendung der Funktionen

Hier ist ein einfaches Beispiel, wie die Funktionen verwendet werden könnten:


```plaintext
// Hauptprogramm
KundenListe = []

KundeHinzufuegen(KundenListe, 1, "Max Mustermann", "max@beispiel.de")
KundeHinzufuegen(KundenListe, 2, "Erika Mustermann", "erika@beispiel.de")

KundeSuchen(KundenListe, 1)  // Sollte Max Mustermann finden
KundeEntfernen(KundenListe, 1)  // Sollte Max Mustermann entfernen
KundeSuchen(KundenListe, 1)  // Sollte "Kunde nicht gefunden" ausgeben
```

#### 7. Antwort auf die Zusatzfrage

**Frage:** Welche bekannte Datenstruktur ist besonders gut geeignet für die Realisierung dieser Aufgabe und warum?

**Antwort:** Eine besonders geeignete Datenstruktur für die Realisierung dieser Aufgabe ist die **Hash-Tabelle** (oder Hash-Map).

**Begründung:**

- **Schneller Zugriff:** Hash-Tabellen bieten im Durchschnitt eine konstante Zeitkomplexität $O(1)$ für das Hinzufügen, Suchen und Entfernen von Elementen, was sie ideal für Szenarien macht, in denen häufige Abfragen und Modifikationen erforderlich sind.
- **Eindeutige Identifikation:** Da die `KundenID` eindeutig ist, kann sie als Schlüssel in der Hash-Tabelle verwendet werden, um schnell auf die zugehörigen Kundeninformationen zuzugreifen.
- **Effiziente Speicherverwaltung:** Hash-Tabellen ermöglichen eine effiziente Nutzung des Speichers, da sie dynamisch wachsen und schrumpfen können, je nach Anzahl der gespeicherten Kunden.


---
### Gesamtpunktzahl: 15 Punkte

1. **Datenstruktur (2 Punkte)**
   - Definition der Struktur `Kunde` mit den drei Attributen: `KundenID`, `Name`, `Email`. (2 Punkte)

2. **Kundenliste (1 Punkt)**
   - Erstellung einer Liste für Kundenobjekte. (1 Punkt)

3. **Kunde hinzufügen (4 Punkte)**
   - Überprüfung, ob die `KundenID` bereits existiert und entsprechende Fehlermeldung ausgeben. (2 Punkte)
   - Hinzufügen eines neuen Kunden zur Liste, wenn die ID nicht existiert. (1 Punkt)
   - Ausgabe einer Bestätigungsmeldung bei erfolgreichem Hinzufügen. (1 Punkt)

4. **Kunde suchen (3 Punkte)**
   - Implementierung der Suchfunktion durch Iteration über die Liste und Vergleich der `KundenID`. (2 Punkte)
   - Rückgabe und Ausgabe von Kundendaten, wenn gefunden; Ausgabe einer Nachricht, wenn nicht gefunden. (1 Punkt)

5. **Kunde entfernen (3 Punkte)**
   - Implementierung der Entfernungsfunktion durch Iteration über die Liste und Vergleich der `KundenID`. (2 Punkte)
   - Entfernen des Kundenobjekts und Ausgabe einer Bestätigungsmeldung oder Fehlermeldung je nach Ergebnis. (1 Punkt)

6. **Zusatzfrage zur Datenstrukturwahl (3 Punkte)**
   - Nennung der Hash-Tabelle als geeignete Datenstruktur für diese Aufgabe aufgrund ihrer Effizienz bei Zugriffen, Suchvorgängen und Modifikationen mit konstanter Zeitkomplexität im Durchschnitt \(O(1)\).(3 Punkte)
   - Begründung, warum eine Hash-Tabelle besonders vorteilhaft ist: schneller Zugriff durch eindeutige Schlüssel, effiziente Speicherverwaltung etc. (2 Punkte)

