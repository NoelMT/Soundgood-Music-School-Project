--Avarage of total lessons
select extract(MONTH from datum) AS MONTH, extract(year from datum) AS year, (CAST(count(*) AS DECIMAL(4,2) )  / 12) as  Average
from lestot where extract(year from datum) = 2021 group by extract(MONTH from datum), extract(year from datum);

--Avarage of single lessons
select extract(MONTH from lesson.datum) AS MONTH, extract(year from datum) AS year, (CAST(count(*) AS DECIMAL(4,2) )  / 12) as  Average
from lesson where extract(year from datum) = 2021 group by extract(MONTH from datum), extract(year from datum);

--Avarage of group lessons
 select extract(MONTH from datum) AS MONTH, extract(year from datum) AS year, (CAST(count(*) AS DECIMAL(4,2) )  / 12) as  Average
 from group_lesson where extract(year from datum) = 2021 group by extract(MONTH from datum), extract(year from datum);

--Avarage of ensamble
select extract(MONTH from datum) AS MONTH, extract(year from datum) AS year, (CAST(count(*) AS DECIMAL(4,2) )  / 12) as  Average
from ensemble where extract(year from datum) = 2021 group by extract(MONTH from datum), extract(year from datum);






