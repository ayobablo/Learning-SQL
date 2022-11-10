USE PortfolioProject;


SELECT [iso_code]
      ,[continent]
      ,[location]
      ,[date]
      ,[population]
      ,[total_cases]
      ,[new_cases]
      ,[new_cases_smoothed]
      ,[total_deaths]
      ,[new_deaths]
      ,[new_deaths_smoothed]
      ,[total_cases_per_million]
      ,[new_cases_per_million]
      ,[new_cases_smoothed_per_million]
      ,[total_deaths_per_million]
      ,[new_deaths_per_million]
      ,[new_deaths_smoothed_per_million]
      ,[reproduction_rate]
      ,[icu_patients]
      ,[icu_patients_per_million]
      ,[hosp_patients]
      ,[hosp_patients_per_million]
      ,[weekly_icu_admissions]
      ,[weekly_icu_admissions_per_million]
      ,[weekly_hosp_admissions]
      ,[weekly_hosp_admissions_per_million]
  FROM [PortfolioProject].[dbo].[CovidDeaths]


-- select *
-- from PortfolioProject..CovidDeath
-- order by 3,4

-- select *
-- from PortfolioProject.dbo.CovidVaccination
-- order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2

-- total cases vs total_deaths
select location, date, total_cases, total_deaths, 
	case when total_cases = 0 then null else 
	(total_deaths/total_cases)*100 
	end as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%kingdom%'
order by 1,2

-- total cases vs population
select location, date, total_cases, population, 
	(total_cases/population)*100 as CasesPercentage
from PortfolioProject..CovidDeaths
where location like '%kingdom%'
order by 1,2 


-- countries with the highest death count
select location, max(total_deaths) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by location
order by TotalDeathCount desc

select continent, max(total_deaths) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent <> ' '
group by continent
order by TotalDeathCount desc

-- Global numbers
select sum(new_cases) total_cases,sum(new_deaths) total_deaths
	--case when total_cases = 0 or total_deaths = 0 then NULL
		--else (total_deaths/total_cases)*100 end as DeathPercentage
from PortfolioProject..CovidDeaths
where continent is not null
--group by date
order by 1,2

-- Vaccinations
Select *
from PortfolioProject..CovidVaccination

-- Join tables
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
	sum(convert(bigint, cv.new_vaccinations)) over (partition by cd.location order by cd.location, cd.date) as vaccination_sum
from PortfolioProject..CovidDeaths cd
join PortfolioProject..CovidVaccination cv
	on cd.location = cv.location
		and cd.date = cv.date 
where cd.continent <> ' ' and cv.new_vaccinations <> ' '
order by 2,3

GO
-- creating views
create view PopulationVaccination as
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
sum(convert(bigint, cv.new_vaccinations)) over (partition by cd.location order by cd.location, cd.date) as vaccination_sum
from PortfolioProject..CovidDeaths cd
join PortfolioProject..CovidVaccination cv
on cd.location = cv.location
	and cd.date = cv.date 
where cd.continent <> ' ' and cv.new_vaccinations <> ' '

GO

select * from PopulationVaccination