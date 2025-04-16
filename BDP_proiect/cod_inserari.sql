-- 1. Inserare validă cu stoc
INSERT INTO accesorii (denumire, tarif, stoc) 
VALUES ('GPS', 500, 20);

-- 2. Inserare cu ID specificat manual (valid)
INSERT INTO accesorii (id_accesoriu, denumire, tarif, stoc) 
VALUES (100000000010, 'BRELOC', 30, 100);

INSERT INTO accesorii (id_accesoriu, denumire, tarif, stoc) 
VALUES (100000000020, 'SCAUN PENTRU COPII', 1000, 50);

INSERT INTO accesorii (id_accesoriu, denumire, tarif, stoc) 
VALUES (100000000022, 'CABLU INCARCARE', 1000, 200);

-- 3. Inserare care încalca constrângerea `denumire` (valabil pentru denumiri nepermise)
-- Aceasta inserare va genera o eroare deoarece "LANT" nu este în lista permisă de valori
INSERT INTO accesorii (denumire, tarif, stoc) 
VALUES ('LANT', 50, 100);

-- 4. Inserare care încalcă constrângerea `tarif` (valabil pentru tarifele nepermise)
-- Aceasta inserare va genera o eroare deoarece "70" nu este în lista permisă de tarife
INSERT INTO accesorii (denumire, tarif, stoc) 
VALUES ('CABLU INCARCARE', 70, 50);

-- 5. Inserare care încalcă constrângerea `id_accesoriu` (ID-ul nu are 12 caractere)
-- EROARE: Încălcarea constrângerii id_accesoriu
INSERT INTO accesorii (id_accesoriu, denumire, tarif, stoc) 
VALUES (123, 'SUPORT PENTRU TELEFON', 50, 150);

-- Verificare date inserate
SELECT 
   TO_CHAR(id_accesoriu) AS id_accesoriu,
   denumire,
   tarif,
   stoc
FROM accesorii;



--Inserari in tabela Clienti
--1. Inserare valida - ID-ul respecta formatul, seria CI și numărul CI sunt valide
INSERT INTO clienti (id_client, serie_ci, numar_ci, nume, prenume)
VALUES ('5030815226728', 'IZ', 123456, 'Oancea', 'Cosmin');

-- 2. Inserare valida - Alt client, ID valid, seria și numărul CI valide
INSERT INTO clienti (id_client, serie_ci, numar_ci, nume, prenume)
VALUES ('5040623070063', 'MZ', 654321, 'Ionescu', 'Maria');

-- 3. Inserare invalidă - ID invalid (mai puțin de 13 cifre).
-- EROARE: Încălcarea constrângerii clienti_id_client_ck.
INSERT INTO clienti (id_client, serie_ci, numar_ci, nume, prenume)
VALUES ('12345678901', 'IZ', 123457, 'Georgescu', 'Ana');

-- 4. Inserare invalidă - Serie CI invalidă (nu este 'IZ' sau 'MZ').
-- EROARE: Încălcarea constrângerii clienti_serie_ci_ck.
INSERT INTO clienti (id_client, serie_ci, numar_ci, nume, prenume)
VALUES ('5030815226728', 'AB', 234567, 'Vasile', 'Ioana');

-- 5. Inserare invalidă - Număr CI invalid (mai mult de 6 cifre).
-- EROARE: Încălcarea constrângerii clienti_numar_ci_ck.
INSERT INTO clienti (id_client, serie_ci, numar_ci, nume, prenume)
VALUES ('5030815226728', 'MZ', 1234567, 'Marin', 'Gabriel');

-- 6. Inserare invalidă - Nume invalid (conține cifre).
-- EROARE: Încălcarea constrângerii clienti_nume_ck.
INSERT INTO clienti (id_client, serie_ci, numar_ci, nume, prenume)
VALUES ('5030815226728', 'IZ', 987654, 'Popescu3', 'Daniel');

-- 7. Inserare invalidă - Combinație duplicată de serie CI și număr CI.
-- EROARE: Încălcarea constrângerii de unicitate clienti_serie_ci_numar_ci_un.
INSERT INTO clienti (id_client, serie_ci, numar_ci, nume, prenume)
VALUES ('5040623070063', 'IZ', 123456, 'Ionescu', 'Cristian');

