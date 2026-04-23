### 4: Grundlagen künstlicher neuronaler Netze für die Handschrifterkennung

1. **Bestandteile künstlicher neuronaler Netze**:
    * Erklären Sie die grundlegenden Bestandteile eines künstlichen neuronalen Netzes.
    - Beschreiben Sie, wie diese Bestandteile in einem Netzwerk zur Erkennung von Handschriften eingesetzt werden können.
2. **Feed Forward Neural Networks**:
    
    - Erläutern Sie den grundsätzlichen Aufbau und die Funktionsweise von Feed Forward Neural Networks (FFNN).
    - Skizzieren Sie den Ablauf der Vorwärtsausbreitung (Forward Propagation) und Rückwärtsausbreitung (Backpropagation) in einem solchen Netzwerk.
    - Dies ist ein Code-Ausschnitt eines einfachen Feed Forward Neural Networks für die Handschrifterkennung:
        
        ```python
        import numpy as np
        from sklearn.datasets import load_digits
        from sklearn.model_selection import train_test_split
        
        # Lade Handschrift-Datensatz
        digits = load_digits()
        X, y = digits.data, digits.target
        
        # Teile Daten in Training und Test
        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
        
        # Definiere Feed Forward Neural Network-Modell
        class FeedForwardNN:
            def __init__(self, input_size, hidden_size, output_size, learning_rate):
                self.W1 = np.random.randn(hidden_size, input_size)
                self.b1 = np.zeros((hidden_size, 1))
                self.W2 = np.random.randn(output_size, hidden_size)
                self.b2 = np.zeros((output_size, 1))
                self.learning_rate = learning_rate
        
            def sigmoid(self, z):
                return 1 / (1 + np.exp(-z))
        
            def forward(self, X):
                self.z1 = np.dot(self.W1, X.T) + self.b1
                self.a1 = self.sigmoid(self.z1)
                self.z2 = np.dot(self.W2, self.a1) + self.b2
                self.a2 = self.sigmoid(self.z2)
                return self.a2.T
        
            def backward(self, X, y, a2):
                # Implementiere Backpropagation-Algorithmus
                pass
        
            def fit(self, X, y, epochs=10000):
                for i in range(epochs):
                    # Führe Forward- und Backpropagation durch
                    pass
        
            def predict(self, X):
                return np.argmax(self.forward(X), axis=1)
        ```
        
    - Erklären Sie die Bedeutung der einzelnen Komponenten des Modells und beschreiben Sie den Trainings- und Vorhersageprozess.
 
3. **Bewertung der Entscheidungen**:
    
    - Erörtern Sie Möglichkeiten, die Entscheidungen eines Feed Forward Neural Networks zur Handschrifterkennung zu bewerten.
    - Welche Metriken können verwendet werden, um die Leistung des Netzwerks zu beurteilen?
    - Wie können die Stärken und Schwächen des Netzwerks bei der Erkennung von Handschriften identifiziert werden?

---

## Musterlösung

1. **Bestandteile künstlicher neuronaler Netze (5 Minuten)**:
    
    - Ein künstliches neuronales Netz besteht aus Neuronen, die in Schichten angeordnet sind.
    - Jedes Neuron nimmt mehrere Eingaben (z.B. Pixel-Werte eines Handschrift-Bildes) entgegen, gewichtet diese und berechnet eine Ausgabe.
    - Die Neuronen sind über Verbindungen miteinander verknüpft, die jeweils mit einem Gewicht versehen sind. Diese Gewichte werden während des Trainings angepasst.
    - Das Netzwerk hat in der Regel eine Eingabeschicht, eine Ausgabeschicht und eine oder mehrere verdeckte Schichten.
    - Die Eingabeschicht nimmt die Pixel-Werte der Handschrift auf, die Ausgabeschicht liefert die klassifizierte Ziffer als Ergebnis.
    
2. **Grundsätzlicher Aufbau und Funktionsweise von Feed Forward Neural Networks (FFNN)**

Ein Feed Forward Neural Network (FFNN) ist eine Art von künstlichem neuronalen Netzwerk, bei dem die Informationen nur in eine Richtung fließen: von den Eingabeneuronen über die versteckten Neuronen zu den Ausgabeneuronen. Es gibt keine Schleifen oder Rückkopplungen innerhalb des Netzwerks, was es zu einem der einfachsten Typen von neuronalen Netzwerken macht.

