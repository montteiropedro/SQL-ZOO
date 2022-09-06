-- You might want to look at these examples first
-- Using SUM, COUNT, MAX, DISTINCT and ORDER BY
-- https://sqlzoo.net/wiki/Using_SUM,_Count,_MAX,_DISTINCT_and_ORDER_BY

-- 1. Show the total population of the world.
-- world(name, continent, area, population, gdp)
SELECT SUM(population) AS world_total_population
FROM world;

-- 2. List all the continents - just once each.
SELECT DISTINCT continent FROM world;

-- 3. Give the total GDP of Africa
SELECT SUM(gdp) AS gdp_sum
FROM world
WHERE continent = 'Africa';

  -- If you want to see a column with the continent name, then:
  SELECT continent, SUM(gdp) AS gdp_sum
  FROM world
  GROUP BY continent
  HAVING continent = 'Africa';

-- 4. How many countries have an area of at least 1000000
SELECT COUNT(name) AS area_at_least_1000000
FROM world
WHERE area >= 1000000;

-- 5. What is the total population of ('Estonia', 'Latvia', 'Lithuania')
SELECT SUM(population) FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');



-- ! Using `GROUP BY` and `HAVING`
-- You may want to look at these examples
-- Using GROUP BY and HAVING: https://sqlzoo.net/wiki/Using_GROUP_BY_and_HAVING.

-- 6. For each continent show the continent and number of countries.
SELECT continent, COUNT(name) AS countrys
FROM world
GROUP BY continent;

-- 7. For each continent show the continent and number of countries with populations of at least 10 million.
SELECT continent, COUNT(name) AS countrys
FROM world
WHERE population >= 10000000
GROUP BY continent;

-- 8. List the continents that have a total population of at least 100 million.
SELECT continent FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;