--8. Inserare invalidă - Primul caracter nu este unul permis.
--EROARE: Încălcarea constrângerii clienti_id_client_ck.
INSERT INTO clienti (id_client, serie_ci, numar_ci, nume, prenume)
VALUES ('3234567890123', 'IZ', 123457, 'Ionescu', 'Cristian');

-- 9. Inserare invalidă - Luna din ID nu este între 1 și 12.
-- EROARE: Încălcarea constrângerii clienti_id_client_ck.
INSERT INTO clienti (id_client, serie_ci, numar_ci, nume, prenume)
VALUES ('1254567890123', 'MZ', 234567, 'Ionescu', 'Cristian');

-- 10. Inserare invalidă - Ziua din ID nu este validă pentru luna respectivă.
-- EROARE: Încălcarea constrângerii clienti_id_client_ck.
INSERT INTO clienti (id_client, serie_ci, numar_ci, nume, prenume)
VALUES ('1234567900321', 'IZ', 345678, 'Ionescu', 'Cristian');

-- 11. Inserare invalidă - An bisect, dar ziua din februarie este mai mare de 29.
-- EROARE: Încălcarea constrângerii clienti_id_client_ck.
INSERT INTO clienti (id_client, serie_ci, numar_ci, nume, prenume)
VALUES ('1950229123456', 'MZ', 456789, 'Ionescu', 'Cristian');

-- 12. Inserare validă - An bisect, ziua din februarie este 29.
INSERT INTO clienti (id_client, serie_ci, numar_ci, nume, prenume)
VALUES ('1960229123456', 'IZ', 134121, 'Ionescu', 'Cristian');

-- 13. Inserare invalidă - Ziua 31 într-o lună care are doar 30 de zile (aprilie).
-- EROARE: Încălcarea constrângerii clienti_id_client_ck.
INSERT INTO clienti (id_client, serie_ci, numar_ci, nume, prenume)
VALUES ('1200431101234', 'MZ', 678901, 'Ionescu', 'Cristian');

-- 14. Inserare validă - Ziua 31 într-o lună care permite 31 de zile (ianuarie).
INSERT INTO clienti (id_client, serie_ci, numar_ci, nume, prenume)
VALUES ('1201013101234', 'IZ', 789012, 'Ionescu', 'Cristian');

-- 15. Inserare invalidă - ID-ul conține un caracter nenumeric.
-- EROARE: Încălcarea constrângerii clienti_id_client_ck.
INSERT INTO clienti (id_client, serie_ci, numar_ci, nume, prenume)
VALUES ('123A567890123', 'MZ', 890123, 'Ionescu', 'Cristian');

SELECT 
   TO_CHAR(id_client) AS id_client,
   serie_ci,
   numar_ci,
   nume,
   prenume
FROM clienti;


--Inserari in tabela Contacte
--1. Inserare validă - toate câmpurile respectă constrângerile.
INSERT INTO contacte (strada, oras, telefon, email, id_client)
VALUES ('Strada Lalelelor', 'Bucuresti', '0723456789', 'cosminOancea@email.com', '5030815226728');

-- 2. Inserare invalidă - `oras` conține caractere speciale.
-- EROARE: Încălcarea constrângerii contacte_oras_ck.
INSERT INTO contacte (strada, oras, telefon, email, id_client)
VALUES ('Strada Teiului', 'București#', '0723456790', 'cosminOancea@email.com', '5030815226728');

-- 3. Inserare invalidă - `telefon` nu începe cu `07`.
-- EROARE: Încălcarea constrângerii contacte_telefon_ck.
INSERT INTO contacte (strada, oras, telefon, email, id_client)
VALUES ('Strada Salcâmului', 'Cluj-Napoca', '0823456789', 'cosminOancea@email.com', '5030815226728');

-- 4. Inserare invalidă - `telefon` nu are exact 10 cifre.
-- EROARE: Încălcarea constrângerii contacte_telefon_ck.
INSERT INTO contacte (strada, oras, telefon, email, id_client)
VALUES ('Strada Magnoliei', 'Timisoara', '07234', 'cosminOancea@email.com', '5030815226728');

