use PortfolioProject

select *
from PortfolioProject..CovidDeaths
where continent is not Null
order by 3,4

--select *
--from PortfolioProject..CovidVaccinations
--order by 3,4

-- Select the Data that we are going to be using

select Location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
where continent is not Null
order by 1,2

-- Total cases vs total deaths

select Location, date, total_cases, total_deaths, ((total_deaths/total_cases)*100) as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%states%' and continent is not Null
order by 1,2


-- Looking at the total cases vs the population
select Location, date, total_cases, population, ((total_cases/population)*100) as TotalCasePercentage
from PortfolioProject..CovidDeaths
where location like '%states%' and continent is not Null
order by 1,2


-- Looking at Countries with highest Infection Rate compared to Population

select Location, population, Max(total_cases) as HighestInfectionCount, Max((total_cases/population)*100) as PercentagePopulationInfected
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not Null
group by Location, population
order by PercentagePopulationInfected desc


-- Showing countries with Highest Death Count per Population

select Location, Max(cast(total_deaths as int)) as HighestDeathCount
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not Null
group by Location, population
order by HighestDeathCount desc



-- Breaking down Deaths per Continent

-- Showing Continents with the Highest Death Counts per population

select continent, Max(cast(total_deaths as int)) as HighestDeathCount
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not Null
group by continent

-- GLOBAL NUMBERS

select 
-- date, 
SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where continent is not null
-- Group by date
order by 1,2


-- Covid Vaccination Table

Select *
from PortfolioProject..CovidVaccinations

-- Joining both the CovidDeaths table and CovidVaccinations table

-- Looking at total poplation vs vaccinations

select dae.continent, dae.location, dae.date, dae.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) over (partition by dae.location order by dae.location, dae.date) as RollingPeopleVaccinated -- Rolling count of vaccination
from PortfolioProject..CovidDeaths as dae
Join PortfolioProject..CovidVaccinations vac
	on dae.location = vac.location
	and dae.date = vac.date
where dae.continent is not NULL
order by 2,3

-- CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccination, RollingPoepleVaccinated)
as
(
select dae.continent, dae.location, dae.date, dae.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) over (partition by dae.location order by dae.location, dae.date) as RollingPeopleVaccinated -- Rolling count of vaccination
from PortfolioProject..CovidDeaths as dae
Join PortfolioProject..CovidVaccinations vac
	on dae.location = vac.location
	and dae.date = vac.date
where dae.continent is not NULL
--order by 2,3
)
Select *, (RollingPoepleVaccinated/Population)*100 as PercentageVaccinated
from PopvsVac




-- Temp Table

drop table if exists #PercentPopulationVaccinated
create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPoepleVaccinated numeric
)
Insert into #PercentPopulationVaccinated
select dae.continent, dae.location, dae.date, dae.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) over (partition by dae.location order by dae.location, dae.date) as RollingPoepleVaccinated -- Rolling count of vaccination
from PortfolioProject..CovidDeaths as dae
Join PortfolioProject..CovidVaccinations vac
	on dae.location = vac.location
	and dae.date = vac.date
where dae.continent is not NULL
order by 2,3

Select *, (RollingPoepleVaccinated/Population)*100 as PercentageVaccinated
from #PercentPopulationVaccinated



-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
select dae.continent, dae.location, dae.date, dae.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) over (partition by dae.location order by dae.location, dae.date) as RollingPoepleVaccinated -- Rolling count of vaccination
from PortfolioProject..CovidDeaths as dae
Join PortfolioProject..CovidVaccinations vac
	on dae.location = vac.location
	and dae.date = vac.date
where dae.continent is not NULL
--order by 2,3

select *
from PercentPopulationVaccinated















