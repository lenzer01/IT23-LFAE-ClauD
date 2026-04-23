### **Ziele der Unterrichtseinheit**

1. **Entmystifizierung:** Verstehen, dass LLMs keine "Wissensdatenbanken", sondern Wahrscheinlichkeitsmaschinen sind.
    
2. **Architektur:** Die Transformer-Architektur (Encoder/Decoder, Attention) grob verstehen.
    
3. **Datenfluss:** Den Weg vom String zum Token zum Vektor und zurück zum String nachvollziehen.
    
4. **Hands-on:** Interaktive Visualisierung nutzen, um den "Denkprozess" des Modells zu sehen.
    

---

### **Benötigte Tools (Kostenlos & Online)**

Wir nutzen zwei extrem starke Visualisierungen statt Code, um die Konzepte sichtbar zu machen:

1. **Haup-Simulator:** [LLM Visualization (bbycroft.net)](https://bbycroft.net/llm) – _Das ist der "Deep Dive". Eine 3D-Ansicht eines GPT-Modells, wo man jeden Rechenschritt sieht._
    
2. **Einstieg:** [Transformer Explainer (poloclub.github.io)](https://poloclub.github.io/transformer-explainer/) – _Etwas zugänglicher für den Anfang._
    
3. **Tokenization:** [OpenAI Tiktokenizer](https://platform.openai.com/tokenizer)
    

---

### **Stundenablaufplan (5 Stunden à 45-60 Min)**

|**Stunde**|**Thema**|**Methode / Aktivität**|**Ziel**|
|---|---|---|---|
|**1. Std**|**Input & Tokenization**<br><br>  <br><br>Vom Text zur Zahl.|Vortrag + Übung am Rechner (Tiktokenizer).|Verstehen, dass das Modell keine Wörter, sondern Token (Integer) sieht. Byte-Pair Encoding (BPE).|
|**2. Std**|**Embeddings (Der Vektorraum)**<br><br>  <br><br>Bedeutung in Zahlen gießen.|Tafelbild/Präsentation + Analogie-Übung.|Konzept des hochdimensionalen Raums verstehen ($King - Man + Woman = Queen$).|
|**3. Std**|**Das Gehirn: Der Transformer**<br><br>  <br><br>Attention is all you need.|**Simulator-Phase 1** (Transformer Explainer).|Grobverständnis: Wie Wörter ihren Kontext finden (Self-Attention).|
|**4. Std**|**Deep Dive: Der Simulator**<br><br>  <br><br>Jede Schicht im Detail.|**Simulator-Phase 2** (bbycroft.net). Geführtes Arbeitsblatt.|Nachvollziehen des Datenflusses durch die Layer (Feed Forward, Softmax).|
|**5. Std**|**Inference & Sampling**<br><br>  <br><br>Wie die Antwort entsteht.|Diskussion: Temperatur, Top-P + Abschluss-Quiz.|Verstehen von Halluzinationen und Nicht-Determinismus.|

---

### **Arbeitsauftrag für den Simulator (für Stunde 3 & 4)**

Gib den Schülern folgenden Auftrag, während sie [bbycroft.net/llm](https://bbycroft.net/llm) nutzen. Wähle dort das Modell "nano-gpt" aus (es ist klein genug, um es im Browser zu berechnen).

**Aufgabe: Verfolge den Weg des Tokens**

1. Gebt oben links den Text ein: `C B A` (oder eine simple Buchstabenfolge, da nano-gpt nur Buchstaben sortieren kann).
    
2. Klickt auf die Pfeile unten, um Schritt für Schritt vorzugehen.
    
3. **Finde heraus:**
    
    - Welche ID hat der Buchstabe "A"?
        
    - Beobachte die Spalte "Token Embeddings". Wie viele Zahlen (Dimensionen) repräsentieren einen einzigen Buchstaben?
        
    - Suche den "Softmax"-Schritt ganz am Ende. Welcher Buchstabe hat die höchste Wahrscheinlichkeit (höchster Balken), als nächstes zu kommen?
        

---

### **Material: Tiefgehende Basisinformationen (für Arbeitsblätter)**

Hier sind die Texte und Formeln für deine Handouts, technisch formuliert für Entwickler.

#### **Modul 1: Tokenization (Die Eingabeschnittstelle)**

Ein LLM liest keinen Text. Es liest eine Liste von Integern.

- **Der Prozess:** Der Input-String wird in kleine Stücke zerhackt.
    
- **Strategie:** Modern LLMs nutzen **BPE (Byte Pair Encoding)**. Häufige Wortteile (z.B. "ing", "ung", "sch") werden zu einem Token zusammengefasst. Seltene Wörter werden in einzelne Buchstaben zerlegt.
    
- **Für Entwickler:** Das ist der Grund, warum LLMs schlecht im Rechnen oder Buchstabieren sind (z.B. ist das Token für "1000" eine einzelne ID, das Modell "sieht" nicht die drei Nullen).
    
- **Beispiel:**
    
    - Text: "Hallo Welt"
        
    - Tokens: `[Hallo]`, `[ Welt]` -> IDs: `[1532, 4920]` (fiktiv)
        

#### **Modul 2: Embeddings (Semantischer Vektorraum)**

Wie rechnet man mit Bedeutung? Indem man Token in Vektoren umwandelt.

- Jedes Token-ID wird in einen Vektor (eine Liste von Floats) umgewandelt. Bei GPT-3 sind das 12.288 Dimensionen pro Token.
    
- **Die Idee:** Wörter mit ähnlicher Bedeutung liegen im Vektorraum nah beieinander (haben einen geringen euklidischen Abstand oder hohe Kosinus-Ähnlichkeit).
    
- Mathematik: Der Vektor für "König" minus "Mann" plus "Frau" ergibt rechnerisch fast genau den Vektor für "Königin".
    
    $$\vec{v}_{König} - \vec{v}_{Mann} + \vec{v}_{Frau} \approx \vec{v}_{Königin}$$
    

#### **Modul 3: Die Transformer-Architektur (Der Kern)**

Der Transformer verarbeitet alle Tokens _gleichzeitig_ (parallel), nicht nacheinander (wie frühere RNNs). Das Herzstück ist der **Self-Attention Mechanism**.

**Die Kernfrage der Attention:** "Wie stark steht das Wort X in Beziehung zu allen anderen Wörtern im Satz?"

- Beispiel: Im Satz "Die Bank, auf der ich sitze" vs. "Die Bank, bei der ich Geld abhebe".
    
- Das Wort "Bank" muss durch den Kontext ("sitze" vs. "Geld") "eingefärbt" werden.
    

Die Formel (für die Nerds im Raum):

Die Attention wird berechnet über drei Vektoren: Query ($Q$), Key ($K$) und Value ($V$).

$$\text{Attention}(Q, K, V) = \text{softmax}\left(\frac{QK^T}{\sqrt{d_k}}\right)V$$

- _Vereinfacht:_ Das Modell erstellt eine "Suchanfrage" ($Q$) für jedes Wort und gleicht sie mit den "Schlagworten" ($K$) aller anderen Wörter ab. Das Ergebnis ist eine Gewichtung (Attention Score).
    

#### **Modul 4: Feed-Forward Networks (Das "Gedächtnis")**

Nach der Attention-Schicht (die den Kontext versteht) geht der Vektor durch ein klassisches neuronales Netz (MLP - Multi-Layer Perceptron).

- Hier wird das "Faktenwissen" vermutet.
    
- Es ist eine einfache Transformation: $y = \text{GELU}(xW_1 + b_1)W_2 + b_2$.
    

#### **Modul 5: Der Output (Next Token Prediction)**

Am Ende des riesigen Netzes kommt für jedes mögliche Wort im Wörterbuch (bei GPT-4 ca. 100.000) ein "Logit" (eine rohe Zahl) heraus.

1. Softmax: Wandelt die Logits in Wahrscheinlichkeiten um (Summe aller Wahrscheinlichkeiten = 100% bzw. 1.0).
    
    $$\sigma(z)_i = \frac{e^{z_i}}{\sum_{j=1}^{K} e^{z_j}}$$
    
2. **Sampling:** Das Modell wählt das nächste Wort basierend auf diesen Wahrscheinlichkeiten.
    
    - _Greedy:_ Nimm immer das Wort mit der höchsten Wahrscheinlichkeit (langweilig, repetitiv).
        
    - _Temperature:_ Ein Parameter, der die Wahrscheinlichkeitskurve flacher macht. Höhere Temperatur = mehr Zufall/Kreativität, aber auch mehr Risiko für Unsinn.
        

---

### **Checkliste für deine Vorbereitung**

1. **Testen:** Öffne [bbycroft.net/llm](https://bbycroft.net/llm) und klicke einmal das Tutorial durch, damit du weißt, wo die "Play"-Buttons sind.
    
2. **Hardware:** Stelle sicher, dass die Rechner der Azubis WebGL unterstützen (jeder moderne Browser kann das, aber manche Firmen-Proxies blockieren 3D-Inhalte).
    
3. **Python-Fallback (Optional):** Falls du noch Zeit hast oder die Azubis sehr schnell sind, lass sie ein einfaches Skript in Python schreiben, das die OpenAI API (oder eine lokale Alternative wie Ollama) aufruft, aber mit `temperature=0` vs `temperature=2.0`, um den Unterschied im Output zu sehen.
    

Möchtest du, dass ich das Arbeitsblatt zum "Simulator" noch detaillierter ausformuliere (Schritt-für-Schritt Klick-Anleitung)?