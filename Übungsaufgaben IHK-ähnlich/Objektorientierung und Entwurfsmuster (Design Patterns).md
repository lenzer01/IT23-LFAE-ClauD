# Objektorientierung und Entwurfsmuster (Design Patterns) (25 Punkte)

**Ausgangssituation:** Die _SmartHome Solutions GmbH_ entwickelt eine zentrale Heizungssteuerung. Das Kernstück der Software ist das Objekt `Thermostat`, welches sekündlich die aktuelle Raumtemperatur misst. Diese Temperatur soll live an verschiedenen Stellen im Haus angezeigt werden: auf einem `WandDisplay` im Flur sowie in einer `SmartphoneApp`.

Damit die Software wartbar und leicht erweiterbar bleibt (falls später z. B. noch eine Web-Anzeige dazukommt), hat der Software-Architekt entschieden, dass sich das `Thermostat` nicht aktiv um die Anzeigen kümmern darf. Stattdessen soll das **Observer-Pattern (Beobachter-Muster)** angewendet werden, bei dem sich die Anzeigen am Thermostat registrieren und bei Änderungen automatisch benachrichtigt werden.

**Aufgaben:**

**a)** Entwurfsmuster lassen sich in drei grundlegende Kategorien unterteilen. Nennen Sie die Kategorie, zu der das _Observer-Pattern_ gehört, und nennen Sie zusätzlich **zwei** weitere Kategorien inklusive jeweils einem beispielhaften Entwurfsmuster. _(6 Punkte)_

**b)** Erläutern Sie anhand der Ausgangssituation, wie das Observer-Pattern technisch funktioniert und warum es hier genau die richtige Wahl ist. _(4 Punkte)_

**c)** Sie sollen die Vorgabe des Architekten in einem UML-Klassendiagramm modellieren. Folgende Struktur ist vorgegeben:

- Es gibt die Interfaces `ObservedSubject` (mit den Methoden `addObserver`, `removeObserver`, `notifyObservers`) und `Observer` (mit der Methode `update`).
- Die Klasse `Thermostat` implementiert das Subjekt. Sie besitzt eine interne Liste für die registrierten Observer sowie die private Eigenschaft `temperatur` (inkl. passender get- und set-Methoden).
- Die Klassen `WandDisplay` und `SmartphoneApp` implementieren das Observer-Interface und besitzen jeweils eine Methode `display()`, um die Temperatur grafisch auszugeben.

Erstellen Sie das entsprechende UML-Klassendiagramm. Achten Sie auf die korrekten Realisierungsbeziehungen (Pfeile für Interfaces) und gerichtete Assoziationen. _(11 Punkte)_

**d)** Wenn sich die Temperatur ändert, wird intern die Methode `notifyObservers()` aufgerufen. Implementieren Sie die Methode `notifyObservers()` der Klasse `Thermostat` in Pseudocode oder in einer Ihnen bekannten Programmiersprache (z. B. Java oder C#). _(4 Punkte)_

--------------------------------------------------------------------------------

## Musterlösung und Bewertungshinweise (Aufgabe 2)

**a) Kategorien der Entwurfsmuster (6 Punkte)** _Je 1 Punkt für die Kategorie und je 1 Punkt für das Beispiel._

- Das Observer-Pattern ist ein **Verhaltensmuster**.
- Weitere Kategorie 1: **Erzeugungsmuster**. Beispiel: _Singleton-Pattern_ oder _Factory-Pattern_.
- Weitere Kategorie 2: **Strukturmuster**. Beispiel: _Facade-Pattern_.

**b) Funktionsweise Observer-Pattern (4 Punkte)**

- Das Observer-Muster definiert eine Abhängigkeitsbeziehung zwischen Objekten.
- Wenn sich der Zustand in einem Objekt ändert (hier: das Thermostat/Subjekt misst eine neue Temperatur), werden alle seine abhängigen und zuvor registrierten Objekte (hier: WandDisplay und SmartphoneApp/Observer) automatisch benachrichtigt (meist über einen Aufruf der `update`-Methode). Dadurch bleiben Thermostat und Anzeigen vollständig voneinander entkoppelt.

**c) UML-Klassendiagramm (11 Punkte)** _Punkteverteilung: 4 Punkte für die korrekte Anlage der 5 Klassen/Interfaces inkl. Eigenschaften. 3 Punkte für die korrekten Methoden. 2 Punkte für die gestrichelten Realisierungspfeile (Implementierung der Interfaces). 2 Punkte für die gerichteten Assoziationen / Aggregation (Thermostat "hat" Observer)._

```
classDiagram
    class ObservedSubject {
        <<interface>>
        +addObserver(Observer) void
        +removeObserver(Observer) void
        +notifyObservers() void
    }
    
    class Observer {
        <<interface>>
        +update() void
    }
    
    class Thermostat {
        -observers : List~Observer~
        -temperatur : Double
        +getTemperatur() Double
        +setTemperatur(temp: Double) void
        +addObserver(Observer) void
        +removeObserver(Observer) void
        +notifyObservers() void
    }
    
    class WandDisplay {
        -thermostat : ObservedSubject
        +WandDisplay(o: ObservedSubject)
        +update() void
        +display() void
    }
    
    class SmartphoneApp {
        -thermostat : ObservedSubject
        +SmartphoneApp(o: ObservedSubject)
        +update() void
        +display() void
    }
    
    ObservedSubject <|.. Thermostat : implementiert
    Observer <|.. WandDisplay : implementiert
    Observer <|.. SmartphoneApp : implementiert
    
    ObservedSubject <-- WandDisplay : kennt
    ObservedSubject <-- SmartphoneApp : kennt
    Thermostat o-- Observer : hat
```

_(Hinweis für den Prüfer: Wenn die Assoziationspfeile von Display zu Subject leicht anders aussehen, ist das zu tolerieren. Wichtig ist die Realisierung der Interfaces durch die gestrichelten Linien und leeren Pfeilspitzen__.)_

**d) Pseudocode** **notifyObservers** **(4 Punkte)** _1 Punkt Methodenkopf, 2 Punkte für die Schleife über die Liste, 1 Punkt für den korrekten Methodenaufruf_ _update()__._

```
public void notifyObservers() {
    for (Observer o : observers) {
        o.update();
    }
}
```

_(Hinweis: Eine Zählschleife_ _FOR i=0 BIS länge(observers)_ _mit_ _observers[i].update()_ _ist ebenfalls mit voller Punktzahl zu bewerten)._