-- 01
select dnev from dolgozo where mod(fizetes, 05) = 0;

-- 02
select dnev, belepes
from dolgozo 
where belepes > to_date('1982-01-01', 'yyyy-mm-dd');

-- 03

select dnev
from dolgozo
where substr(dnev, 2,1) = 'A';

-- 04

select dnev
from dolgozo
where length(dnev) - length(replace(dnev, 'L','')) = 2;

-- 05

select dnev, substr(dnev, length(dnev) - 2, 3)
from dolgozo;

-- 06

select dnev 
from dolgozo
where substr(dnev, length(dnev) - 1, 1) like 'T';

-- 07

select fizetes, round(sqrt(fizetes), 2) gyök, round(sqrt(fizetes)) kerekítettgyök
from dolgozo;

-- 08

SELECT belepes, trunc(sysdate - belepes), to_char(belepes, 'Month')  
FROM dolgozo WHERE dnev = 'ADAMS';

-- 09

select dnev, mod(to_char(belepes, 'dd'), 7) + 1, to_char(belepes, 'DAY')
from dolgozo
where to_char(belepes, 'DAY') like 'KEDD%';

-- 10

select d1.dnev, d1.fonoke, d2.dnev, d2.dkod
from 
  dolgozo d1
    cross join
  dolgozo d2
where 
  d1.fonoke = d2.dkod
    and
  length(d1.dnev) = length(d2.dnev);
  
-- 11
select dnev, fizetes
from dolgozo
where 
  (select also
  from fiz_kategoria
  where kategoria = 1) < fizetes
    and
  (select felso
  from fiz_kategoria
  where kategoria = 1) >= fizetes;

-- 12

