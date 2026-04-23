# init.sql
```sql
-- Datenbank erstellen (falls nicht durch Umgebungsvariable erstellt)
CREATE DATABASE IF NOT EXISTS bibliothek_db;
USE bibliothek_db;

-- Tabelle für Medien erstellen
CREATE TABLE IF NOT EXISTS medien (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titel VARCHAR(255) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    isbn VARCHAR(20),
    kategorie VARCHAR(100),
    verfuegbar BOOLEAN DEFAULT TRUE,
    ausgeliehen_am DATE DEFAULT NULL
);

-- Testdaten einfügen
INSERT INTO medien (titel, autor, isbn, kategorie, verfuegbar, ausgeliehen_am) VALUES
('Die Verwandlung', 'Franz Kafka', '978-3-15-009900-6', 'Roman', TRUE, NULL),
('Clean Code', 'Robert C. Martin', '978-0-13-235088-4', 'Sachbuch', FALSE, '2024-01-15'),
('Der Herr der Ringe', 'J.R.R. Tolkien', '978-3-608-93830-2', 'Fantasy', TRUE, NULL),
('Inception', 'Christopher Nolan', 'DVD-2010-001', 'Film', TRUE, NULL),
('Python Crashkurs', 'Eric Matthes', '978-3-86490-619-5', 'Sachbuch', TRUE, NULL),
('1984', 'George Orwell', '978-3-548-23410-6', 'Roman', FALSE, '2024-01-20'),
('Interstellar', 'Christopher Nolan', 'DVD-2014-001', 'Film', TRUE, NULL);

-- Benutzer für die Anwendung erstellen
CREATE USER IF NOT EXISTS 'bibliothek_user'@'%' IDENTIFIED BY 'bibliothek_2024';
GRANT ALL PRIVILEGES ON bibliothek_db.* TO 'bibliothek_user'@'%';
FLUSH PRIVILEGES;

-- Bestätigung ausgeben
SELECT 'Datenbank erfolgreich initialisiert!' AS Status;
SELECT COUNT(*) AS 'Anzahl Medien' FROM medien;
```

# dockerfile
```dockerfile
# Basis-Image: MariaDB
FROM mariadb:latest

# Metadaten
LABEL maintainer="bibliothek@stadtmuenster.de"
LABEL description="Datenbank-Container für Bibliotheksverwaltung"

# Umgebungsvariablen für MariaDB
ENV MYSQL_ROOT_PASSWORD=root_bibliothek_2024
ENV MYSQL_DATABASE=bibliothek_db
ENV MYSQL_USER=bibliothek_user
ENV MYSQL_PASSWORD=bibliothek_2024

# SQL-Initialisierungsskript kopieren
# Wird automatisch beim ersten Start ausgeführt
COPY init.sql /docker-entrypoint-initdb.d/

# Standard-Port von MariaDB
EXPOSE 3306

# Der Startbefehl ist bereits im Basis-Image definiert
# MariaDB startet automatisch und führt das init.sql aus
```

# Docker-Befehle
```bash
# 1. Docker-Netzwerk erstellen (für Kommunikation zwischen Containern)
docker network create bibliothek-netzwerk

# 2. Datenbank-Image bauen
docker build -t bibliothek-db:1.0 .

# 3. Docker-Volume für persistente Datenspeicherung erstellen
docker volume create bibliothek-daten

# 4. Datenbank-Container starten
docker run -d \
  --name bibliothek-database \
  --network bibliothek-netzwerk \
  -p 3306:3306 \
  -v bibliothek-daten:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=root_bibliothek_2024 \
  bibliothek-db:1.0

# 5. Warten, bis Datenbank initialisiert ist (ca. 10-15 Sekunden)
# Logs überprüfen:
docker logs bibliothek-database

# 6. Frontend-Container (phpMyAdmin) starten
docker run -d \
  --name bibliothek-frontend \
  --network bibliothek-netzwerk \
  -p 8080:80 \
  -e PMA_HOST=bibliothek-database \
  -e PMA_PORT=3306 \
  -e PMA_USER=bibliothek_user \
  -e PMA_PASSWORD=bibliothek_2024 \
  phpmyadmin/phpmyadmin:latest

# 7. Container überprüfen
docker ps

# 8. Logs des Frontend-Containers überprüfen
docker logs bibliothek-frontend
```

