-- 1. How many stops are in the database.
SELECT COUNT(*) FROM stops;

-- 2. Find the id value for the stop 'Craiglockhart'
SELECT stops.id FROM stops
WHERE stops.name = 'Craiglockhart';

-- 3. Give the id and the name for the stops on the '4' 'LRT' service.
SELECT stops.id, stops.name
FROM stops
INNER JOIN route
  ON stops.id = route.stop
WHERE route.num = 4
  AND route.company = 'LRT';

-- 4. The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.
SELECT company, num, COUNT(*)
FROM route
WHERE stop IN (149, 53)
GROUP BY company, num
HAVING COUNT(*) = 2;

-- 5. Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.
SELECT a.company, a.num, a.stop, b.stop
FROM route AS a
INNER JOIN route AS b
  ON a.company = b.company 
  AND a.num = b.num
WHERE a.stop = 53
  AND b.stop = 149;

-- 6. The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'
SELECT r1.company, r1.num, s1.name AS first_stop, s2.name AS last_stop
FROM route AS r1
INNER JOIN route AS r2
  ON r1.company = r2.company
    AND r1.num = r2.num
INNER JOIN stops AS s1
  ON r1.stop = s1.id
INNER JOIN stops AS s2
  ON r2.stop = s2.id
WHERE s1.name = 'Craiglockhart'
  AND s2.name = 'London Road';

-- 7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
SELECT DISTINCT r1.company, r1.num
FROM route AS r1
INNER JOIN route AS r2
  ON r1.company = r2.company
  AND r1.num = r2.num
INNER JOIN stops AS s1
  ON r1.stop = s1.id
INNER JOIN stops AS s2
  ON r2.stop = s2.id
WHERE s1.name = 'Haymarket'
  AND s2.name = 'Leith';

-- 8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT DISTINCT r1.company, r1.num
FROM route AS r1
INNER JOIN route AS r2
  ON r1.company = r2.company
  AND r1.num = r2.num
INNER JOIN stops AS s1
  ON r1.stop = s1.id
INNER JOIN stops AS s2
  ON r2.stop = s2.id
WHERE s1.name = 'Craiglockhart'
  AND s2.name = 'Tollcross';

-- 9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.
SELECT DISTINCT
  s2.name AS stops_from_craiglockhart,
  r1.company,
  r1.num
FROM route AS r1
INNER JOIN route AS r2
  ON r1.company = r2.company
    AND r1.num = r2.num
INNER JOIN stops AS s1
  ON r1.stop = s1.id
INNER JOIN stops AS s2
  ON r2.stop = s2.id
WHERE s1.name = 'Craiglockhart';

-- 10. Find the routes involving two buses that can go from Craiglockhart to Lochend.
-- Show the bus no. and company for the first bus, the name of the stop for the transfer,
-- and the bus no. and company for the second bus.

-- Hint
-- Self-join twice to find buses that visit Craiglockhart and Lochend, then join those on matching stops.

-- ! I got stuck in this one, so I searched for it in google and found this resolution in Stack Overflow: https://sqlzoo.net/wiki/Self_join
-- ! I'm letting this note just to clarify that this was not made by me. But it really helped me to understand self join a little more.

SELECT DISTINCT
  r1.num,
  r1.company,
  stops.name,
  r2.num,
  r2.company
FROM stops
INNER JOIN route AS r1
  ON r1.stop = stops.id
INNER JOIN route AS r2
  ON r2.stop = stops.id
WHERE EXISTS (
  SELECT 1
  FROM route r3 
  INNER JOIN stops s1
    ON r3.stop = s1.id
  WHERE s1.name = 'Craiglockhart'
    AND r3.num = r1.num
    AND r3.company = r1.company
)
AND EXISTS (
  SELECT 1
  FROM route r4 
  INNER JOIN stops s2
    ON r4.stop = s2.id
  WHERE s2.name ='Lochend'
    AND r4.num = r2.num
    AND r4.company = r2.company
);
