-- Tabelle: WeinArt
CREATE TABLE WeinArt (
    WA_IdKey INT PRIMARY KEY,
    WA_Weinart VARCHAR(50)
);

-- Tabelle: Artikel  
CREATE TABLE Artikel (
    Art_IdKey INT PRIMARY KEY,
    Art_Nummer VARCHAR(20),
    Art_Bezeichnung VARCHAR(100),
    Art_Preis DECIMAL(10,2),
    Art_VkEinheit VARCHAR(20),
    Art_MwStSatz DECIMAL(5,2),
    Art_Jahrgang INT,
    Art_WAIdKey INT,
    FOREIGN KEY (Art_WAIdKey) REFERENCES WeinArt(WA_IdKey)
);

-- Tabelle: Rechnung
CREATE TABLE Rechnung (
    Rg_IdKey INT PRIMARY KEY,
    Rg_KdIdKey INT,
    Rg_Nummer VARCHAR(20),
    Rg_Datum DATE,
    Rg_ZahlFristTage INT
);

-- Tabelle: RechnungPosition
CREATE TABLE RechnungPosition (
    RgPos_IdKey INT PRIMARY KEY,
    RgPos_RgIdKey INT,
    RgPos_ArtikelKey INT,
    RgPos_Nr INT,
    RgPos_Mg INT,
    RgPos_EinzelPreis DECIMAL(10,2),
    RgPos_RabattProzent DECIMAL(5,2),
    RgPos_MwStSatz DECIMAL(5,2),
    FOREIGN KEY (RgPos_RgIdKey) REFERENCES Rechnung(Rg_IdKey),
    FOREIGN KEY (RgPos_ArtikelKey) REFERENCES Artikel(Art_IdKey)
);

-- WeinArt Daten
INSERT INTO WeinArt (WA_IdKey, WA_Weinart) VALUES (1, 'Weißwein');
INSERT INTO WeinArt (WA_IdKey, WA_Weinart) VALUES (2, 'Rotwein');
INSERT INTO WeinArt (WA_IdKey, WA_Weinart) VALUES (3, 'Rosewein');
INSERT INTO WeinArt (WA_IdKey, WA_Weinart) VALUES (4, 'Schaumwein');

-- Artikel Daten
INSERT INTO Artikel (Art_IdKey, Art_Nummer, Art_Bezeichnung, Art_Preis, Art_VkEinheit, Art_MwStSatz, Art_Jahrgang, Art_WAIdKey) VALUES (8, 'GB-12555', 'Grauburgunder', 15.20, 'Flasche', 19.00, 2005, 1);
INSERT INTO Artikel (Art_IdKey, Art_Nummer, Art_Bezeichnung, Art_Preis, Art_VkEinheit, Art_MwStSatz, Art_Jahrgang, Art_WAIdKey) VALUES (9, 'GB-12556', 'Grauburgunder', 13.10, 'Flasche', 19.00, 2006, 1);
INSERT INTO Artikel (Art_IdKey, Art_Nummer, Art_Bezeichnung, Art_Preis, Art_VkEinheit, Art_MwStSatz, Art_Jahrgang, Art_WAIdKey) VALUES (10, 'GB-12558', 'Grauburgunder', 11.25, 'Flasche', 19.00, 2008, 1);
INSERT INTO Artikel (Art_IdKey, Art_Nummer, Art_Bezeichnung, Art_Preis, Art_VkEinheit, Art_MwStSatz, Art_Jahrgang, Art_WAIdKey) VALUES (11, 'WH-23', 'Weißherbst', 16.40, 'Flasche', 19.00, 2004, 1);
INSERT INTO Artikel (Art_IdKey, Art_Nummer, Art_Bezeichnung, Art_Preis, Art_VkEinheit, Art_MwStSatz, Art_Jahrgang, Art_WAIdKey) VALUES (12, 'RW-101', 'Rotwein', 15.40, 'Flasche', 19.00, 2020, 2);
INSERT INTO Artikel (Art_IdKey, Art_Nummer, Art_Bezeichnung, Art_Preis, Art_VkEinheit, Art_MwStSatz, Art_Jahrgang, Art_WAIdKey) VALUES (13, 'RW-102', 'Rotwein', 16.40, 'Flasche', 19.00, 2019, 2);
INSERT INTO Artikel (Art_IdKey, Art_Nummer, Art_Bezeichnung, Art_Preis, Art_VkEinheit, Art_MwStSatz, Art_Jahrgang, Art_WAIdKey) VALUES (14, 'WW-201', 'Weißwein', 13.80, 'Flasche', 19.00, 2021, 1);
INSERT INTO Artikel (Art_IdKey, Art_Nummer, Art_Bezeichnung, Art_Preis, Art_VkEinheit, Art_MwStSatz, Art_Jahrgang, Art_WAIdKey) VALUES (19, 'SW-301', 'Schaumwein', 17.20, 'Flasche', 19.00, 2020, 4);

