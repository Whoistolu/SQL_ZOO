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
SELECT name, population
 FROM world
WHERE name IN ('France', 'Germany', 'Italy');

--- (6) United
SELECT name
FROM world
WHERE name LIKE '%United%'

-- (7) Two ways to be big
SELECT name, population, area
 FROM world
WHERE area > 3000000 or population > 250000000;

-- (8) One or the other (but not both)
SELECT name, population, area
 FROM world
WHERE area > 3000000 XOR population > 250000000;

-- (9) Rounding
SELECT name, ROUND (POPULATION/1000000, 2), ROUND(gdp/1000000000, 2)
 FROM world
WHERE continent = 'South America';

-- (10) Trillion dollar economies
SELECT name, ROUND(GDP/population/1000)*1000
 FROM world
WHERE GDP > 1000000000000;

-- (11) Name and capital have the same length
SELECT name, capital
 FROM world
 WHERE LENGTH(name) = LENGTH(capital);

-- (12) Matching name and capital
SELECT name, capital
 FROM world
WHERE LEFT(name,1) = LEFT(capital,1) AND name <> capital;

-- (13) All the vowels
SELECT name
   FROM world
WHERE name LIKE '%a%'
  AND name LIKE '%e%' AND name LIKE '%i%' AND name LIKE '%o%' AND name LIKE '%u%' AND name NOT LIKE '% %';

  -- SELECT from Nobel Tutorial

-- 1. Winners from 1950
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950;

-- 2. 1962 Literature
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature';

   -- 3. Albert Einstein
SELECT yr, subject
  FROM nobel
 WHERE winner = 'Albert Einstein';

-- 4. Recent Peace Prizes
SELECT winner
  FROM nobel
 WHERE subject = 'Peace' AND yr >= 2000;

 -- 5. Literature in the 1980's
SELECT yr, subject, winner
  FROM nobel
 WHERE subject = 'Literature' AND yr BETWEEN 1980 AND 1989;

-- 6. Only Presidents
SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter', 'Barack Obama');

-- 7. John
SELECT winner FROM nobel
 WHERE winner LIKE 'John%';

 -- 8. Chemistry and Physics from different years
SELECT yr, subject, winner
FROM nobel
 WHERE (subject = 'Physics' AND yr = 1980) OR (subject = 'Chemistry' AND yr = 1984);

-- 9. Exclude Chemists and Medics
SELECT yr, subject, winner
FROM nobel
 WHERE yr = 1980 AND subject NOT IN ('Chemistry', 'Medicine');

-- 10. Early Medicine, Late Literature
SELECT yr, subject, winner
FROM nobel
 WHERE (subject = 'Medicine' AND yr < 1910) OR (subject = 'Literature' AND yr >= 2004);

 -- 11. Umlaut
SELECT * FROM nobel
 WHERE winner = 'PETER GRÜNBERG';

-- 12. Apostrophe
SELECT * FROM nobel
 WHERE winner = 'EUGENE O''NEILL';

-- 13. Knights of the realm
SELECT winner, yr, subject FROM nobel
 WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, winner ASC;

-- 14. Chemistry and Physics last
SELECT winner, subject
  FROM nobel
 WHERE yr = 1984
 ORDER BY subject IN ('Physics','Chemistry'), subject, winner;

 -- SELECT within SELECT Tutorial

-- 1. Bigger than Russia
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia');

-- 2. Richer than UK
SELECT name FROM world 
WHERE continent = 'Europe' AND gdp/population > 
  (SELECT gdp/population FROM world 
    WHERE name = 'United Kingdom');

-- 3. Neighbours of Argentina and Australia
SELECT name, continent
FROM world
WHERE continent IN (SELECT continent
  FROM world
  WHERE name IN ('Argentina', 'Australia'))
  ORDER BY name;

  -- 4. Between Canada and Poland
SELECT name, population
FROM world
WHERE population > (SELECT population FROM world 
  WHERE name = 'Canada') AND population < (SELECT population FROM world 
    WHERE name = 'Poland');

-- 5. Percentages of Germany
SELECT name, CONCAT(ROUND(100*population/
  (SELECT population FROM world WHERE name = 'Germany')), '%') AS percentage
FROM world
WHERE continent = 'Europe';

-- 6. Bigger than every country in Europe
SELECT name FROM world 
  WHERE gdp > (SELECT MAX(gdp) FROM world 
    WHERE continent = 'Europe');

    -- 7. Largest in each continent
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0);

-- 8. First country of each continent (alphabetically)
SELECT continent, name FROM world x
  WHERE name <= ALL
    (SELECT name FROM world y
        WHERE y.continent=x.continent);

-- 9. Difficult Questions That Utilize Techniques Not Covered In Prior Sections
SELECT name, continent, population
FROM world x
WHERE 25000000 >= ALL(SELECT population FROM world y WHERE x.continent = y.continent);

-- 10. Difficult Questions That Utilize Techniques Not Covered In Prior Sections
SELECT name, continent FROM world x
  WHERE population >= ALL
    (SELECT population * 3 FROM world y
        WHERE y.continent=x.continent AND x.name <> y.name);

        -- SUM and COUNT

-- 1. Total world population
SELECT SUM(population)
FROM world;

-- 2. List of continents
SELECT DISTINCT continent
FROM world;

-- 3. GDP of Africa
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa';

-- 4. Count the big countries
SELECT COUNT(area)
FROM world
WHERE area > 1000000;


-- 5. Baltic states population
SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');

-- 6. Counting the countries of each continent
SELECT continent, COUNT(name)
FROM world
GROUP BY continent;

-- 7. Counting big countries in each continent
SELECT continent, COUNT(name)
FROM world
WHERE population > 10000000
GROUP BY continent;

-- 8. Counting big continents
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) > 100000000;