-- 5. Inserare invalidă - `email` nu are format valid.
-- EROARE: Încălcarea constrângerii contacte_email_ck.
INSERT INTO contacte (strada, oras, telefon, email, id_client)
VALUES ('Strada Panselutelor', 'Iasi', '0723456791', 'invalidemail.com', '5030815226728');


-- 6. Inserare invalidă - `id_client` inexistent în tabela `clienti`.
-- EROARE: Încălcarea constrângerii contacte_clienti_fk.
INSERT INTO contacte (strada, oras, telefon, email, id_client)
VALUES ('Strada Fictiva', 'Brasov', '0723456793', 'cosminOancea1@email.com', '0000000000000');

-- 7. Inserare invalidă - `oras` cu caractere incorecte.
-- EROARE: Încălcarea constrângerii contacte_oras_ck.
INSERT INTO contacte (strada, oras, telefon, email, id_client)
VALUES ('Strada Corecta', 'Or@ș-Test', '0723456794', 'cosminOancea2@email.com', '5030815226728');

-- 8. Inserare invalidă - `telefon` duplicat.
-- EROARE: Încălcarea constrângerii contacte_telefon_un.
INSERT INTO contacte (strada, oras, telefon, email, id_client)
VALUES ('Strada Dublet', 'Bucuresti', '0723456789', 'cosminOancea4@email.com', '5030815226729');

-- 9. Inserare invalidă - `email` duplicat.
-- EROARE: Încălcarea constrângerii contacte_email_un.
INSERT INTO contacte (strada, oras, telefon, email, id_client)
VALUES ('Strada Dublet Email', 'Bucuresti', '0723456795', 'cosminOancea@email.com', '5030815226729');

SELECT 
   strada, 
   oras, 
   telefon, 
   email, 
   id_client
FROM contacte;


-- 1. Inserare validă - toate câmpurile respectă constrângerile
INSERT INTO masini (id_masina, caroserie, combustibil, tarif, disponibilitate)
VALUES ('1HGCM82633A123456', 'SUV', 'BENZINA', 1500, 1); -- Disponibilă

INSERT INTO masini (id_masina, caroserie, combustibil, tarif, disponibilitate)
VALUES ('1HGCM82633A123459', 'SPORT', 'BENZINA', 2000, 1); -- Disponibilă

-- 2. Inserare invalidă - `id_masina` are un caracter invalid ('I').
-- EROARE: Încălcarea constrângerii masini_id_masina_ck
INSERT INTO masini (id_masina, caroserie, combustibil, tarif, disponibilitate)
VALUES ('1HGCM826I3A123456', 'ORAS', 'HIBRID', 1000, 1); -- Disponibilă

-- 3. Inserare invalidă - `id_masina` mai puțin de 17 caractere
-- EROARE: Încălcarea constrângerii masini_id_masina_ck
INSERT INTO masini (id_masina, caroserie, combustibil, tarif, disponibilitate)
VALUES ('1HGCM82633A12345', 'SPORT', 'ELECTRIC', 2000, 0); -- Ocupată

-- 4. Inserare invalidă - `caroserie` are o valoare neacceptată
-- EROARE: Încălcarea constrângerii masini_caroserie_ck
INSERT INTO masini (id_masina, caroserie, combustibil, tarif, disponibilitate)
VALUES ('1HGCM82633A123457', 'LUX', 'BENZINA', 500, 1); -- Disponibilă

-- 5. Inserare invalidă - `combustibil` are o valoare neacceptată
-- EROARE: Încălcarea constrângerii masini_combustibil_ck
INSERT INTO masini (id_masina, caroserie, combustibil, tarif, disponibilitate)
VALUES ('1HGCM82633A123458', 'SUV', 'DIESEL', 1500, 1); -- Disponibilă

-- 6. Inserare invalidă - `tarif` nu este una dintre valorile permise
-- EROARE: Încălcarea constrângerii masini_tarif_ck
INSERT INTO masini (id_masina, caroserie, combustibil, tarif, disponibilitate)
VALUES ('1HGCM82633A123459', 'TEREN', 'BENZINA', 1200, 0); -- Ocupată

