--SELECT *
--FROM CovidSmrti
----ORDER BY location
--WHERE location = 'Serbia'

--SELECT location, date, total_cases, new_cases, total_deaths, population
--FROM CovidSmrti
--ORDER BY 1, 2 

----Рачунамо проценат умрлих од укупног броја заражених за сваку државу
--SELECT location, SUM(new_cases) as A, SUM(new_deaths) as B, SUM(new_deaths)/NULLIF(SUM(new_cases),0)*100 AS Death_Rate_Percentage
--FROM CovidSmrti
--GROUP BY (location)
--ORDER BY Death_Rate_Percentage ASC

----Рачунамо како се мењао проценат умрлих (у односу на заражене) у Србији временом
--SELECT location, date, total_deaths, total_cases, total_deaths/total_cases * 100 as Death_Percentage
--FROM CovidSmrti
--WHERE location = 'Serbia' AND total_cases > 0
--ORDER BY date

----Рачунамо број случајева у односу на број становника у Србији по данима (од најскоријег)
--SELECT location, date, total_cases, population, total_cases/population * 100 as Infected_Percentage
--FROM CovidSmrti
--WHERE location = 'Serbia' AND total_cases > 0
--ORDER BY date

----Тражимо десет држава са највећим процентом зараженог становништва (у односу на број становника)
--SELECT TOP 30 location, population as Population, MAX(total_cases) as Total_Cases, MAX(total_cases)/MAX(population) * 100  as Infection_Rate
--FROM CovidSmrti
--GROUP BY location, population
--ORDER BY Infection_Rate DESC

----Тражимо десет држава са највећим процентом смртних случајева (у односу на број становника)
--SELECT TOP 10 location, population, MAX(total_deaths) as Total_Deaths, MAX(total_deaths)/population * 100 AS Death_Rate_Percentage
--FROM CovidSmrti
--WHERE continent IS NOT NULL
--GROUP BY location, population
--ORDER BY Death_Rate_Percentage DESC


----Тражимо број случајева заражености и смртних случајева по континентима
----Први начин
--SELECT continent, SUM(new_cases) AS Total_Cases, SUM(new_deaths) AS Total_Deaths
--FROM CovidSmrti
--WHERE continent IS NOT NULL
--GROUP BY continent
--ORDER BY continent

----Други начин
--SELECT location, MAX(total_cases) AS Total_Cases, MAX(total_deaths) AS Total_Deaths
--FROM CovidSmrti
--WHERE continent IS NULL
--GROUP BY location
--ORDER BY location

----Тражимо континенте са највећом дозом смртности (у односу на број заражених)
--SELECT continent, SUM(new_deaths) AS Total_Deaths, SUM(new_cases) AS Total_Cases, SUM(new_deaths) / SUM(new_cases) * 100 as Death_Rate_Percentage
--FROM CovidSmrti
--WHERE continent IS NOT NULL
--GROUP BY continent
--ORDER BY Death_Rate_Percentage DESC

----Тражимо континенте са највећом дозом умрлих у односу на број становника
--SELECT continent, SUM(new_deaths) AS Total_Deaths, SUM(DISTINCT(population)) AS Population, SUM(new_deaths) / SUM(DISTINCT(population)) * 100 as Death_Rate_Percentage
--FROM CovidSmrti
--WHERE continent IS NOT NULL
--GROUP BY continent
--ORDER BY Death_Rate_Percentage DESC


----Глобална смртност у односну на број заражених, по данима
--SELECT date, SUM(new_cases) AS Total_Cases, SUM(new_deaths) AS Total_Deaths, SUM(new_deaths)/NULLIF(SUM(new_cases),0)*100 AS Death_Percentage
--FROM CovidSmrti
--WHERE continent IS NOT NULL
--GROUP BY date
--ORDER BY date

----Глобална смртност у односну на број заражених, за све време
--SELECT SUM(new_cases) AS Total_Cases, SUM(new_deaths) AS Total_Deaths, SUM(new_deaths)/NULLIF(SUM(new_cases),0)*100 AS Death_Percentage
--FROM CovidSmrti
--WHERE continent IS NOT NULL

----Спајање обе табеле: CovidSmrti и CovidVakcinacija
--SELECT * 
--FROM CovidSmrti smrt
--JOIN CovidVakcinacija vakc
--ON smrt.location = vakc.location AND smrt.date = vakc.date


----Удео вакцинисаних људи по државама, у процентима, заокругљено на две децимале
--SELECT smrt.location, MAX(vakc.people_vaccinated) as Vaccinated, MAX(smrt.population) as Population, ROUND(MAX(vakc.people_vaccinated)/MAX(smrt.population)*100, 2) AS Vaccinated_Percentage
--FROM CovidSmrti smrt
--JOIN CovidVakcinacija vakc
--ON smrt.location = vakc.location AND smrt.date = vakc.date
--WHERE smrt.continent IS NOT NULL
--GROUP BY smrt.location, smrt.continent
--ORDER BY Vaccinated_Percentage DESC

CREATE VIEW VaccinatedPercentage AS
SELECT smrt.location, MAX(vakc.people_vaccinated) as Vaccinated, MAX(smrt.population) as Population, ROUND(MAX(vakc.people_vaccinated)/MAX(smrt.population)*100, 2) AS Vaccinated_Percentage
FROM CovidSmrti smrt
JOIN CovidVakcinacija vakc
ON smrt.location = vakc.location AND smrt.date = vakc.date
WHERE smrt.continent IS NOT NULL
GROUP BY smrt.location, smrt.continent
