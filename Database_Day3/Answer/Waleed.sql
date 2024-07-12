--select * from City where City.Name like'E%';


/*1- Display all Egypt Cities */

--select  distinct City.Name as EgyptCities 
--from Country inner join City on City.CountryCode =(select Code from Country where Name = 'Egypt') ;

/*2- Display all countries that have cities with population more than 5 million.*/

--select Country.Name , City.Population from Country 
--inner join City on  Country.Code = City.CountryCode 
--where City.Population > 5000000
--order by City.Population asc;

--3- Display all countries that speak “Dutch” as a secondary language. 

--select  * 
--from Country inner join CountryLanguage
--on CountryLanguage.CountryCode = Country.Code and CountryLanguage.IsOfficial = 'False' and CountryLanguage.Language = 'Dutch' ;

--4 - Display all countries names along with their official language.

--select Country.Name ,CountryLanguage.Language as "Is offical"
--from Country inner join CountryLanguage
--on CountryCode = CountryLanguage.CountryCode and CountryLanguage.IsOfficial = 1 ;


--5- Display all cities that have the same district name.

--select distinct c1.*
--from City c1 inner join City c2 
--on c1.District = c2.District;


--6- Display African countries names along with number of cities in each country.


--select Country.Name , City.Name
--from Country inner join City on Country.Continent = 'Africa' and Country.Code = City.CountryCode
--where Country.Name = 'Egypt'


--7- Display countries names with number of non-official languages.

--select Country.Name , CountryLanguage.Language , CountryLanguage.IsOfficial
--from Country inner join CountryLanguage
--on CountryLanguage.IsOfficial = 0 and Country.Code = CountryLanguage.CountryCode;

--8- Display countries names who has more than one official language.

--select Country.Name , c1.Language , c1.IsOfficial
--from Country inner join CountryLanguage c1 on c1.IsOfficial = 1 and Country.Code = c1.CountryCode 

--select Country.Name , CountryLanguage.IsOfficial
--FROM Country inner join CountryLanguage on CountryLanguage.CountryCode = Country.Code 
--where Code in (select CountryLanguage.CountryCode from CountryLanguage group by CountryCode having COUNT(CountryLanguage.IsOfficial) > 1) 
--and IsOfficial = 1 ;

--9- Display the most country whose inhabitants are expected to die early.

--select *
--from Country 
--where LifeExpectancy < 50 ;

--10 Display countries names with number of cities only if its cities population exceed 100 million.

--select Country.Name , City.Name 
--from Country inner join City on Country.Code = City.CountryCode and City.Population < 100000000 ;

--select * 
--from City Where Population > 100000000

-- 11- Display country with the highest city population.

--select * 
--from Country
--where Population = (select MAX(Population) from Country);

--12 Create new table “WaterResource” containing water resources for different countries. The table must have the following fields:

--Create table WaterResource(
--ID int ,
--CountryCode char(3) ,
--type_code int ,
--Name nvarchar(50)
--foreign key (type_code) references TypeSea(Code),
--foreign key (CountryCode) references Country(Code)

--);

--create table TypeSea(
--code int primary key ,
--Name nvarchar(50)
--);

--insert into TypeSea values (1,'River');

--insert into WaterResource values (1,'EGY' , 1 , 'River Nile' );