-- 7. Inserare invalidă - `disponibilitate` este în afara intervalului (valori permise doar 1 sau 0)
-- EROARE: Încălcarea constrângerii masini_disponibilitate_ck
INSERT INTO masini (id_masina, caroserie, combustibil, tarif, disponibilitate)
VALUES ('1HGCM82633A123460', 'ORAS', 'HIBRID', 1000, 2); -- Eroare disponibilitate

-- 8. Inserare invalidă - `id_masina` duplicat
-- EROARE: Încălcarea constrângerii masini_pk
INSERT INTO masini (id_masina, caroserie, combustibil, tarif, disponibilitate)
VALUES ('1HGCM82633A123456', 'ORAS', 'BENZINA', 1000, 1); -- Disponibilă

-- Verificare date inserate
SELECT 
   id_masina, 
   caroserie, 
   combustibil, 
   tarif, 
   disponibilitate
FROM masini;



--Inserare in tabela Inchirieri
--1. Inserare validă - toate câmpurile respectă constrângerile.
INSERT INTO inchirieri (data_inceput, data_sfarsit, cost_total, id_client, id_masina)
VALUES (TO_DATE('2024-12-10', 'YYYY-MM-DD'), TO_DATE('2024-12-20', 'YYYY-MM-DD'), 5000, '5030815226728', '1HGCM82633A123456');

INSERT INTO inchirieri (data_inceput, data_sfarsit, cost_total, id_client, id_masina)
VALUES (TO_DATE('2024-12-10', 'YYYY-MM-DD'), TO_DATE('2024-12-20', 'YYYY-MM-DD'), 5000, '5040623070063', '1HGCM82633A123459');

INSERT INTO inchirieri (data_inceput, data_sfarsit, cost_total, id_client, id_masina)
VALUES (TO_DATE('2024-12-11', 'YYYY-MM-DD'), TO_DATE('2024-12-20', 'YYYY-MM-DD'), 5000, '5030815226728', '1HGCM82633A123456');

-- 2. Inserare invalidă - `data_inceput` este mai mare decât `data_sfarsit`.
-- EROARE: Încălcarea constrângerii inchirieri_data_sfarsit_ck.
INSERT INTO inchirieri (data_inceput, data_sfarsit, cost_total, id_client, id_masina)
VALUES (TO_DATE('2024-12-20', 'YYYY-MM-DD'), TO_DATE('2024-12-10', 'YYYY-MM-DD'), 3000, '1234567890123', '1HGCM82633A123456');

-- 3. Inserare invalidă - `id_client` nu există în tabela `clienti`.
-- EROARE: Încălcarea constrângerii inchirieri_clienti_fk.
INSERT INTO inchirieri (data_inceput, data_sfarsit, cost_total, id_client, id_masina)
VALUES (TO_DATE('2024-12-15', 'YYYY-MM-DD'), TO_DATE('2024-12-25', 'YYYY-MM-DD'), 7000, '9999999999999', '1HGCM82633A123456');

-- 4. Inserare invalidă - `id_masina` nu există în tabela `masini`.
-- EROARE: Încălcarea constrângerii inchirieri_masini_fk.
INSERT INTO inchirieri (data_inceput, data_sfarsit, cost_total, id_client, id_masina)
VALUES (TO_DATE('2024-12-18', 'YYYY-MM-DD'), TO_DATE('2024-12-28', 'YYYY-MM-DD'), 6000, '5030815226728', '1INVALIDMASINAID');

-- 5. Inserare invalidă - cheia primară duplicată.
-- EROARE: Încălcarea constrângerii inchirieri_pk.
INSERT INTO inchirieri (data_inceput, data_sfarsit, cost_total, id_client, id_masina)
VALUES (TO_DATE('2024-12-10', 'YYYY-MM-DD'), TO_DATE('2024-12-20', 'YYYY-MM-DD'), 5000, '5030815226728', '1HGCM82633A123456');

