------------------------------------------------------------BEGINNING OF DATA EXPLORATION-----------------------------------------------------------------------------
SELECT * 
FROM PProject..CovidDeath
ORDER BY 3, 4;


--Selecting Data that will be used.

SELECT location, date, total_cases, total_cases, total_deaths, population 
FROM PProject..CovidDeath
ORDER BY 1 , 2


-- Total Cases Vs Total Deaths
-- Shows the probability of dying if you get Covid 19 in your Country(USA)
SELECT location, date, total_cases,total_deaths, (total_deaths/total_cases)* 100 AS DeathPercentage
WHERE location like '%states%'
FROM PProject..CovidDeath
ORDER BY 1 , 2



-- Total Cases Vs Population
--Shows what percentage of Population Got Covid 19(USA)

SELECT location, date, population, total_cases,total_deaths, (total_cases/population)* 100 AS totalcases_to_population_Percentage
FROM PProject..CovidDeath
WHERE location like '%states%'
ORDER BY 1 , 2


--Looking at Countries with Highest Infection Rate Compared to Population(GLOBAL)
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))* 100 AS PercentPoulationInfected
FROM PProject..CovidDeath
GROUP BY location, population
ORDER BY PercentPoulationInfected DESC;


-- Countries with Highest Death Count Per Population
SELECT location, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM PProject..CovidDeath
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- Broken Down By Continent
SELECT continent, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM PProject..CovidDeath
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;



-- Showing continents with highest death count per population
SELECT continent, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM PProject..CovidDeath
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;



-- Global Numbers

SELECT date, SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS int)) AS total_deaths, SUM(CAST(new_deaths AS int)) / SUM(new_cases)*100 AS CovidDeaths
FROM PProject..CovidDeath
--WHERE location like '%states%'
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1 , 2    



-- Looking at Total population VS Vaccinations.

-- USE CTE
With PopVsVac (continent, location, date, population,new_vaccinations, RollingPeopleVaccinated)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
 sum(CAST( vac.new_vaccinations AS int)) OVER ( Partition BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM PProject..CovidDeath dea
JOIN PProject..CovidVac vac
ON dea.location = vac.location 
	and dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2, 3

)
SELECT *, (RollingPeopleVaccinated/population)*100
FROM PopVsVac



-- Create view to store data for later visualization 

Create View PercentofPopulation_Vaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
 sum(CAST( vac.new_vaccinations AS int)) OVER ( Partition BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM PProject..CovidDeath dea
JOIN PProject..CovidVac vac
ON dea.location = vac.location 
	and dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2, 3
--------------------------------------------------------------ENDING OF DATA EXPLORATION---------------------------------------------------------------------



--------------------------------------------------Beginning of Queries Used for Tableau Data Visualizations Regarding North America Data Only ------------------

-- Breaking down the total cases and total deaths in North America by country
SELECT continent, location, date, total_cases, CAST(total_deaths AS int) AS total_deaths
FROM PProject..CovidDeath
WHERE continent = 'North America' 
ORDER BY CAST(total_deaths AS int) DESC;


-- Death Percentage based on total cases and total deaths of location
SELECT location, MAX(total_cases) AS TotalInfected, MAX(CAST(total_deaths AS int)) AS TotalDeathts, MAX(CAST(total_deaths AS int))/MAX(total_cases)*100 AS DeathPercentage
FROM PProject..CovidDeath
WHERE continent IN ( SELECT continent FROM PProject..CovidDeath WHERE continent = 'North America')
GROUP BY location
ORDER BY DeathPercentage DESC;


-- Infection Percentage Based on population size
SELECT location, population, MAX(total_cases) HighestInfectionCount, MAX((total_cases/population))*100 AS InfectionPercentage
FROM PProject..CovidDeath
WHERE continent IN ( SELECT continent FROM PProject..CovidDeath WHERE continent = 'North America') 
GROUP BY location, population
ORDER BY InfectionPercentage DESC;
------------------------------------------Ending Queries Used for Tableau Data Visualizations Regarding North America Data Only-----------------------------------------
