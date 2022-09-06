-- 1. List the films where the yr is 1962 [Show id, title]
SELECT id, title FROM movie
WHERE yr = 1962;

-- 2. Give year of 'Citizen Kane'.
SELECT yr FROM movie
WHERE title = 'Citizen Kane';

-- 3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr FROM movie
WHERE title LIKE '%Star Trek%';

-- 4. What id number does the actor 'Glenn Close' have?
SELECT actor.id FROM actor
WHERE actor.name = 'Glenn Close';

-- 5. What is the id of the film 'Casablanca' [ in my case was 27 ]
SELECT movie.id FROM movie
WHERE movie.title = 'Casablanca';

-- 6. Obtain the cast list for 'Casablanca'.
-- Use movieid=11768, (or whatever value you got from the previous question)
SELECT actor.name FROM actor
JOIN casting
  ON actor.id = casting.actorid
WHERE casting.movieid = 27;

-- 7. Obtain the cast list for the film 'Alien'
SELECT actor.name FROM actor
JOIN casting
  ON actor.id = casting.actorid
JOIN movie
  ON casting.movieid = movie.id
WHERE movie.title = 'Alien';

-- 8. Harrison Ford movies
SELECT movie.title FROM movie
JOIN casting
  ON movie.id = casting.movieid
JOIN actor
  ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford';

-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT movie.title FROM movie
JOIN casting
  ON movie.id = casting.movieid
JOIN actor
  ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford'
  AND casting.ord != 1;

-- 10. List the films together with the leading star for all 1962 films.
SELECT movie.title, actor.name FROM movie
JOIN casting
  ON movie.id = casting.movieid
JOIN actor
  ON casting.actorid = actor.id
WHERE casting.ord = 1
  AND movie.yr = 1962;



-- ! Harder Questions

-- 11. Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT movie.yr, COUNT(movie.title) AS movies_that_year FROM movie
JOIN casting
  ON movie.id = casting.movieid
JOIN actor
  ON casting.actorid = actor.id
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(movie.title) > 2;

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.
-- Did you get "Little Miss Marker twice"?
-- Julie Andrews starred in the 1980 remake of Little Miss Marker and not the original(1934).
-- Title is not a unique field, create a table of IDs in your subquery
SELECT movie.title, actor.name FROM movie
JOIN casting
  ON movie.id = casting.movieid
JOIN actor
  ON casting.actorid = actor.id
WHERE movie.id IN (
  SELECT casting.movieid FROM casting
  JOIN actor
    ON casting.actorid = actor.id
  WHERE actor.name = 'Julie Andrews'
)
  AND casting.ord = 1;

-- 13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
SELECT actor.name FROM actor
JOIN casting
  ON actor.id = casting.actorid
WHERE casting.ord = 1
GROUP BY actor.name
HAVING COUNT(casting.movieid) >= 15
ORDER BY actor.name;

-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT movie.title, COUNT(casting.actorid) FROM movie
JOIN casting
  ON movie.id = casting.movieid
WHERE movie.yr = 1978
GROUP BY movie.title
ORDER BY COUNT(casting.actorid) DESC, movie.title

-- 15. List all the people who have worked with 'Art Garfunkel'.
SELECT actor.name FROM actor
JOIN casting
  ON actor.id = casting.actorid
WHERE casting.movieid IN (
  SELECT casting.movieid FROM casting
  JOIN actor
    ON casting.actorid = actor.id
  WHERE actor.name = 'Art Garfunkel'
)
  AND actor.name != 'Art Garfunkel';
