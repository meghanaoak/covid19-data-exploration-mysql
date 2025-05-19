
CREATE DATABASE COVIDPROJ;

USE COVIDPROJ;

-- Creating the tables & loading the data from CSV
-- Coviddeaths table
CREATE TABLE coviddeaths (
    iso_code VARCHAR(255),
    continent VARCHAR(255),
    location VARCHAR(255),
    `Date` DATE,
    population INT,
    total_cases INT,
    new_cases INT,
    new_cases_smoothed FLOAT,
    total_deaths FLOAT,
    new_deaths FLOAT,
    new_deaths_smoothed FLOAT,
    total_cases_per_million FLOAT,
    new_cases_per_million FLOAT,
    new_cases_smoothed_per_million FLOAT,
    total_deaths_per_million FLOAT,
    new_deaths_per_million FLOAT,
    new_deaths_smoothed_per_million FLOAT,
    reproduction_rate FLOAT,
    icu_patients FLOAT,
    icu_patients_per_million FLOAT,	
    hosp_patients FLOAT,
    hosp_patients_per_million FLOAT,
    weekly_icu_admissions FLOAT,
    weekly_icu_admissions_per_million FLOAT,
    weekly_hosp_admissions FLOAT,
    weekly_hosp_admissions_per_million FLOAT
);

DROP TABLE coviddeaths;

select * from coviddeaths;

-- loading the data from csv
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CovidDeaths2.csv"
INTO TABLE coviddeaths
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@iso_code, @continent, @location, @`Date`, @population, @total_cases, 
 @new_cases, @new_cases_smoothed, @total_deaths, @new_deaths, @new_deaths_smoothed, 
 @total_cases_per_million, @new_cases_per_million, @new_cases_smoothed_per_million, 
 @total_deaths_per_million, @new_deaths_per_million, @new_deaths_smoothed_per_million, 
 @reproduction_rate, @icu_patients, @icu_patients_per_million, @hosp_patients, 
 @hosp_patients_per_million, @weekly_icu_admissions, @weekly_icu_admissions_per_million, 
 @weekly_hosp_admissions, @weekly_hosp_admissions_per_million)
SET 
 iso_code = NULLIF(@iso_code, ''),
 continent = NULLIF(@continent, ''),
 location = NULLIF(@location, ''),
 `Date` = NULLIF(@`Date`, ''),
 population = NULLIF(@population, ''),
 total_cases = NULLIF(@total_cases, ''),
 new_cases = NULLIF(@new_cases, ''),
 new_cases_smoothed = NULLIF(@new_cases_smoothed, ''),
 total_deaths = NULLIF(@total_deaths, ''),
 new_deaths = NULLIF(@new_deaths, ''),
 new_deaths_smoothed = NULLIF(@new_deaths_smoothed, ''),
 total_cases_per_million = NULLIF(@total_cases_per_million, ''),
 new_cases_per_million = NULLIF(@new_cases_per_million, ''),
 new_cases_smoothed_per_million = NULLIF(@new_cases_smoothed_per_million, ''),
 total_deaths_per_million = NULLIF(@total_deaths_per_million, ''),
 new_deaths_per_million = NULLIF(@new_deaths_per_million, ''),
 new_deaths_smoothed_per_million = NULLIF(@new_deaths_smoothed_per_million, ''),
 reproduction_rate = NULLIF(@reproduction_rate, ''),
 icu_patients = NULLIF(@icu_patients, ''),
 icu_patients_per_million = NULLIF(@icu_patients_per_million, ''),
 hosp_patients = NULLIF(@hosp_patients, ''),
 hosp_patients_per_million = NULLIF(@hosp_patients_per_million, ''),
 weekly_icu_admissions = NULLIF(@weekly_icu_admissions, ''),
 weekly_icu_admissions_per_million = NULLIF(@weekly_icu_admissions_per_million, ''),
 weekly_hosp_admissions = NULLIF(@weekly_hosp_admissions, '');
 
ALTER TABLE coviddeaths 
MODIFY weekly_hosp_admissions TEXT;

DELETE FROM coviddeaths;

alter table coviddeaths
drop column weekly_hosp_admissions_per_million;

ALTER TABLE coviddeaths MODIFY population BIGINT;
select * from coviddeaths;

