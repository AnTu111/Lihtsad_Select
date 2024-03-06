USE World;
SELECT *FROM City;
SELECT *FROM Country;
SELECT *FROM CountryLanguage;
--select laused 2 tabelise põhjal
--vigane päring
SELECT * FROM City, country;

-- õige päring
SELECT * FROM country, city 
WHERE City.ID = country.Capital;
-- INNER JOIN - ВНУТРЕННИЕ СОЕДИНЕНИЕ

-- õige päring
SELECT * FROM country 
INNER JOIN city 
ON City.ID = country.Capital;
 -- использовать псевдонимы таблиц
SELECT * FROM country AS C
INNER JOIN city AS ci
ON ci.ID = C.Capital;

--1a.--
--Покажите названия стран континента Европа, их столицы, количество населения проживающего в столице, отсортированные в порядке убывания населения
--учитывая только страны, имеющие столицу (см.ответ)

SELECT c.name AS Riik, ci.Name AS Pealinn, ci.population AS 'Pealinna Elanike arv'
FROM country AS C
INNER JOIN city AS ci
ON ci.ID = c.Capital
WHERE c.continent LIKE 'Europe'
ORDER BY ci.population desc;

--учитывая все страны (см.ответ)
--1b.--
SELECT c.name AS Riik, ci.Name AS Pealinn, ci.population AS 'Pealinna Elanike arv'
FROM country AS C
LEFT OUTER JOIN city AS ci
ON ci.ID = c.Capital
ORDER BY ci.Name;


--2.--Покажите страны, в которых название страны и название столицы совпадают (см.ответ) 
Select c.Name as Riik,ci.Name as Pealinn from  Country as c
Inner JOIN City as ci
On ci.ID=c.Capital
Where c.Name=ci.Name
;

--3--Найдите города, которые имеют одинаковые названия и находятся в одной стране
SELECT A.ID, A.Name, a.District, A.CountryCode
FROM City as A, City As B, Country as c
WHERE A.Name = B.Name AND A.ID <> B.ID 
and A.CountryCode=c.code and B.CountryCode=c.code
ORDER BY A.Name;

--4--Покажите, количество языков, на которых говорят в каждой стране (назывние страны, контитент, количество языков). Отсоритуйте результат по этому количеству
select c.Name AS Riik, c.Continent AS Con, COUNT(co.Language) AS 'Language ARV'
from Country AS c
INNER JOIN CountryLanguage AS co
ON c.Code=co.CountryCode
GROUP by c.Name, c.Continent
ORDER by COUNT(co.Language) desc;

--5--окажите, количество официальных языков в каждой стране (назывние страны, контитент, количество официальных языков). Отсоритуйте результат по этому количеству.
SELECT c.name 'Riik',
c.Continent 'Kontinent',
count(cl.Language) 'Keelte Arv' 
FROM Country c, CountryLanguage cl
WHERE c.Code=cl.CountryCode
and cl.IsOfficial = 1
group by c.name, c.continent
ORDER BY count(cl.Language) desc;

--6----Покажите, на каких языках в каком количестве разговаривает население Азии. (см.ответ) 
SELECT C.Name AS Riik, L.Language AS Keel, ci.population AS 'Inimiste arv'
FROM (Country AS C INNER JOIN City AS ci
ON C.Capital = Ci.ID)
INNER JOIN CountryLanguage AS L
ON C.Code = L.CountryCode
WHERE c.continent LIKE 'Asia' AND C.Code = L.CountryCode
ORDER BY C.Name

--7--
--Найдите для каждой страны какой процент (округлить до одного десятичного знака) от населения страны приходится на население столицы.
--учитывая только страны, имеющие столицу (см.ответ) - Aleks K
--учитывая все страны (см.ответ) - Martin
SELECT Co.Name AS Riik, Co.Population as 'Riigi Elanikut' , Ci.Name AS Pealinn ,Ci.Population AS 'Pealinna Elanike Arv', round( (cast(Ci.Population AS FLOAT)/cast(Co.Population AS float))*100,1) Protsent
FROM Country as Co
inner JOIN City as Ci
ON Ci.ID = Co.Capital
ORDER BY Co.Name;

--8--Найдите общее, ссумарное количество человек, говорящих на каждом из языков, представленных в базе данных 
Select CL.Language AS Language, sum (C.Population*Cl.Percentage) AS 'Kokku Inimest'
FROM country c
INNER JOIN CountryLanguage AS Cl
ON Cl.CountryCode=C.Code
GROUP BY Cl.Language
ORDER BY sum (C.Population*Cl.Percentage) desc

--9--Найдите общее, ссумарное количество человек для стран Европы, говорящих на каждом из языков, представленных в базе данных.
Select cl.Language AS Language, 
SUM(c.Population * cl.Percentage ) AS 'Kokku Inimest'
FROM Country AS c
INNER JOIN CountryLanguage AS cl 
ON cl.CountryCode = c.Code
WHERE c.Continent = 'Europe'
GROUP BY cl.Language
ORDER BY SUM(C.Population * cl.Percentage) desc;

--10--Вывести полную информацию обо всех странах, представленных в базе данных – название, континент, год обретения независимости, площадь, население, форма правления, столица, офицальный язык (языки)
select c.Name as Riik, 
c.Continent as Continent,
c.SurfaceArea as Pindala, 
c.IndepYear as IseseisAasta,
c.Population as ElanikudeArv, 
c.GovernmentForm as GovernmentForm,
c.HeadOfState as Headofstate, 
c.Name as Pealinn, 
cl.Language as Keel
from country as c, city as ci,countryLanguage as cl
WHERE cl.countrycode=c.code AND ci.ID = c.Capital AND cl.IsOfficial = 1
order by c.name