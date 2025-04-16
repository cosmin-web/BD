-- Inserare masini
INSERT INTO masini (id_masina, caroserie, combustibil, tarif, disponibilitate)
VALUES ('1HGCM82633A123456', 'SUV', 'BENZINA', 1000, 1);
INSERT INTO masini (id_masina, caroserie, combustibil, tarif, disponibilitate)
VALUES ('1HGCM82633A123457', 'SPORT', 'HIBRID', 1500, 1);
INSERT INTO masini (id_masina, caroserie, combustibil, tarif, disponibilitate)
VALUES ('2HGCM82633A123458', 'TEREN', 'ELECTRIC', 2000, 1);
INSERT INTO masini (id_masina, caroserie, combustibil, tarif, disponibilitate)
VALUES ('2HGCM82633A123459', 'ORAS', 'MOTORINA', 500, 1);

-- Inserare accesorii
INSERT INTO accesorii (id_accesoriu, denumire, tarif, stoc)
VALUES (100000000001, 'BRELOC', 30, 10);
INSERT INTO accesorii (id_accesoriu, denumire, tarif, stoc)
VALUES (100000000002, 'CABLU INCARCARE', 40, 5);
INSERT INTO accesorii (id_accesoriu, denumire, tarif, stoc)
VALUES (100000000003, 'GPS', 150, 8);
INSERT INTO accesorii (id_accesoriu, denumire, tarif, stoc)
VALUES (100000000004, 'ROVINIETA ELECTRONICA', 50, 15);
INSERT INTO accesorii (id_accesoriu, denumire, tarif, stoc)
VALUES (100000000005, 'SCAUN PENTRU COPII', 500, 20);
INSERT INTO accesorii (id_accesoriu, denumire, tarif, stoc)
VALUES (100000000006, 'SUPORT PENTRU TELEFON', 1000, 12);

-- Inserare clienti
INSERT INTO clienti (id_client, serie_ci, numar_ci, nume, prenume)
VALUES (5030815226728, 'IZ', 123456, 'Popescu', 'Ion');
INSERT INTO clienti (id_client, serie_ci, numar_ci, nume, prenume)
VALUES (5030815226729, 'MZ', 654321, 'Ionescu', 'Maria');

-- Inserare inchirieri cu date mai mari decât 20.12.2024
INSERT INTO inchirieri (data_inceput, data_sfarsit, cost_total, id_client, id_masina)
VALUES (TO_DATE('2024-12-21', 'YYYY-MM-DD'), TO_DATE('2024-12-26', 'YYYY-MM-DD'), 0, 5030815226728, '1HGCM82633A123456'); -- Închiriere SUV
INSERT INTO inchirieri (data_inceput, data_sfarsit, cost_total, id_client, id_masina)
VALUES (TO_DATE('2024-12-22', 'YYYY-MM-DD'), TO_DATE('2024-12-25', 'YYYY-MM-DD'), 0, 5030815226729, '1HGCM82633A123457'); -- Închiriere SPORT

-- Inserare optiuni cu date mai mari decât 20.12.2024
INSERT INTO optiuni (id_client, data_inceput, id_masina, id_accesoriu)
VALUES (5030815226728, TO_DATE('2024-12-22', 'YYYY-MM-DD'), '1HGCM82633A123457', 100000000003); -- Adăugare GPS
INSERT INTO optiuni (id_client, data_inceput, id_masina, id_accesoriu)
VALUES (5030815226729, TO_DATE('2024-12-22', 'YYYY-MM-DD'), '1HGCM82633A123457', 100000000005); -- Adăugare SCAUN PENTRU COPII

-- Actualizare cost_total
UPDATE inchirieri
SET cost_total = (
    -- Calculul costului pentru mașină: tarif * număr de zile
    (SELECT tarif FROM masini WHERE id_masina = inchirieri.id_masina) * (inchirieri.data_sfarsit - inchirieri.data_inceput) +
    
    -- Adăugarea costului pentru accesorii (calcularea totalului pentru fiecare accesoriu)
    (SELECT NVL(SUM(tarif), 0) 
     FROM accesorii 
     WHERE id_accesoriu IN (SELECT id_accesoriu FROM optiuni WHERE id_client = inchirieri.id_client AND id_masina = inchirieri.id_masina))
)
WHERE data_inceput IS NOT NULL AND data_sfarsit IS NOT NULL;

-- Actualizare disponibilitate masini
UPDATE masini
SET disponibilitate = 0
WHERE id_masina IN (SELECT id_masina FROM inchirieri WHERE data_inceput <= SYSDATE AND data_sfarsit >= SYSDATE);

-- Actualizare stoc accesorii
UPDATE accesorii
SET stoc = stoc - 1
WHERE id_accesoriu IN (SELECT id_accesoriu FROM optiuni WHERE id_client IN (SELECT id_client FROM inchirieri WHERE data_inceput <= SYSDATE AND data_sfarsit >= SYSDATE));

-- Verificare inchirieri
SELECT id_client, id_masina, cost_total
FROM inchirieri;

-- Verificare masini (disponibilitate)
SELECT id_masina, disponibilitate
FROM masini;

-- Verificare accesorii (stoc)
SELECT id_accesoriu, denumire, stoc
FROM accesorii;
