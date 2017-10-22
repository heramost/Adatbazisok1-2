select * from szeret;

-- 1
select gyumolcs from szeret where nev like 'Micimackó';
-- 2
select gyumolcs from szeret
  minus
select gyumolcs from szeret where nev like 'Micimackó';
-- 3
select nev from szeret where gyumolcs like 'alma';
-- 4
select nev from szeret
  minus
select nev from szeret where gyumolcs like 'körte';
-- 5
select distinct nev from szeret where gyumolcs like 'dinnye'
  union
select unique nev from szeret where gyumolcs like 'körte'
  minus
(select nev from szeret where gyumolcs like 'dinnye'
  intersect
select nev from szeret where gyumolcs like 'körte');
-- 6
select distinct nev from szeret where gyumolcs like 'alma'
  intersect
select unique nev from szeret where gyumolcs like 'körte';
-- 7
select distinct nev from szeret where gyumolcs like 'alma'
  minus
select distinct nev from szeret where gyumolcs like 'körte';
-- 8
select distinct sz1.nev 
from 
    szeret sz1 
  cross join 
    szeret sz2 
where 
    sz1.nev = sz2.nev
  and
    sz1.gyumolcs <> sz2.gyumolcs;
-- 9

select distinct sz1.nev 
from 
    szeret sz1 
  cross join 
    szeret sz2 
  cross join
    szeret sz3
where 
    sz1.nev = sz2.nev
  and
    sz2.nev = sz3.nev
  and
    sz1.gyumolcs <> sz2.gyumolcs
  and
    sz2.gyumolcs <> sz3.gyumolcs
  and
    sz1.gyumolcs <> sz3.gyumolcs;
-- 10
select nev from szeret
  minus

select distinct sz1.nev 
from 
    szeret sz1 
  cross join 
    szeret sz2 
  cross join
    szeret sz3
where 
    sz1.nev = sz2.nev
  and
    sz2.nev = sz3.nev
  and
    sz1.gyumolcs <> sz2.gyumolcs
  and
    sz2.gyumolcs <> sz3.gyumolcs
  and
    sz1.gyumolcs <> sz3.gyumolcs;
-- 11
select distinct sz1.nev 
from 
    szeret sz1 
  cross join 
    szeret sz2 
where 
    sz1.nev = sz2.nev
  and
    sz1.gyumolcs <> sz2.gyumolcs
minus
select distinct sz1.nev 
from 
    szeret sz1 
  cross join 
    szeret sz2 
  cross join
    szeret sz3
where 
    sz1.nev = sz2.nev
  and
    sz2.nev = sz3.nev
  and
    sz1.gyumolcs <> sz2.gyumolcs
  and
    sz2.gyumolcs <> sz3.gyumolcs
  and
    sz1.gyumolcs <> sz3.gyumolcs;