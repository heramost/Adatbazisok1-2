/*************************************************/
/**********       Egyéb objektumok       *********/
/**********  (DBA_SYNONYMS, DBA_VIEWS,   *********/
/********** DBA_SEQUENCES, DBA_DB_LINKS) *********/   
/*************************************************/

---=== 1. feladat ===---
/*
Adjuk ki az alábbi utasítást (ARAMIS adatbázisban)
  SELECT * FROM sz1;
majd derítsük ki, hogy kinek melyik tábláját kérdeztük le. 
(Ha esetleg nézettel találkozunk, azt is fejtsük ki, hogy az mit kérdez le.)
*/

SELECT owner, object_name, object_type
FROM dba_objects
WHERE object_name = 'SZ1';
--Kiderítettük, hogy SZ1 egy synonym

SELECT table_name
FROM dba_synonyms
WHERE synonym_name = 'SZ1';
--Kiderítettük, hogy V1-re mutat

SELECT text
FROM dba_views
WHERE view_name = 'V1';

---=== 2. feladat ===---
/*
Hozzunk létre egy szekvenciát, amelyik az osztály azonosítókat fogja generálni
a számunkra. Minden osztály azonosító a 10-nek többszöröse legyen.
Vigyünk fel 3 új osztályt és osztályonként minimum 3 dolgozót a táblákba. 
Az osztály azonosítókat a szekvencia segítségével állítsuk elõ, és ezt tegyük
be a táblába. (Vagyis ne kézzel írjuk be a 10, 20, 30 ... stb. azonosítót.)
A felvitel után módosítsuk a 10-es osztály azonosítóját a következõ érvényes (generált)
osztály azonosítóra. (Itt is a szekvencia segítségével adjuk meg, hogy mi lesz a 
következõ azonosító.) A 10-es osztály dolgozóinak az osztályazonosító ertékét is 
módosítsuk az új értékre.
*/

CREATE SEQUENCE class_id_seq
    START WITH   50
    INCREMENT BY 10
    NOCACHE
    NOCYCLE;
    
CREATE TABLE husi_osztaly AS SELECT * FROM nikovits.osztaly;
CREATE TABLE husi_dolgozo AS SELECT * FROM nikovits.dolgozo;

BEGIN
    FOR i IN 1..3 LOOP
        INSERT INTO husi_osztaly
        (oazon)
        VALUES
        (class_id_seq.nextval);
    END LOOP;
    
    UPDATE husi_osztaly
    SET oazon = class_id_seq.nextval
    WHERE oazon = 10;
    
    UPDATE husi_dolgozo
    SET oazon = class_id_seq.currval
    WHERE oazon = 10;
END;
/

drop sequence class_id_seq;
drop table husi_osztaly;
drop table husi_dolgozo;

---=== 3. feladat ===---
/*
Hozzunk létre adatbázis-kapcsolót (database link) a GRID97 adatbázisban,
amelyik a másik (ARAMIS) adatbázisra mutat. 
CREATE DATABASE LINK aramis CONNECT TO felhasznalo IDENTIFIED BY jelszo
USING 'aramis';
Ennek segítségével adjuk meg a következõ lekérdezéseket. 
A lekérdezések alapjául szolgáló táblák:

NIKOVITS.VILAG_ORSZAGAI   GRID97 adatbázis
NIKOVITS.FOLYOK           ARAMIS adatbázis

Az országok egyedi azonosítója a TLD (Top Level Domain) oszlop.
Az ország hivatalos nyelveit vesszõkkel elválasztva a NYELV oszlop tartalmazza.
A GDP (Gross Domestic Product -> hazai bruttó össztermék) dollárban van megadva.
A folyók egyedi azonosítója a NEV oszlop.
A folyók vízhozama m3/s-ban van megadva, a vízgyûjtõ területük km2-ben.
A folyó által érintett országok azonosítóit (TLD) a forrástól a torkolatig 
(megfelelõ sorrendben vesszõkkel elválasztva) az ORSZAGOK oszlop tartalmazza.
A FORRAS_ORSZAG és TORKOLAT_ORSZAG hasonló módon a megfelelõ országok azonosítóit
tartalmazza. (Vigyázat!!! egy folyó torkolata országhatárra is eshet, pl. Duna)


- Adjuk meg azoknak az országoknak a nevét, amelyeket a Mekong nevû folyó érint.

-* Adjuk meg azoknak az országoknak a nevét, amelyeket a Mekong nevû folyó érint.
   Most az országok nevét a megfelelõ sorrendben (folyásirányban) adjuk meg.
*/

--GRID97 még mindig nem müxik :'(

/*******************************************************************/
/***              Adattárolással kapcsolatos fogalmak            ***/
/***         (DBA_TABLES, DBA_DATA_FILES, DBA_TEMP_FILES,        ***/
/*** DBA_TABLESPACES, DBA_SEGMENTS, DBA_EXTENTS, DBA_FREE_SPACE) ***/
/*******************************************************************/

---=== 1. feladat ===---
--Adjuk meg az adatbázishoz tartozó adatfile-ok (és temporális fájlok) nevét és méretét
--méret szerint csökkenõ sorrendben.

SELECT file_name, bytes
FROM dba_data_files
ORDER BY bytes DESC;