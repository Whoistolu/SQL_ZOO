-- SEELECT basics

-- (1) Introducing the world table of countries
SELECT population FROM world
  WHERE name = 'Germany';

-- (2) Scandinavia
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway' and 'Denmark');

-- (3) Just the right size
  SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000;

  -- SELECT from WORLD Tutorial

  -- (1) Introduction
SELECT name, continent, population FROM world;

-- (2) Large Countries
SELECT name
  FROM world
 WHERE population > 200000000;

 --(3) Per capita GDP
SELECT name, gdp/population
 FROM world
WHERE population > 200000000;

-- (4) South America In millions
SELECT name, population
 FROM world
WHERE continent = 'South America';

-- (5) France, Germany, Italy