# Nützliche Befehle für Tests und Verwaltung
```bash
# Direkt in die Datenbank einloggen (für Tests)
docker exec -it bibliothek-database mysql -u bibliothek_user -pbibliothek_2024 bibliothek_db

# SQL-Abfrage direkt ausführen
docker exec -it bibliothek-database mysql -u bibliothek_user -pbibliothek_2024 bibliothek_db \
  -e "SELECT * FROM medien WHERE verfuegbar = TRUE;"

# Container stoppen
docker stop bibliothek-frontend bibliothek-database

# Container wieder starten
docker start bibliothek-database bibliothek-frontend

# Alles aufräumen (VORSICHT: Löscht alle Daten!)
docker stop bibliothek-frontend bibliothek-database
docker rm bibliothek-frontend bibliothek-database
docker volume rm bibliothek-daten
docker network rm bibliothek-netzwerk
docker rmi bibliothek-db:1.0

# Volume-Inhalt inspizieren
docker volume inspect bibliothek-daten
```


# DOKUMENTATION.md
```markdown
# Bibliotheksverwaltung - Dokumentation

## Projektbeschreibung
Containerisierte Bibliotheksverwaltung für die Stadtbibliothek Münster mit MariaDB-Datenbank und phpMyAdmin-Frontend.

## Installation und Start

### Voraussetzungen
- Docker installiert und läuft
- Ports 3306 und 8080 sind verfügbar

### Schritt-für-Schritt Anleitung

1. **Netzwerk erstellen:**
   ```bash
   docker network create bibliothek-netzwerk
   ```

2. **Image bauen:**
   ```bash
   docker build -t bibliothek-db:1.0 .
   ```

3. **Volume erstellen:**
   ```bash
   docker volume create bibliothek-daten
   ```

4. **Datenbank-Container starten:**
   ```bash
   docker run -d \
     --name bibliothek-database \
     --network bibliothek-netzwerk \
     -p 3306:3306 \
     -v bibliothek-daten:/var/lib/mysql \
     -e MYSQL_ROOT_PASSWORD=root_bibliothek_2024 \
     bibliothek-db:1.0
   ```

5. **Frontend-Container starten:**
   ```bash
   docker run -d \
     --name bibliothek-frontend \
     --network bibliothek-netzwerk \
     -p 8080:80 \
     -e PMA_HOST=bibliothek-database \
     -e PMA_PORT=3306 \
     -e PMA_USER=bibliothek_user \
     -e PMA_PASSWORD=bibliothek_2024 \
     phpmyadmin/phpmyadmin:latest
   ```

## Zugangsdaten

### phpMyAdmin (http://localhost:8080)
- **Server:** bibliothek-database
- **Benutzername:** bibliothek_user
- **Passwort:** bibliothek_2024
- **Datenbank:** bibliothek_db

### Root-Zugang (für Administration)
- **Benutzername:** root
- **Passwort:** root_bibliothek_2024

## Datenmodell

### Tabelle: medien

| Spalte | Datentyp | Beschreibung |
|--------|----------|--------------|
| id | INT | Primärschlüssel (Auto-Increment) |
| titel | VARCHAR(255) | Titel des Mediums |
| autor | VARCHAR(255) | Autor/Regisseur |
| isbn | VARCHAR(20) | ISBN oder Medien-ID |
| kategorie | VARCHAR(100) | Kategorie (Roman, Sachbuch, Film) |
| verfuegbar | BOOLEAN | Verfügbarkeitsstatus |
| ausgeliehen_am | DATE | Ausleihdatum (NULL wenn verfügbar) |

## Verwendung

### Verfügbare Medien anzeigen
```sql
SELECT * FROM medien WHERE verfuegbar = TRUE;
```

### Medium als ausgeliehen markieren
```sql
UPDATE medien 
SET verfuegbar = FALSE, ausgeliehen_am = CURDATE() 
WHERE id = 1;
```

### Medium zurückgeben
```sql
UPDATE medien 
SET verfuegbar = TRUE, ausgeliehen_am = NULL 
WHERE id = 1;
```

### Alle ausgeliehenen Medien anzeigen
```sql
SELECT titel, autor, ausgeliehen_am 
FROM medien 
WHERE verfuegbar = FALSE 
ORDER BY ausgeliehen_am DESC;
```

## Architektur

```
┌─────────────────┐
│   Host-System   │
│  localhost:8080 │
└────────┬────────┘
         │
    ┌────▼─────┐
    │ Docker   │
    │ Network  │
    └────┬─────┘
         │
    ┌────┴──────────────────────────┐
    │                               │
