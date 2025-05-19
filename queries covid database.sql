USE covidproj;
select * from coviddeaths;
SELECT * FROM covidvaccinations;

-- DATA EXPLORATION ON COVID DATASET

-- Select data that we are using
 Select location, `Date`, total_cases, new_cases, total_deaths, population 
 from coviddeaths;
 
 -- Looking at Total cases vs total deaths
 -- Shows likelihood of dying if you contract covid in ypur country
Select location, `Date`, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
from coviddeaths
where location like '%India%';

-- total cases vs population
-- Shows what percentage of population infected with Covid
Select location, `Date`,  population, total_cases,  (total_cases/population)*100 AS PERCENTPOPULATION
from coviddeaths;

-- looking at countries with highest infection rate compared to population
Select location, population, MAX(total_cases) as highestinfectioncount, MAX((total_cases/population))*100 as PERCENTPOPULATIONINFECTED
from coviddeaths
Group by location, population
order by PERCENTPOPULATIONINFECTED desc;
 
 -- Countries with Highest Death Count per Population
SELECT location, MAX(CAST(total_deaths AS SIGNED)) AS totaldeathcount
FROM coviddeaths
where continent is not null
GROUP BY location
ORDER BY totaldeathcount DESC;

-- break things down by continent

-- showing the continents with highest deathcounts per population
SELECT continent, MAX(CAST(total_deaths AS SIGNED)) AS totaldeathcount
FROM coviddeaths
where continent is not null
GROUP BY continent
ORDER BY totaldeathcount DESC;

-- GLOBAL NUMBERS
Select `Date`, SUM(new_cases) as totalcases, SUM(cast(new_deaths as signed)) as totaldeaths,   SUM(cast(new_deaths as signed))/SUM(new_cases)*100 as deathpercentage
from coviddeaths
-- where location like '%India%'
WHERE continent is not null
group by `date`
order by 1,2;
 
 -- Total population vs vaccination
 -- Shows Percentage of Population that has recieved at least one Covid Vaccine
SELECT death.continent,  death.location, death.`Date`, death.population, vaccine.new_vaccinations
from coviddeaths as death
join covidvaccinations as vaccine
on death.`Date` = vaccine.`Date`
and death.location = vaccine.location
where death.continent is not null
order by 2,3;

SELECT death.continent,  death.location, death.`Date`, death.population, vaccine.new_vaccinations,
SUM(cast(vaccine.new_vaccinations as signed)) OVER (PARTITION BY death.location order by death.location, death.`Date`) as rollingpeoplevaccinated
from coviddeaths as death
join covidvaccinations as vaccine
on death.`Date` = vaccine.`Date`
and death.location = vaccine.location
where death.continent is not null
order by 2,3;

-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac(continent, location, `Date`, population, new_vaccinations, rollingpeoplevaccinated)
as
(
SELECT death.continent,  death.location, death.`Date`, death.population, vaccine.new_vaccinations,
SUM(cast(vaccine.new_vaccinations as signed)) OVER (PARTITION BY death.location order by death.location, death.`Date`) as rollingpeoplevaccinated
from coviddeaths as death
join covidvaccinations as vaccine
on death.`Date` = vaccine.`Date`
and death.location = vaccine.location
where death.continent is not null
order by 2,3
)
select *, (rollingpeoplevaccinated/population)*100 as totalpeoplevaccinated
from PopvsVac;


-- creating views to store data for visualisation

create view percentpopulationvaccinated as
SELECT death.continent,  death.location, death.`Date`, death.population, vaccine.new_vaccinations,
SUM(cast(vaccine.new_vaccinations as signed)) OVER (PARTITION BY death.location order by death.location, death.`Date`) as rollingpeoplevaccinated
from coviddeaths as death
join covidvaccinations as vaccine
on death.`Date` = vaccine.`Date`
and death.location = vaccine.location
where death.continent is not null
order by 2,3;

select * from percentpopulationvaccinated;