-- Rechnung Daten
INSERT INTO Rechnung (Rg_IdKey, Rg_KdIdKey, Rg_Nummer, Rg_Datum, Rg_ZahlFristTage) VALUES (2223, 2, 'RG-002249', '2023-05-02', 14);
INSERT INTO Rechnung (Rg_IdKey, Rg_KdIdKey, Rg_Nummer, Rg_Datum, Rg_ZahlFristTage) VALUES (2224, 3, 'RG-002250', '2023-05-02', 14);
INSERT INTO Rechnung (Rg_IdKey, Rg_KdIdKey, Rg_Nummer, Rg_Datum, Rg_ZahlFristTage) VALUES (2225, 3, 'RG-002251', '2023-05-04', 14);
INSERT INTO Rechnung (Rg_IdKey, Rg_KdIdKey, Rg_Nummer, Rg_Datum, Rg_ZahlFristTage) VALUES (2226, 1, 'RG-002252', '2023-05-05', 7);

-- RechnungPosition Daten
INSERT INTO RechnungPosition (RgPos_IdKey, RgPos_RgIdKey, RgPos_ArtikelKey, RgPos_Nr, RgPos_Mg, RgPos_EinzelPreis, RgPos_RabattProzent, RgPos_MwStSatz) VALUES (555434, 2223, 14, 1, 4, 13.80, 0.00, 19.00);
INSERT INTO RechnungPosition (RgPos_IdKey, RgPos_RgIdKey, RgPos_ArtikelKey, RgPos_Nr, RgPos_Mg, RgPos_EinzelPreis, RgPos_RabattProzent, RgPos_MwStSatz) VALUES (555435, 2223, 19, 2, 12, 17.20, 0.00, 19.00);
INSERT INTO RechnungPosition (RgPos_IdKey, RgPos_RgIdKey, RgPos_ArtikelKey, RgPos_Nr, RgPos_Mg, RgPos_EinzelPreis, RgPos_RabattProzent, RgPos_MwStSatz) VALUES (555436, 2223, 10, 3, 6, 11.25, 5.00, 19.00);
INSERT INTO RechnungPosition (RgPos_IdKey, RgPos_RgIdKey, RgPos_ArtikelKey, RgPos_Nr, RgPos_Mg, RgPos_EinzelPreis, RgPos_RabattProzent, RgPos_MwStSatz) VALUES (555437, 2223, 11, 4, 12, 16.40, 5.00, 19.00);
INSERT INTO RechnungPosition (RgPos_IdKey, RgPos_RgIdKey, RgPos_ArtikelKey, RgPos_Nr, RgPos_Mg, RgPos_EinzelPreis, RgPos_RabattProzent, RgPos_MwStSatz) VALUES (555438, 2224, 14, 1, 8, 13.80, 0.00, 19.00);
INSERT INTO RechnungPosition (RgPos_IdKey, RgPos_RgIdKey, RgPos_ArtikelKey, RgPos_Nr, RgPos_Mg, RgPos_EinzelPreis, RgPos_RabattProzent, RgPos_MwStSatz) VALUES (555439, 2225, 10, 1, 6, 11.25, 0.00, 19.00);
INSERT INTO RechnungPosition (RgPos_IdKey, RgPos_RgIdKey, RgPos_ArtikelKey, RgPos_Nr, RgPos_Mg, RgPos_EinzelPreis, RgPos_RabattProzent, RgPos_MwStSatz) VALUES (555450, 2225, 11, 2, 6, 16.40, 0.00, 19.00);
INSERT INTO RechnungPosition (RgPos_IdKey, RgPos_RgIdKey, RgPos_ArtikelKey, RgPos_Nr, RgPos_Mg, RgPos_EinzelPreis, RgPos_RabattProzent, RgPos_MwStSatz) VALUES (555451, 2225, 12, 3, 12, 15.40, 8.00, 19.00);
INSERT INTO RechnungPosition (RgPos_IdKey, RgPos_RgIdKey, RgPos_ArtikelKey, RgPos_Nr, RgPos_Mg, RgPos_EinzelPreis, RgPos_RabattProzent, RgPos_MwStSatz) VALUES (555452, 2225, 13, 4, 6, 16.40, 0.00, 19.00);
INSERT INTO RechnungPosition (RgPos_IdKey, RgPos_RgIdKey, RgPos_ArtikelKey, RgPos_Nr, RgPos_Mg, RgPos_EinzelPreis, RgPos_RabattProzent, RgPos_MwStSatz) VALUES (555453, 2226, 19, 1, 6, 17.20, 0.00, 19.00);