-- covidvaccinations table
CREATE TABLE covidvaccinations (
    iso_code VARCHAR(255),
    continent VARCHAR(255),
    location VARCHAR(255),
    `Date` DATE,
    new_tests	DOUBLE,
    total_tests DOUBLE,
	total_tests_per_thousand DOUBLE,
	new_tests_per_thousand DOUBLE,
	new_tests_smoothed	DOUBLE,
    new_tests_smoothed_per_thousand	DOUBLE,
    positive_rate DOUBLE,
	tests_per_case	DOUBLE,
    tests_units	 VARCHAR(255),
    total_vaccinations DOUBLE,
	people_vaccinated	DOUBLE,
    people_fully_vaccinated	DOUBLE,
    new_vaccinations	DOUBLE,
    new_vaccinations_smoothed	DOUBLE,
    total_vaccinations_per_hundred	DOUBLE,
    people_vaccinated_per_hundred	DOUBLE,
    people_fully_vaccinated_per_hundred	DOUBLE,
    new_vaccinations_smoothed_per_million DOUBLE,
	stringency_index	DOUBLE,
    population_density DOUBLE,
	median_age	DOUBLE,
    aged_65_older DOUBLE,
	aged_70_older	DOUBLE,
    gdp_per_capita DOUBLE,
	extreme_poverty	DOUBLE,
    cardiovasc_death_rate DOUBLE,
	diabetes_prevalence	DOUBLE,
    female_smokers DOUBLE,
	male_smokers	DOUBLE,
    handwashing_facilities	DOUBLE,
    hospital_beds_per_thousand	DOUBLE,
    life_expectancy	DOUBLE,
    human_development_index DOUBLE
);
SELECT * FROM covidvaccinations;
-- loading the data from csv
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CovidVaccinations2.csv"
INTO TABLE covidvaccinations
FIELDS TERMINATED BY ','  
ENCLOSED BY '"'  
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS 
(@iso_code, @continent, @location, @`Date`, @new_tests, @total_tests, 
 @total_tests_per_thousand, @new_tests_per_thousand, @new_tests_smoothed, 
 @new_tests_smoothed_per_thousand, @positive_rate, @tests_per_case, 
 @tests_units, @total_vaccinations, @people_vaccinated, @people_fully_vaccinated, 
 @new_vaccinations, @new_vaccinations_smoothed, @total_vaccinations_per_hundred, 
 @people_vaccinated_per_hundred, @people_fully_vaccinated_per_hundred, 
 @new_vaccinations_smoothed_per_million, @stringency_index, @population_density, 
 @median_age, @aged_65_older, @aged_70_older, @gdp_per_capita, @extreme_poverty, 
 @cardiovasc_death_rate, @diabetes_prevalence, @female_smokers, @male_smokers, 
 @handwashing_facilities, @hospital_beds_per_thousand, @life_expectancy, 
 @human_development_index)
SET 
    iso_code = NULLIF(@iso_code, ''),
    continent = NULLIF(@continent, ''),
	location = NULLIF(@location, ''),
    `Date` = NULLIF(@`Date`, ''),
    new_tests = NULLIF(@new_tests, ''), 
    total_tests = NULLIF(@total_tests, ''), 
    total_tests_per_thousand = NULLIF(@total_tests_per_thousand, ''), 
    new_tests_per_thousand = NULLIF(@new_tests_per_thousand, ''), 
    new_tests_smoothed = NULLIF(@new_tests_smoothed, ''), 
    new_tests_smoothed_per_thousand = NULLIF(@new_tests_smoothed_per_thousand, ''), 
    positive_rate = NULLIF(@positive_rate, ''), 
    tests_per_case = NULLIF(@tests_per_case, ''), 
    tests_units = NULLIF(@tests_units, ''), 
    total_vaccinations = NULLIF(@total_vaccinations, ''), 
    people_vaccinated = NULLIF(@people_vaccinated, ''), 
    people_fully_vaccinated = NULLIF(@people_fully_vaccinated, ''), 
    new_vaccinations = NULLIF(@new_vaccinations, ''), 
    new_vaccinations_smoothed = NULLIF(@new_vaccinations_smoothed, ''), 
    total_vaccinations_per_hundred = NULLIF(@total_vaccinations_per_hundred, ''), 
    people_vaccinated_per_hundred = NULLIF(@people_vaccinated_per_hundred, ''), 
    people_fully_vaccinated_per_hundred = NULLIF(@people_fully_vaccinated_per_hundred, ''), 
    new_vaccinations_smoothed_per_million = NULLIF(@new_vaccinations_smoothed_per_million, ''), 
    stringency_index = NULLIF(@stringency_index, ''), 
    population_density = NULLIF(@population_density, ''), 
    median_age = NULLIF(@median_age, ''), 
    aged_65_older = NULLIF(@aged_65_older, ''), 
    aged_70_older = NULLIF(@aged_70_older, ''), 
    gdp_per_capita = NULLIF(@gdp_per_capita, ''), 
    extreme_poverty = NULLIF(@extreme_poverty, ''), 
    cardiovasc_death_rate = NULLIF(@cardiovasc_death_rate, ''), 
    diabetes_prevalence = NULLIF(@diabetes_prevalence, ''), 
    female_smokers = NULLIF(@female_smokers, ''), 
    male_smokers = NULLIF(@male_smokers, ''), 
    handwashing_facilities = NULLIF(@handwashing_facilities, ''), 
    hospital_beds_per_thousand = NULLIF(@hospital_beds_per_thousand, ''), 
    life_expectancy = NULLIF(@life_expectancy, ''), 
    human_development_index = NULLIF(@human_development_index, '');
    
    SHOW VARIABLES LIKE 'secure_file_priv';
ALTER TABLE covidvaccinations
MODIFY  human_development_index TEXT;


 