**Komponenten eines FFNN:**
1. **Eingabeschicht (Input Layer):** Diese Schicht erhält die Eingangsdaten. Die Anzahl der Neuronen in dieser Schicht entspricht der Anzahl der Merkmale im Eingabedatensatz.
2. **Versteckte Schichten (Hidden Layers):** Diese Schichten führen Berechnungen durch, um die Daten zu transformieren. Ein Netzwerk kann mehrere versteckte Schichten haben.
3. **Ausgabeschicht (Output Layer):** Diese Schicht liefert das Endergebnis des Netzwerks. Die Anzahl der Neuronen in dieser Schicht hängt von der Art des Problems ab (z.B. 10 Neuronen für eine Klassifikation mit 10 Klassen).

### Vorwärtsausbreitung (Forward Propagation)

Bei der Vorwärtsausbreitung werden die Eingangsdaten durch das Netzwerk geleitet, um eine Vorhersage zu treffen:
1. **Berechnung der gewichteten Summe:** Für jede versteckte und Ausgabeschicht wird die gewichtete Summe berechnet: \( z = W \cdot X + b \), wobei \( W \) die Gewichte und \( b \) die Biases sind.
2. **Aktivierungsfunktion:** Auf diese Summe wird eine Aktivierungsfunktion wie Sigmoid angewendet, um nicht-lineare Beziehungen abzubilden: \( a = \text{sigmoid}(z) = \frac{1}{1 + e^{-z}} \).
3. **Weiterleitung:** Die Ausgaben einer Schicht dienen als Eingaben für die nächste.

### Rückwärtsausbreitung (Backpropagation)

Rückwärtsausbreitung ist ein Algorithmus zur Anpassung der Gewichte und Biases des Netzwerks basierend auf dem Fehler zwischen vorhergesagten und tatsächlichen Ausgaben:
1. **Fehlerberechnung:** Der Fehler wird als Differenz zwischen dem vorhergesagten Wert und dem tatsächlichen Wert berechnet.
2. **Gradientenberechnung:** Mithilfe des Gradientenabstiegs werden die Gewichte aktualisiert, indem man den Gradienten des Fehlers bezüglich jedes Gewichts berechnet.
3. **Gewichtsaktualisierung:** Die Gewichte werden angepasst: \( W := W - \eta \cdot \nabla L(W) \), wobei \( \eta \) die Lernrate und \( L(W) \) die Verlustfunktion ist.

### Code-Komponenten Erklärung

- **Initialisierung (`__init__`-Methode):** 
  - `W1`, `b1`: Die Gewichte und Biases für die erste verdeckte Schicht.
  - `W2`, `b2`: Die Gewichte und Biases für die Ausgabeschicht.
  - `learning_rate`: Bestimmt, wie stark sich das Modell bei jeder Iteration anpasst.

- **Sigmoid-Funktion (`sigmoid`-Methode):** Eine Aktivierungsfunktion zur Einführung von Nichtlinearität. *(nicht bewertet)*

- **Vorwärtsausbreitung (`forward`-Methode):**
  - Berechnet zuerst `z1` durch Multiplikation der Eingaben mit den Gewichten `W1` und Hinzufügen des Biases `b1`.
  - Berechnet dann `a1` mithilfe der Sigmoid-Funktion auf `z1`.
  - Dasselbe Verfahren erfolgt für den Übergang zur Ausgabeschicht mit `W2`, `b2`, um schließlich `a2` zu berechnen.

- **Rückwärtsausbreitung (`backward`-Methode):** 
  - Momentan nicht implementiert; hier würde man den Fehler zwischen den vorhergesagten Ergebnissen (`a2`) und den tatsächlichen Labels (`y`) berechnen und verwenden, um Gradienten zu bestimmen und Gewichte entsprechend anzupassen.

- **Training (`fit`-Methode):**
  - Würde normalerweise sowohl Vorwärts- als auch Rückwärtsausbreitungen über mehrere Epochen durchführen, um das Modell zu trainieren.

