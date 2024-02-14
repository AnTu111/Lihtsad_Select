Страны, названия которых начинаются на букву “К” (5 записей);
SELECT * FROM country WHERE NAME LIKE 'K%'; 


--Страны, получившие независимость в 19-м веке (27 записей)
SELECT Name, IndepYear from country WHERE IndepYear BETWEEN 1800 AND 1899; 

--Страны ближнего востока (Middle East) (18 записей)
SELECT Name,Region FROM country WHERE region like 'Middle East%'; 


--Европейские страны, которые образовались в 19 веке (7 записей)
SELECT Name, IndepYear, Continent from country Where(IndepYear BETWEEN 1800 and 1899) and Continent like'Europe%'; 


--Страны, в названиях которых содержат слог “ра”  (9 записей)
SELECT Name from country where Name like '%pa%'; 


--Страны, названия которых начинаются на гласную букву  (A, E, I, O, U, Y) (42 записи);
--RLIKE '^[A, E, I, O, U, Y]' - ПРИНАДЛЕЖНОСТЬ К МНОЖЕСТВУ.
SELECT Name from country WHERE Name like'A%' OR NAME lIKE 'E%' OR NAME lIKE 'I%' OR NAME lIKE 'O%'OR NAME lIKE 'U%'OR NAME lIKE 'Y%'; 
SELECT Name 
from country 
WHERE Name RLIKE '^[A, E, I, O, U, Y]';


--Страны, названия которых начинаются и заканчиваются на одну и ту же букву. (20 записей)
SELECT Name FROM country WHERE LEFT(Name,1) like RIGHT(Name,1); 


--Государства, формой правления которых является различной формы монархия (43 записи)
SELECT name FROM country where GovernmentForm like '%Monarchy%'; 


--Страны, население которых меньше 1 млн. (85 записей)
SELECT Name from country WHERE Population < 1000000; 


--Самое древнее государство (China)
SELECT Name, IndepYear from country ORDER BY IndepYear LIMIT 1; 



--Страны, год обретения независимости которыми не определен (47 записей)
SELECT Name FROM country WHERE IndepYear = 0; 

--Самое маленькое по площади государство (Holy See (Vatican City State))
SELECT Name,SurfaceArea FROM country ORDER BY SurfaceArea LIMIT 1; 

--Первую десятку наиболее населенных государств мира
SELECT Name,Population FROM country ORDER BY Population DESC LIMIT 10; 

--Первую десятку наиболее населенных государств Европы
SELECT Name,Population FROM country WHERE Continent LIKE '%Europe%' ORDER BY Population DESC LIMIT 10; 

--Cуммарное число жителей стран Европы и суммарную площадь её государств (730 074 600, 23 049 133.9)
SELECT SUM(Population) AS 'Kokku elanike_arv', SUM(SurfaceArea) AS 'Kokku pindala' FROM country WHERE Continent LIKE '%Europe%'; 


--Число стран, расположенных не в Антарктике (234 записи)
SELECT COUNT(Name) FROM country WHERE Continent NOT like '%Antarctica%'; 


--Число стран, где главой правительства является Елизавета II (Elisabeth II), суммарное число жителей этих стран.  (35 стран, 122 872 550 человек)
SELECT SUM(Population), COUNT(*) FROM country WHERE HeadOfState like 'Elisabeth II'; 

--Число стран, наибольшее и наименьшее число жителей стран Полинезии (Polynesia) (10 стран, 235 000 человек, 50 человек)
SELECT COUNT(*) as RiikideArv, MIN(Population) as MIN, MAX(Population) as MAX FROM country WHERE Region LIKE 'Polynesia'; 