-- 6. Inserare validă - perioadă diferită pentru același client și aceeași mașină.
INSERT INTO inchirieri (data_inceput, data_sfarsit, cost_total, id_client, id_masina)
VALUES (TO_DATE('2024-12-21', 'YYYY-MM-DD'), TO_DATE('2024-12-30', 'YYYY-MM-DD'), 8000, '5030815226728', '1HGCM82633A123456');

-- 7. Inserare invalidă - `data_inceput` este mai mică decât SYSDATE (în viitor).
-- EROARE: Triggerul `inchirieri_data_trg` va bloca inserarea.
INSERT INTO inchirieri (data_inceput, data_sfarsit, cost_total, id_client, id_masina)
VALUES (TO_DATE('2024-12-05', 'YYYY-MM-DD'), TO_DATE('2024-12-15', 'YYYY-MM-DD'), 4000, '5030815226728', '1HGCM82633A123458');

SELECT 
   data_inceput, 
   data_sfarsit, 
   cost_total, 
   id_client, 
   id_masina
FROM inchirieri;


--Inserare in tabela Optiuni
--1. Inserare validă - toate câmpurile respectă constrângerile.
--Verificare autoincrement
INSERT INTO optiuni (id_client, data_inceput, id_masina, id_accesoriu)
VALUES ('5030815226728', TO_DATE('2024-12-10', 'YYYY-MM-DD'), '1HGCM82633A123456', 
       (SELECT id_accesoriu FROM accesorii WHERE denumire = 'BRELOC' AND tarif = 30));

-- 2. Inserare invalidă - `id_client` nu există în tabela `clienti`.
-- EROARE: Încălcarea constrângerii optiuni_clienti_fk.
INSERT INTO optiuni (id_client, data_inceput, id_masina, id_accesoriu)
VALUES ('9999999999999', TO_DATE('2024-12-12', 'YYYY-MM-DD'), '1HGCM82633A123456', (SELECT id_accesoriu FROM accesorii WHERE denumire = 'BRELOC' AND tarif = 30));

-- 3. Inserare invalidă - `id_accesoriu` nu există în tabela `accesorii`.
-- EROARE: Încălcarea constrângerii optiuni_accesorii_fk.
INSERT INTO optiuni (id_client, data_inceput, id_masina, id_accesoriu)
VALUES ('5030815226728', TO_DATE('2024-12-12', 'YYYY-MM-DD'), '1HGCM82633A123456', 999999999999);

-- 4. Inserare invalidă - `id_masina` nu există în tabela `inchirieri`.
-- EROARE: Încălcarea constrângerii optiuni_inchirieri_fk.
INSERT INTO optiuni (id_client, data_inceput, id_masina, id_accesoriu)
VALUES ('5030815226728', TO_DATE('2024-12-12', 'YYYY-MM-DD'), '1HGCM82633A123457', (SELECT id_accesoriu FROM accesorii WHERE denumire = 'BRELOC' AND tarif = 30));

-- 5. Inserare validă - același `id_client`, `data_inceput`, și `id_masina` dar un alt `id_accesoriu`.
INSERT INTO optiuni (id_client, data_inceput, id_masina, id_accesoriu)
VALUES ('5030815226728', TO_DATE('2024-12-10', 'YYYY-MM-DD'), '1HGCM82633A123456', 100000000009);

-- 6. Inserare invalidă - `id_client`, `data_inceput`, și `id_masina` duplicat, același `id_accesoriu`.
-- EROARE: Încălcarea constrângerii optiuni_pk.
INSERT INTO optiuni (id_client, data_inceput, id_masina, id_accesoriu)
VALUES ('5030815226728', TO_DATE('2024-12-10', 'YYYY-MM-DD'), '1HGCM82633A123456', 100000000009);

--7. Inserare validă - alt client, mașină și accesoriu diferite.
INSERT INTO optiuni (id_client, data_inceput, id_masina, id_accesoriu)
VALUES ('5040623070063', TO_DATE('2024-12-10', 'YYYY-MM-DD'), '1HGCM82633A123459', 100000000022);

SELECT 
   id_client, 
   data_inceput, 
   id_masina, 
   TO_CHAR(id_accesoriu)
FROM optiuni;


--UPDATE
--Actualizare nume client
UPDATE clienti
SET nume = 'Popescu'
WHERE id_client = '5030815226728';

