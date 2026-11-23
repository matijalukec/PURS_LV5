# 1. Zadatak
DROP DATABASE IF EXISTS pursvjezbe;
CREATE DATABASE pursvjezbe;
USE pursvjezbe;

# 2. Zadatak
CREATE TABLE temperatura (
    id INT PRIMARY KEY AUTO_INCREMENT,
    datum DATETIME NOT NULL,
    vrijednost INT
);

INSERT INTO temperatura (datum, vrijednost) VALUES
	('2023-10-10 20:00:00', 23),
    ('2023-10-11 20:00:00', 20),
    ('2023-10-12 20:00:00', 22),
    ('2023-10-13 20:00:00', 18);

# 4. Zadatak
CREATE TABLE ovlasti (
	id INT PRIMARY KEY AUTO_INCREMENT,
    naziv VARCHAR(100) NOT NULL
);

INSERT INTO ovlasti (naziv) VALUES 
    ('Administrator'),
    ('Korisnik');

# 5. Zadatak
CREATE TABLE korisnik (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ime CHAR(50) NOT NULL,
    prezime CHAR(50) NOT NULL,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    id_ovlasti INT,
    FOREIGN KEY (id_ovlasti) REFERENCES ovlasti(id) ON UPDATE CASCADE ON DELETE SET NULL
);

INSERT INTO korisnik (ime, prezime, username, password, id_ovlasti) VALUES
	('Ladislav', 'Kovač', 'lkovac', '1234', 1),
    ('Valentina', 'Ilić', 'vilic', 'abcd', 1),
    ('Danko', 'Kovac', 'dkovac', 'ab12', 2),
    ('Katija', 'Kolar', 'kkolar', '12ab', 2);
    
# 7. Zadatak
CREATE TABLE korisnicke_temperature (
	id_korisnika INT NOT NULL,
    id_temperature INT NOT NULL,
    FOREIGN KEY (id_korisnika) REFERENCES korisnik(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_temperature) REFERENCES temperatura(id) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (id_korisnika, id_temperature)
);

INSERT INTO korisnicke_temperature (id_korisnika, id_temperature) VALUES 
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 2);

# 8. Zadatak
CREATE TABLE vlaga (
    id INT PRIMARY KEY AUTO_INCREMENT,
    datum DATE NOT NULL,
    vrijednost INT
);

INSERT INTO vlaga (datum, vrijednost) VALUES
	('2023-10-10', 30),
    ('2023-10-11', 25),
    ('2023-10-12', 25),
    ('2023-10-13', 28);

CREATE TABLE korisnicke_vlage (
	id_korisnika INT NOT NULL,
    id_vlage INT NOT NULL,
    FOREIGN KEY (id_korisnika) REFERENCES korisnik(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_vlage) REFERENCES vlaga(id) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (id_korisnika, id_vlage)
);

INSERT INTO korisnicke_vlage (id_korisnika, id_vlage) VALUES 
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 2);
    
# Zadatak 2.
SELECT * FROM temperatura;
SELECT * FROM ovlasti;
SELECT * FROM korisnik;
SELECT * FROM korisnicke_temperature;

# Zadatak 3.
SELECT ime, prezime FROM korisnik WHERE id = 2;
SELECT * FROM temperatura WHERE vrijednost >= 20;
SELECT * FROM temperatura ORDER BY id DESC LIMIT 1;
SELECT * FROM korisnik WHERE username = 'kkolar' AND password = '12ab';

# Zadatak 4.
SELECT k.ime, k.prezime, o.naziv FROM korisnik k INNER JOIN ovlasti o ON k.id_ovlasti = o.id;
SELECT k.ime, k.prezime, t.vrijednost FROM korisnik k INNER JOIN korisnicke_temperature kt ON k.id = kt.id_korisnika INNER JOIN temperatura t ON kt.id_temperature = t.id;
CREATE VIEW popis_temperatura AS SELECT k.ime, k.prezime, t.vrijednost FROM korisnik k INNER JOIN korisnicke_temperature kt ON k.id = kt.id_korisnika INNER JOIN temperatura t ON kt.id_temperature = t.id;
SELECT * FROM popis_temperatura;