┌───▼──────────────┐   ┌───────────▼────────┐
│ Frontend         │   │ Datenbank          │
│ (phpMyAdmin)     │   │ (MariaDB)          │
│ Port: 8080       │───│ Port: 3306         │
└──────────────────┘   └────────┬───────────┘
                                │
                       ┌────────▼────────┐
                       │ Docker Volume   │
                       │ (Persistent)    │
                       └─────────────────┘
```

## Mögliche Erweiterungen für produktive Systeme

1. **Sicherheit:**
   - Stärkere Passwörter verwenden
   - Secrets-Management implementieren
   - HTTPS für Frontend einrichten
   - Datenbank nicht direkt exponieren (nur internes Netzwerk)

2. **Funktionalität:**
   - Ausleiher-Verwaltung (Tabelle für Benutzer)
   - Rückgabefrist und Mahnwesen
   - Reservierungssystem
   - Volltextsuche

3. **Betrieb:**
   - Automatisierte Backups
   - Health-Checks implementieren
   - Monitoring und Logging
   - Replikation für Hochverfügbarkeit

4. **Deployment:**
   - Docker Compose für einfacheres Deployment
   - Kubernetes für Orchestrierung
   - CI/CD-Pipeline

## Troubleshooting

### Container startet nicht
```bash
docker logs bibliothek-database
docker logs bibliothek-frontend
```

### Port bereits belegt
```bash
# Andere Ports verwenden
docker run -p 8081:80 ...  # Für Frontend
docker run -p 3307:3306 ... # Für Datenbank
```

### Datenbank-Verbindung fehlgeschlagen
- Prüfe, ob beide Container im gleichen Netzwerk sind
- Warte 10-15 Sekunden nach Start des Datenbank-Containers
- Überprüfe die Logs: `docker logs bibliothek-database`

### Daten gehen verloren
- Stelle sicher, dass das Volume korrekt gemountet ist
- Verwende `docker volume inspect bibliothek-daten`


# docker-compose.yml

```yaml
version: '3.8'

services:
  database:
    build: .
    container_name: bibliothek-database
    environment:
      MYSQL_ROOT_PASSWORD: root_bibliothek_2024
      MYSQL_DATABASE: bibliothek_db
      MYSQL_USER: bibliothek_user
      MYSQL_PASSWORD: bibliothek_2024
    ports:
      - "3306:3306"
    volumes:
      - bibliothek-daten:/var/lib/mysql
    networks:
      - bibliothek-netzwerk
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      timeout: 5s
      retries: 5

  frontend:
    image: phpmyadmin/phpmyadmin:latest
    container_name: bibliothek-frontend
    environment:
      PMA_HOST: database
      PMA_PORT: 3306
      PMA_USER: bibliothek_user
      PMA_PASSWORD: bibliothek_2024
    ports:
      - "8080:80"
    networks:
      - bibliothek-netzwerk
    depends_on:
      database:
        condition: service_healthy

networks:
  bibliothek-netzwerk:
    driver: bridge

volumes:
  bibliothek-daten:
    driver: local
```

# Docker Compose verwenden
```bash
# Alles starten
docker-compose up -d

# Logs anzeigen
docker-compose logs -f

# Status prüfen
docker-compose ps

# Alles stoppen
docker-compose down

# Alles inklusive Volumes löschen
docker-compose down -v
```

# Testschritte

1. **Browser öffnen:** `http://localhost:8080`
2. **Einloggen mit:**
    - Server: bibliothek-database
    - Benutzer: bibliothek_user
    - Passwort: bibliothek_2024
3. **SQL-Tab öffnen und ausführen:**
    
    ```sql
    SELECT * FROM medien WHERE verfuegbar = TRUE;
    ```
    
4. **Medium ausleihen:**
    
    ```sql
    UPDATE medien 
    SET verfuegbar = FALSE, ausgeliehen_am = CURDATE() 
    WHERE titel = 'Die Verwandlung';
    ```
    
5. **Ergebnis überprüfen:**
    
    ```sql
    SELECT * FROM medien;
    ```