- **Vorhersagen (`predict`-Methode):**
  - Gibt für jedes Beispiel im Testdatensatz das Label mit dem höchsten Wahrscheinlichkeitswert aus (`np.argmax(a2)`).

Zusammenfassung: Diese Architektur ermöglicht es einem FFNN, Muster in Daten zu lernen, indem es iterativ seine Parameter anpasst, bis ein zufriedenstellendes Maß an Genauigkeit erreicht ist.
    

5. Zusatzaufgabe **Bewertung der Entscheidungen (5 Minuten)**:
    
    - Die Leistung des Feed Forward Neural Networks kann anhand von Metriken wie Genauigkeit, Präzision, Recall und F1-Score bewertet werden.
    - Diese Metriken geben Aufschluss darüber, wie gut das Netzwerk Handschriften klassifiziert und ob es bestimmte Ziffern besser oder schlechter erkennt.
    - Zusätzlich kann man die Entscheidungen des Netzwerks visuell inspizieren, indem man Beispiele betrachtet, bei denen es Fehler macht. So lassen sich Schwachstellen identifizieren.
    - Durch Anpassung der Hyperparameter, der Architektur oder des Trainingsverfahrens kann die Leistung des Feed Forward Neural Networks weiter verbessert werden.


---


### 1. Bestandteile künstlicher neuronaler Netze

**Kriterien:**
- Erläuterung der grundlegenden Bestandteile (Neuronen, Schichten, Gewichte)
- Anwendung dieser Bestandteile auf die Handschrifterkennung

**Punkte:** 5

### 2. Feed Forward Neural Networks (FFNN)
**Aufbau und Funktionsweise von FFNN (5 Punkte)**
   - Erklärung der Architekturkomponenten: Eingabeschicht, versteckte Schichten, Ausgabeschicht (3 Punkte)
   - Fluss der Informationen ohne Rückkopplung (2 Punkte)

2. **Vorwärtsausbreitung (Forward Propagation) (4 Punkte)**
   - Berechnung der gewichteten Summe (1 Punkt)
   - Anwendung der Aktivierungsfunktion (1 Punkt)
   - Weiterleitung zur nächsten Schicht (2 Punkte)

3. **Rückwärtsausbreitung (Backpropagation) (4 Punkte)**
   - Fehlerberechnung zwischen vorhergesagten und tatsächlichen Werten (1 Punkt)
   - Gradientenberechnung zur Anpassung der Gewichte (2 Punkte)
   - Aktualisierung der Gewichte mit Lernrate und Gradientenabstieg (1 Punkt)

4. **Erklärung des Code-Ausschnitts eines FFNN für Handschrifterkennung:**
   
   a. **Initialisierung (`__init__`-Methode) (3 Punkte)**
      - Erklärung von `W1`, `b1`, `W2`, `b2` und Lernrate

   c. **Vorwärtsausbreitung (`forward`-Methode) im Codekontext erklären:**
      - Berechnung von `z1` und `a1` in Relation zu den Gewichten und Biases sowie deren Übergang zur Ausgabeschicht, um `a2` zu berechnen (3 Punkte)

   d. **Rückwärtsausbreitung im Code (`backward`-Methode):** 
      - Hinweis, dass diese Methode noch implementiert werden muss, jedoch die Bedeutung für das Netzwerk klarstellen können (0 Punkte, da nicht implementiert)

   e. **Training (`fit`-Methode):** 
      - Verständnis, dass hier Forward- und Backpropagation durchgeführt werden sollen über mehrere Epochen zum Training des Modells; aktuell nicht implementiert im Codebeispiel aber dennoch wichtig zu erwähnen (0 Punkte aufgrund fehlender Implementierung)

   f. **Vorhersageprozess (`predict`-Methode):** 
      - Nutzung des maximalen Wahrscheinlichkeitswertes zur Klassifizierung erklären können, mit Bezug auf den Klassifikationsprozess für Handschriftenbildern anhand von FFNN-Ausgaben (`np.argmax(a2)`): 1 Punkt 

**Punkte**: 20

### 3. Bewertung der Entscheidungen

**Kriterien:**
- Verwendung geeigneter Metriken zur Leistungsbewertung
- Identifikation von Stärken und Schwächen des Netzwerks

**Punkte:** +3

**Gesamtpunkte:** 25 + 3