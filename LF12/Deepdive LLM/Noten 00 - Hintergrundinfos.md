# 🎓 Lehrer-Handbuch: Technische Einführung in LLMs

Zielgruppe: Anwendungsentwickler, 3. Lehrjahr (Verständnis von Arrays, Matrizen/Listen, Key-Value-Paaren vorausgesetzt).

Zeit: 5 Schulstunden (à 45 Min).

Fokus: Inference (Wie generiert das Modell Text?), nicht Training (Wie lernt es?).

---

## 🛠️ Vorbereitung & Tools

Stelle sicher, dass folgende URLs auf den Schüler-PCs funktionieren (keine Whitelist-Sperren):

1. **Tokenization:** [https://platform.openai.com/tokenizer](https://platform.openai.com/tokenizer)
    
2. **Visualisierung (Einstieg):** [https://poloclub.github.io/transformer-explainer/](https://poloclub.github.io/transformer-explainer/)
    
3. **Visualisierung (Deep Dive):** [httpseds://bbycroft.net/llm](https://bbycroft.net/llm)
    

---

## 🕒 Stunde 1: Die Sprachbarriere (Tokenization)

**Ziel:** Verstehen, dass LLMs keine Strings verarbeiten, sondern Listen von Integern.

### 0. Basis zeigen (10 min)

#### Option 1: "Das menschliche LLM" (Analoges Spiel)

_Dauer: ca. 15-20 Min_ _Ziel: Das Prinzip der "Next Token Prediction" und "Temperature" ohne Computer simulieren._

**Ablauf:*
1. **Das Setup:** Du stehst an der Tafel (du bist der Prozessor). Die Klasse ist das "Modell".
2. **Der Start:** Du schreibst ein Start-Token an die Tafel, z.B.: `Das`.
3. **Die Vorhersage:** Du fragst die Klasse: _"Welches Wort kommt als nächstes? Ruft Vorschläge rein!"_
    - Schüler rufen: "Auto", "Haus", "Wetter", "ist".
        
4. **Die Wahrscheinlichkeitsverteilung (Softmax):** Du sammelst die 3 häufigsten Nennungen und schreibst sie mit geschätzten Wahrscheinlichkeiten daneben:
    - "Haus" (50%)
    - "ist" (30%)
    - "Wetter" (20%)
        
5. **Der Sampling-Moment (Der Clou!):**
    - Frage: _"Nehmen wir immer das Wahrscheinlichste?"_ (Antwort: Nein, sonst wird es langweilig/repetitiv).    
    - **Aktion:** Du nimmst einen Würfel (oder eine Random-Number-App auf dem Handy).
    - 1-3 = "Haus", 4-5 = "ist", 6 = "Wetter".
    - Du würfelst eine 6. Das Wort ist "Wetter".    
    
6. **Loop:** Der neue Satzanfang ist `Das Wetter`. Wiederhole den Prozess für 3-4 Wörter.
    
**Der Lerneffekt (Aha-Moment):** Der Satz ergibt vielleicht Sinn, vielleicht auch nicht.
- **Fazit für die Entwickler:** "Seht ihr? Das Modell plant den Satz nicht. Es 'würfelt' nur das nächste Wort basierend auf Wahrscheinlichkeiten. Es gibt keinen Plan, kein Bewusstsein, nur Statistik."
    

---

#### Option 2: Die "Smartphone-Challenge" (Schnell & Lustig)

_Dauer: 5-10 Min_ _Ziel: Zeigen, dass sie bereits ein "dummes" LLM in der Hosentasche haben._

**Ablauf:**
1. Alle holen ihr Smartphone raus.
2. Öffnet eine Notiz-App oder WhatsApp.
3. **Aufgabe:** Tippt den Satzanfang: `"In der Ausbildung lerne ich..."`
4. Drückt danach **ausschließlich** immer auf den **mittleren Vorschlag** der Autokorrektur (das ist "Greedy Decoding" / Temperature = 0), bis 20 Wörter voll sind.
5. Drei Schüler lesen ihre Ergebnisse vor.

**Diskussion:**
- Warum kommt oft Unsinn raus? (Weil das Handy-Modell ("N-Gramm") nur 2-3 Wörter Kontext hat, GPT-4 hat 128.000 Wörter Kontext).
- Das Prinzip ist aber technisch _identisch_: Vorhersage des nächsten Wortes.

---

#### Option 3: Semantris (Interaktiv am Beamer)

_Dauer: 10 Min_ _Ziel: Das Konzept von "Embeddings" (Wort-Ähnlichkeit) spielerisch einführen._

Das Google-Experiment **Semantris** zeigt perfekt, wie KI Wörter assoziiert, ohne exakte Matches zu brauchen (Vektor-Nähe).
- **URL:** [research.google.com/semantris](https://research.google.com/semantris/) (Wähle "Arcade Mode").
- **Ablauf:** Einer spielt am Beamer (oder du), die Klasse ruft Assoationen.
- **Das Spiel:** Es steht das Wort "Kuchen" da. Man darf nicht "Kuchen" tippen, sondern muss etwas tippen, das semantisch _nah_ dran ist (z.B. "Bäcker", "süß", "Geburtstag"). Die KI erkennt den Zusammenhang über Vektoren.

---

### 1. Einstieg ins Thema Tokenisierung (10 Min)

- **Frage an die Klasse:** "Wie speichert ein Computer eigentlich einen String?" (ASCII/UTF-8).
    
- **Problem:** Ein LLM kann nicht mit ASCII arbeiten, da ASCII keine semantische Bedeutung hat ("A" ist 65, "B" ist 66 – mathematisch nah, aber bedeutungslos).
    
- **Lösung:** Wir brauchen größere Einheiten: **Tokens**.

--> [[01 - Tokens.excalidraw]]

### 2. Praxis: Tiktokenizer (20 Min)

Lass die Schüler [platform.openai.com/tokenizer](https://platform.openai.com/tokenizer) öffnen.

#### Infos Token
**Token‑ID = numerische Repräsentation eines Tokens**

|Begriff|Was das bedeutet|
|---|---|
|**Token**|Die kleinste Einheit, mit der ein Modell arbeitet (Wort, Teilwort, Satzzeichen, Leerzeichen).|
|**Token‑ID**|Ein ganzzahliger Index, der jedem Token im Vokabular zugeordnet ist.|
#### Funktionsweise

1. **Vokabular**  
    Das Modell hat ein festes Wörterbuch (z. B. 50 000 IDs). Jeder eindeutige Token bekommt eine ID.
    
2. **Tokenisierung**
    ```text
    "Hallo Welt!"
    ```
    
    → `["Hallo", " ", "Welt", "!"]`
    
3. **Mapping**  
    Jede dieser Tokens wird zu ihrer ID:
    
    ```
    ["Hallo" → 1234, " " → 5, "Welt" → 6789, "!" → 12]
    ```
    
4. **Modell‑Input**  
    Das Modell erhält die Sequenz `[1234, 5, 6789, 12]` statt des Textes.
#### Warum ist das wichtig?

- **Effizienz** – Modelle verarbeiten Zahlen schneller als Zeichenketten.
- **Reproduzierbarkeit** – Gleiche Token-ID → gleiche Berechnungsergebnisse.
- **Fehlersuche** – Man kann mit IDs prüfen, ob ein bestimmtes Wort korrekt tokenisiert wurde.

--> **Zur Website**: `tiktoken` ist ein Token‑Zähler (Tokenizer) von OpenAI, der exakt die gleiche Tokenisierung wie bei den GPT‑Modellen verwendet.  
Es wird häufig benutzt, um zu bestimmen:

1. **Wie viele Tokens ein Text hat** – wichtig für Kostenabschätzungen und Modelllimits.
2. **Welche Token‑IDs einem Text entsprechen** – nützlich beim Fine‑Tuning oder Prompt‑Engineering.

 ***Aufgabe:***
    
    1. Tippt: "The quick brown fox jumps over the lazy dog." (Ein Token pro Wort).
        
    2. Tippt: "Dampfschifffahrtsgesellschaft". (Zerfällt in Tokens, weil das Wort auf Englisch selten ist).
        
    3. Tippt: "1000" vs. "1,000" vs "one thousand".
        
    4. Tippt Code: `def main(): print("Hello")`. (Beobachtet, wie Klammern und Whitespace behandelt werden).


### 3. Theorie: Byte-Pair Encoding (BPE) (15 Min)

Erklärung für dich:

Moderne Modelle nutzen **BPE**. Das ist ein statistisches Verfahren. Es sucht die häufigsten Zeichenfolgen im Trainingsdatenbestand und macht sie zu einem Token.

- Häufig: "ing", "tion", " der ".
    
- Selten: "xyz".
    
- **Wichtig für Entwickler:** LLMs sind schlecht in Mathe, weil Tokens oft willkürlich geschnitten sind. Für das Modell ist "500" ein Token (ID 123), aber "501" ein ganz anderes Token (ID 890). Es sieht nicht die Beziehung zwischen den Zahlen.
    

---

## 🕒 Stunde 2: Embeddings (Der Vektorraum)

**Ziel:** Verstehen, wie Bedeutung in Zahlen (Floats) codiert wird.

### 1. Das Problem (10 Min)

Wir haben jetzt Token-IDs (z.B. `[452, 991, 12]`). Aber ID 452 (Apfel) hat mathematisch nichts mit ID 991 (Birne) zu tun. Wir brauchen eine Darstellung, wo ähnliche Dinge mathematisch nah beieinander liegen.

### 2. Die Lösung: Der Vektor (20 Min)

Stell dir ein Koordinatensystem vor (*zeichnen*):  --> [[02 - Vektoren.excalidraw]].

- 1 Dimension: Ein Zahlenstrahl (Gut <---> Schlecht).
    
- 2 Dimensionen: Eine Karte (Nord/Süd, Ost/West).
    
- **GPT-3:** Hat 12.288 Dimensionen.
    

##### Die Analogie für Entwickler:

Ein **Embedding** ist ein **Array von Floats** (float[]).

König = [0.9, 0.1, 0.5, ...]

Mann = [0.8, 0.1, 0.2, ...]

Wenn man diese Arrays als Vektoren im Raum betrachtet, kann man damit rechnen.
### 3. Tafelbild / Diskussion (15 Min)

Zeichne ein **2D-Koordinatensystem** an die Tafel

- Achse X: "Größe"
    
- Achse Y: "Geschwindigkeit"
    
- Lass die Schüler Tiere einordnen (Maus, Elefant, Gepard).
    
- Erkläre: "Das LLM macht das gleiche, aber mit Tausenden Eigenschaften (Dimensionen), die wir Menschen nicht benennen können."
    
#### Kosinus-Ähnlichkeit 

- Erkläre hier kurz die ****Kosinus-Ähnlichkeit (Cosine Similarity)***: Der Winkel zwischen zwei Vektoren bestimmt deren thematische Ähnlichkeit.
    Die **Kosinus-Ähnlichkeit** misst die Ähnlichkeit zweier Vektoren anhand der Ausrichtung (des Winkels) und nicht anhand der Länge (Magnitude).
    
![](https://www.temet.ch/de/publications/ai-tokenization-embedding/KosinusAehnlichkeit.svg)

- Zeigen zwei Vektoren in die exakt **gleiche Richtung** (Winkel 0°), ist der Wert **1** (maximale Ähnlichkeit).
- Stehen sie im **rechten Winkel** (90°), ist der Wert **0** (keine Ähnlichkeit/Unabhängigkeit).
- Zeigen sie in **entgegengesetzte Richtungen** (180°), ist der Wert **-1**.

#### Wie funktionieren Vektorrechnungen für Wortfindungen?

- **Formel:** $\text{König} - \text{Mann} + \text{Frau} \approx \text{Königin}$
 
Wir stellen jedes deutsche Wort als **3‑dimensionale** Vektor dar (nur ein Beispiel, echte Embeddings sind viel höherdimensional).  
Die Werte wurden *willkürlich* gewählt – sie sollen nur das Prinzip verdeutlichen.

| Wort   |  \(v_x\) | \(v_y\) | \(v_z\) |
|--------|----------|---------|---------|
| König  | 0.89     | 1.12    | -0.34   |
| Mann   | 0.45     | 0.67    | 0.11    |
| Frau   | 0.32     | 0.59    | 0.27    |
| Königin| 0.80     | 1.06    | -0.07   |

---

##### 1. Rechenvorschrift

Die klassische Wort‑Embeddings‑Gleichung lautet:

$\mathbf{König} \;-\; \mathbf{Mann}\;+\;\mathbf{Frau}\;\approx\;\mathbf{Königin}$

Das bedeutet:  

* Subtrahiere den Vektor des „Mannes“ von dem des „Königs“.  
* Addiere anschließend den Vektor der „Frau“.  
* Das Ergebnis sollte nahe am Vektor der „Königin“ liegen.

---

##### 2. Schritt‑für‑Schritt‑Berechnung

1. **Differenz König – Mann**

$$\begin{aligned}
\mathbf{König} - \mathbf{Mann} &= 
(0.89-0.45,\; 1.12-0.67,\; -0.34-0.11)\\
&= (0.44,\; 0.45,\; -0.45)
\end{aligned}$$

2. **Addiere Frau**

$$\begin{aligned}
(\mathbf{König}-\mathbf{Mann}) + \mathbf{Frau} &=
(0.44+0.32,\; 0.45+0.59,\; -0.45+0.27)\\
&= (0.76,\; 1.04,\; -0.18)
\end{aligned}$$

3. **Vergleich mit Königin**

Der berechnete Vektor ist **(0.76, 1.04, -0.18)**.  
Die „Königin“ hat den Vektor **(0.80, 1.06, -0.07)**.

---

##### 3. Abstand (Euclidischer Norm)

$$\begin{aligned}
d &= \sqrt{(0.76-0.80)^2 + (1.04-1.06)^2 + (-0.18+0.07)^2}\\
&= \sqrt{(-0.04)^2 + (-0.02)^2 + (-0.11)^2}\\
&\approx \sqrt{0.0016 + 0.0004 + 0.0121}\\
&\approx \sqrt{0.0141}\;\approx\;0.119
\end{aligned}$$

Der Abstand ist sehr klein – das zeigt, dass die Gleichung **nahezu exakt** erfüllt ist.



---

## 🕒 Stunde 3: Der Transformer & Attention (Das Gehirn)

**Ziel:** Das "Self-Attention"-Konzept verstehen. Wie versteht das Modell Kontext?

### 1. Einführung Attention (15 Min)

Satz: _"Die Bank war geschlossen, also hob er kein Geld ab."_ vs. _"Die Bank war frisch gestrichen, also setzte er sich nicht."_

- Woher weiß der Computer, was "Bank" bedeutet?
    
- **Self-Attention:** Jedes Wort "schaut" alle anderen Wörter im Satz an und fragt: "Wie wichtig bist du für mich?"
    Hier entscheidet der **Kontext**, der durch **Self-Attention** analysiert wird. Das Wort "Bank" "fragt" die umliegenden Wörter nach ihrer Bedeutung für sich selbst:

	- Im ersten Satz richtet "Bank" seine Aufmerksamkeit stark auf die Wörter **"Geld"** und **"abheben"**. Diese Verbindung signalisiert dem Computer: Hier ist das **Finanzinstitut** gemeint.
	- Im zweiten Satz liegt der Fokus der Aufmerksamkeit auf **"gestrichen"** und **"setzte"**. Diese Wörter verschieben die Bedeutung eindeutig hin zur **Sitzgelegenheit** (Parkbank).
	
	Ohne diesen Mechanismus wäre der Vektor für "Bank" nur ein statischer Durchschnitt aller möglichen Bedeutungen. Self-Attention passt die Bedeutung dynamisch an den aktuellen Satz an.

### 2. Die Q / K / V Analogie (Wichtig!) (15 Min)

Erkläre das Prinzip wie eine Datenbank-Abfrage (SQL), das verstehen Entwickler sofort:

- **Query (Q):** Was suche ich? (Mein aktuelles Token).
    
- **Key (K):** Was biete ich an? (Schlagworte aller anderen Tokens).
    
- **Value (V):** Was ist mein Inhalt? (Die eigentliche Information).
    

Die Attention Score berechnet sich aus dem Match von $Q$ und $K$. Wenn sie passen, wird viel vom Inhalt $V$ übernommen.

$$Attention(Q, K, V) = \text{softmax}(\frac{QK^T}{\sqrt{d_k}})V$$

(Schreibe die Formel an die Tafel, um Kompetenz zu zeigen, aber sag dazu: "Im Grunde ist das nur ein Skalarprodukt – also eine Ähnlichkeitsmessung.")
### So funktioniert der Attention‑Score

1. **Vergleichen**  
    Für jedes andere Token wird das Skalarprodukt `Q · Kᵀ` berechnet – das ist ein Maß dafür, wie gut Q und K übereinstimmen (ähnlich einer LIKE‑Abfrage in SQL).
    
2. **Normieren**  
    Das Ergebnis wird durch `√d_k` geteilt, damit die Werte nicht zu groß werden.
    
3. **Softmax**  
    Die normalisierten Scores werden mit Softmax transformiert → eine Wahrscheinlichkeitsverteilung (Summe = 1). Tokens, die „ähnlicher“ sind, bekommen höhere Gewichte.
    
4. **Gewichteten Inhalt holen**  
    Diese Gewichte multiplizieren wir dann mit den `V`‑Werten:

*Das bedeutet, der Inhalt des Tokens wird proportional zu seiner Ähnlichkeit zum Query übernommen.*

#### Detaillierte Erklärung der Q‑K‑V‑Analogie

##### 1️⃣ **Query (Q)** – *Was suche ich?*
- In einer Datenbankabfrage ist das die `SELECT`‑Anweisung oder ein Suchkriterium (`WHERE`).  
- Im Kontext von Sprachmodellen ist `Q` der aktuelle Token bzw. die Frage, die beantwortet werden soll.

##### 2️⃣ **Key (K)** – *Was biete ich an?*
- In SQL entspricht das dem Index oder einer Spalte, anhand derer ein Datensatz gefunden wird (`WHERE column = value`).  
- Für das Modell sind Keys alle möglichen Tokens im Vokabular. Jeder Key repräsentiert die „Merkmale“ eines Tokens.

##### 3️⃣ **Value (V)** – *Was ist mein Inhalt?*
- In Datenbanken wäre das der eigentliche Datensatz, den man zurückgeben möchte (`SELECT column1, column2`).  
- Für das Modell sind Values die eingebetteten Repräsentationen jedes Tokens. Sie enthalten die semantische Information.

##### 4️⃣ **Attention‑Berechnung** – *Wie verbindet man sie?*
1. **Dot‑Product Q·Kᵀ**  
   - Misst, wie gut der Query zu jedem Key passt (ähnlich einer Übereinstimmung zwischen Suchkriterium und Index).  
2. **Skalieren & Softmax**  
   - Normalisiert die Scores zu Wahrscheinlichkeiten – gleichbedeutend mit `ORDER BY score DESC` in SQL.  
3. **Gewichtetes Summe der Values**  
   - Multipliziert jeden Value mit seiner Gewichtung (Wahrscheinlichkeit) und summiert sie – analog zu `SELECT … FROM table WHERE …`.  

##### 5️⃣ **Ergebnis** – *Was kommt raus?*
- Ein Vektor, der die relevanten Informationen aus allen Tokens zusammenfasst, genau wie ein SQL‑Resultat eine Zeile mit den gewünschten Feldern liefert.

### 3. Visualisierung: Transformer Explainer (15 Min)

#### MLP = Multilayer Perceptron

Ein einfacher, vollständig verbundener **neuronaler Netzwerk‑Typ**:

1. **Input Layer** – nimmt die Eingabe (z. B. Vektor aus Tokens)
2. **Hidden Layers** – mehrere Schichten mit Gewichtsmatrizen + Aktivierungsfunktion (häufig ReLU oder GELU)
3. **Output Layer** – gibt das Ergebnis zurück (z. B. Wahrscheinlichkeiten für die nächste Token‑Klasse)

Formel einer einzelnen Schicht:

$$h = \sigma(Wx + b)$$

| Symbol       | Bedeutung                                                      |
| ------------ | -------------------------------------------------------------- |
| **(x)**      | Eingabe‑Vektor (z. B. der Ausgabe einer vorherigen Schicht)    |
| **(W)**      | Gewichtsmatrix – lineares Mapping von (x) in den nächsten Raum |
| **(b)**      | Bias‑Vektor – verschiebt die Aktivierung nach oben oder unten  |
| **(Wx + b)** | Lineare Transformation (Affine‑Transformation)                 |
| **(\sigma)** | Nichtlineare Aktivierungsfunktion (typisch ReLU, GELU, tanh…)  |
| **(h)**      | Ausgabe‑Vektor dieser Schicht                                  |
#### Beispiel ReLU
**Formel:**
$$\text{ReLU}(x) = \max(0,, x)$$

##### Warum nichtlinear?

- Für negative Werte liefert ReLU immer **0** → keine lineare Beziehung mehr.
- Für positive Werte ist die Ableitung konstant 1, also linear, aber die Funktion insgesamt ist Stückweise definiert – das macht sie nichtlinear.

##### Vorteile

|Merkmal|Erklärung|
|---|---|
|**Schnell**|Nur ein Vergleich + Max‑Operation.|
|**Sparse Aktivierung**|Viele Neuronen bleiben 0 (sparse), reduziert Rechenlast.|
|**Kein Vanishing Gradient**|Ableitung ist 1 für (x>0); verhindert, dass Gradienten verschwindet.|

##### Nachteile

- **Dying‑ReLU**: Wenn ein Neuron in einem Netzwerk dauerhaft negative Eingaben bekommt, lernt es nie mehr (Ableitung = 0).
- Keine Negative Werte → Verlust von Information bei negativen Aktivierungen.

### Schritt‑für‑Schritt

1. **Gewichtung**  
    (Wx) multipliziert jedes Eingabe­element mit seinem Gewicht → erzeugt ein neues Feature‑Array.
    
2. **Bias hinzufügen**  
    (Wx + b) verschiebt das Ergebnis, damit die Neuronen auch dann aktiv sein können, wenn der Input 0 ist.
    
3. **Aktivierung**  
    Sigma macht das Netzwerk nicht linear. Ohne diese Funktion wäre das MLP nur eine lineare Regression. ReLU z.B. setzt negative Werte auf 0 und lässt positive unverändert:   
$$\text{ReLU}(z)=\max(0,z)$$
    
4. **Output**  
    Der Vektor (h) wird an die nächste Schicht weitergegeben oder als endgültiges Ergebnis zurückgegeben (je nach Netzwerkarchitektur).
    

---

#### Warum ist das wichtig?

- Das lineare Teil ((Wx + b)) kann beliebige lineare Abbildungen lernen.
- Die Aktivierung (\sigma) ermöglicht komplexe, nichtlineare Muster zu erfassen – z. B. Wort‑ähnlichkeiten in LLMs.


#### Praxis
Öffnet [poloclub.github.io/transformer-explainer](https://poloclub.github.io/transformer-explainer/).

- Lasst die Schüler dort mit dem "Temperature" Regler spielen und die "Attention Lines" (die Verbindungslinien zwischen Wörtern) beobachten.
    

---

## 🕒 Stunde 4: Deep Dive im Simulator (Praxis)

**Ziel:** Den Datenfluss durch die Layer in 3D nachvollziehen. Dies ist der Kern der Einheit.

### 1. Setup (5 Min)

Alle öffnen bbycroft.net/llm.

Modell auswählen: nano-gpt (Wichtig! Die anderen sind zu groß und stürzen im Browser ab).

### 2. Geführte Tour (10 Min)

Du projizierst dein Bild und erklärst die UI:

- **Links:** Input (Token Embeddings).
    
- **Mitte:** Die Transformer Blocks (Layer). Hier passiert die Attention und das Feed-Forward (Denken).
    
- **Rechts:** Output Probabilities (Wahrscheinlichkeiten für das nächste Token).
    

### 3. Arbeitsauftrag (60 Min)

Die Schüler sollen folgende Fragen beantworten (erstelle hieraus ein Arbeitsblatt):

1. **Input:** Gib die Buchstaben `A B C` ein.
    
2. **Embedding:** Klicke auf den ersten Block ganz unten. Wie wird aus dem Buchstaben "A" ein Vektor? (Antwort: Lookup Table. Es wird einfach eine Zeile aus einer Matrix kopiert).
    
3. **Layer Norm:** Suche die grünen Blöcke. Was passiert mit den Werten? (Antwort: Sie werden normalisiert, also auf eine Standardabweichung gebracht, damit das Netz stabil rechnet).
    
4. **Softmax:** Scrolle ganz nach oben zum Ende. Klicke auf den "Softmax"-Block.
    
    - Welcher Buchstabe hat den höchsten Balken?
        
    - Verändere den Input zu `C B A`. Ändert sich der höchste Balken?
        

---

## 🕒 Stunde 5: Inference, Parameter & Halluzinationen

**Ziel:** Wie entsteht die Antwort und warum lügen KIs?

### 1. Vom Logit zum Wort (15 Min)

Das Modell gibt am Ende keine Worte aus, sondern **Logits** (rohe Zahlenwerte).

- Der **Softmax** macht daraus Wahrscheinlichkeiten (Prozentwerte, die zusammen 100% ergeben).
    
- Zeige das Beispiel:
    
    - "Der Himmel ist..."
        
    - blau (80%), grau (15%), grün (0.1%), Banane (0.001%).
        

### 2. Parameter: Temperature & Top-P (15 Min)

Diskussion für Entwickler: Wie steuere ich die API?

- **Temperature:** Teilt die Logits durch einen Faktor, bevor Softmax angewendet wird.
    
    - Hohe Temp ($>1$): Unterschiede verschwimmen -> Zufall steigt -> Kreativität (aber auch Halluzination).
        
    - Niedrige Temp ($<0.5$): Der Gewinner bekommt fast 100% -> Deterministisch -> Gut für Code/Fakten.
        

### 3. Halluzinationen (10 Min)

Warum lügt das Modell?

- **Erklärung:** Es "weiß" nichts. Es vervollständigt nur Muster. Wenn das Muster "überzeugend klingender Unsinn" wahrscheinlicher ist als "Ich weiß es nicht", wird es den Unsinn generieren.
    
- Es hat keinen Faktencheck-Mechanismus, nur einen Wahrscheinlichkeits-Mechanismus.
    

### 4. Abschluss & Ausblick (5 Min)

- Zusammenfassung: Token -> Embedding -> Attention Layers -> Softmax -> Next Token.
    
- Nächster Schritt für euch (Azubis): API-Integration in Python/JS.
    

---

## 💡 Didaktische Tipps für dich

- **Vermeide das Wort "Gehirn":** Sag lieber "Netzwerk" oder "Modell". Wir wollen nicht vermenschlichen.
    
- **Der "Context Window" Vergleich:** Erkläre den Arbeitsspeicher des Modells (Context Window) als RAM. Wenn der Text zu lang ist, läuft der RAM über und das Modell vergisst den Anfang.
    
- **Warum GPU?** Falls gefragt wird: Matrizenmultiplikation (was LLMs tun) ist parallelisierbar. CPUs rechnen seriell (nacheinander), GPUs parallel (gleichzeitig). Da wir 12.000 Dimensionen gleichzeitig berechnen müssen, brauchen wir GPUs.
    

### 📝 Vorlage für das Arbeitsblatt (Stunde 4)

Titel: LLM Datenfluss-Analyse

Tool: bbycroft.net/llm -> Modell: nano-gpt

<u>**Aufgaben für den Start**</u>

1. **Die Struktur:** Aus wie vielen "Blocks" (Layern) besteht das nano-gpt Modell in der Visualisierung?
    
2. **Attention:** Klicke in einem Block auf "Self-Attention". Fahre mit der Maus über die Matrix. Kannst du erkennen, dass die Pixel heller werden, wenn Tokens eine Verbindung zueinander haben? Was bedeutet das?
    
3. **Feed Forward:** Nach der Attention kommt ein "Feed Forward" Teil. In neuronalen Netzen sagt man, hier ist das "Wissen" gespeichert. Wie verändern sich die Datenpunkte hier im Vergleich zur Attention? (Beobachtung reicht)
    
4. **Output:** Warum ist der Output immer nur _ein_ Token? Wie entstehen dann ganze Sätze? (Erkläre den Loop).