ALTER TABLE contacte DISABLE CONSTRAINT CONTACTE_CLIENTI_FK;
ALTER TABLE inchirieri DISABLE CONSTRAINT INCHIRIERI_CLIENTI_FK;
ALTER TABLE optiuni DISABLE CONSTRAINT OPTIUNI_INCHIRIERI_FK;

UPDATE clienti
SET id_client = '5030815226729'
WHERE id_client = '5030815226728';

-- Actualizare ID client în tabela contacte
UPDATE contacte
SET id_client = '5030815226729'
WHERE id_client = '5030815226728';

-- Actualizare ID client în tabela inchirieri
UPDATE inchirieri
SET id_client = '5030815226729'
WHERE id_client = '5030815226728';

-- Actualizare ID client în tabela optiuni
UPDATE optiuni
SET id_client = '5030815226729'
WHERE id_client = '5030815226728';

ALTER TABLE contacte ENABLE CONSTRAINT CONTACTE_CLIENTI_FK;
ALTER TABLE inchirieri ENABLE CONSTRAINT INCHIRIERI_CLIENTI_FK;
ALTER TABLE optiuni ENABLE CONSTRAINT OPTIUNI_INCHIRIERI_FK;

-- Verifică dacă există înregistrări cu id_client vechi în tabela contacte
SELECT * FROM contacte WHERE id_client = '5030815226729';

-- Verifică dacă există înregistrări cu id_client vechi în tabela inchirieri
SELECT * FROM inchirieri WHERE id_client = '5030815226729';

-- Verifică dacă există înregistrări cu id_client vechi în tabela optiuni
SELECT * FROM optiuni WHERE id_client = '5030815226729';


-- DELETE
DELETE FROM contacte
WHERE id_client = '5030815226729';

-- Șterge înregistrările din tabela inchirieri
DELETE FROM inchirieri
WHERE id_client = '5030815226729';

-- Șterge înregistrările din tabela optiuni
DELETE FROM optiuni
WHERE id_client = '5030815226729';

-- Șterge clientul din tabela clienti
DELETE FROM clienti
WHERE id_client = '5030815226729';

-- Dezactivează constrângerile de cheie străină
ALTER TABLE inchirieri DISABLE CONSTRAINT INCHIRIERI_CLIENTI_FK;
ALTER TABLE optiuni DISABLE CONSTRAINT OPTIUNI_INCHIRIERI_FK;

-- Șterge din tabela părinte
DELETE FROM clienti WHERE id_client = '5030815226729';

-- Reactivarea constrângerilor de cheie străină
ALTER TABLE inchirieri ENABLE CONSTRAINT INCHIRIERI_CLIENTI_FK;
ALTER TABLE optiuni ENABLE CONSTRAINT OPTIUNI_INCHIRIERI_FK;

SELECT * from clienti;
SELECT * from contacte;
SELECT * from masini;
SELECT * from inchirieri;
SELECT * from optiuni;
SELECT * from accesorii;

-- Crearea vizualizarii pentru a afisa datele din mai multe tabele, evitand afisarea cheilor primare si straine neimportante
-- Crearea vizualizării pentru a include detalii complete din tabelele clientilor, inchirierilor si contactelor
SELECT 
    c.id_client AS client_id,
    c.nume || ' ' || c.prenume AS client_nume,
    m.id_masina AS masina_id,
    m.caroserie AS tip_masina,
    m.combustibil AS tip_combustibil,
    i.data_inceput AS data_inchiriere,
    i.data_sfarsit AS data_retur,
    TO_CHAR(a.id_accesoriu) AS accesoriu_id,
    a.denumire AS denumire_accesoriu
FROM 
    clienti c
JOIN 
    inchirieri i ON c.id_client = i.id_client
JOIN 
    masini m ON i.id_masina = m.id_masina
LEFT JOIN 
    optiuni o ON i.id_client = o.id_client AND i.data_inceput = o.data_inceput AND i.id_masina = o.id_masina
LEFT JOIN 
    accesorii a ON o.id_accesoriu = a.id_accesoriu
ORDER BY 
    c.id_client, i.data_inceput;





