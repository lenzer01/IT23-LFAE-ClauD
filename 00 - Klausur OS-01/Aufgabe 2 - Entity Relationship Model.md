### 2: ER-Modell für eine Bibliothek

**Aufgabenstellung:**

Sie sind als Fachinformatiker in einer kleinen Bibliothek tätig. Die Bibliotheksleitung hat Sie beauftragt, ein ER-Modell für die Verwaltung der Bibliotheksbestände und -ausleihen zu erstellen, da das System bisher komplett auf Papier verwaltet wird. Nun soll es digitalisiert werden.

Folgende Anforderungen sollen in Ihrem ER-Modell berücksichtigt werden:

1. **Nutzer**: Jeder Nutzer hat eine eindeutige Mitgliedsnummer, einen Namen und eine Adresse.
2. **Bücher**: Jedes Buch hat eine ISBN, einen Titel und einen Autor.
3. **Ausleihen**: Für jede Ausleihe eines Buches wird ein Ausleihvorgang erstellt. Zu einem Ausleihvorgang gehören die Ausleih-Nr., das Ausleih- und Rückgabedatum sowie der ausleihende Nutzer.
4. **Mitarbeiter**: In der Bibliothek arbeiten Bibliothekare. Jeder Mitarbeiter hat eine Personalnummer und einen Namen.
5. **Zuordnungen**: Jede Ausleihe wird von einem Mitarbeiter bearbeitet.

Erstellen Sie ein ER-Modell, das die oben genannten Anforderungen abbildet. Achten Sie dabei auf die korrekten Kardinalitäten zwischen den Entitäten.

Hinweis: Verwenden Sie für die grafische Darstellung des ER-Modells die bekannten Konventionen, achten Sie auch darauf, starke und schwache Entitäten zu unterscheiden.

---

**Bewertungskriterien:**

- Korrekte Identifikation der Entitäten (5 Punkte)
- Korrekte Darstellung der Beziehungen und Kardinalitäten (10 Punkte)
- Vollständigkeit und Richtigkeit des ER-Modells (5 Punkte)

Insgesamt: 20 Punkte

## Musterlösung für die Klausuraufgabe "ER-Modell für eine Bibliothek":

#### Grafische Darstellung des ER-Modells:
``` mermaid
erDiagram

    NUTZER ||--o{ AUSLEIHE : "1:n"

    AUSLEIHE }|--o{ MITARBEITER : "1:1"

    BUCH ||--o{ AUSLEIHE : "n:m"

  

    NUTZER {

        int Mitgliedsnr

        string Name

        string Adresse

    }

  

    AUSLEIHE {

        int Ausleih-Nr

        date Ausleihdtm

        date Rueckgabedtm

    }

  

    MITARBEITER {

        int Personalnr

        string Name

    }

  

    BUCH {

        string ISBN

        string Titel

        string Autor

    }
  ```
**Erläuterungen zum ER-Modell:**

1. **Entität Nutzer**:
    
    - Attribute: Mitgliedsnummer, Name, Adresse
    - Starke Entität
2. **Entität Ausleihe**:
    
    - Attribute: Ausleih-Nr, Ausleihdatum, Rückgabedatum
    - Schwache Entität, da sie von den Entitäten Nutzer und Buch abhängig ist
3. **Entität Mitarbeiter**:
    
    - Attribute: Personalnummer, Name
    - Starke Entität
4. **Entität Buch**:
    
    - Attribute: ISBN, Titel, Autor
    - Starke Entität
5. **Beziehungen**:
    
    - 1:n Beziehung zwischen Nutzer und Ausleihe: Ein Nutzer kann mehrere Ausleihen tätigen, aber eine Ausleihe gehört zu genau einem Nutzer.
    - 1:n Beziehung zwischen Ausleihe und Mitarbeiter: Eine Ausleihe wird von genau einem Mitarbeiter bearbeitet, und ein Mitarbeiter kann mehrere Ausleihen bearbeiten.
    - n:m Beziehung zwischen Nutzer und Buch (über die Entität Ausleihe): Ein Nutzer kann mehrere Bücher ausleihen, und ein Buch kann von mehreren Nutzern ausgeliehen werden.

