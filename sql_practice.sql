
SELECT title FROM moviesdb.movies where title LIKE 'thor%';

SELECT title FROM moviesdb.movies where title LIKE '%AMERICA%';

#Print all  movies where we don't know the value of the studio
Select * from moviesdb.movies where studio = '';

# Which movies had greater than 9 imdb rating?

select title,imdb_rating from moviesdb.movies where imdb_rating> 9;

# Movies with rating between 6 and 8
select title,imdb_rating from moviesdb.movies where imdb_rating between 6 and 8;

# -- Select all movies whose release year can be 2018 or 2019 or 2022;

select * from moviesdb.movies where release_year IN (2018,2019,2022);


-- All movies where imdb rating is not available (imagine the movie is just released)

SELECT * FROM moviesdb.movies where imdb_rating is NULL;

-- All movies where imdb rating is available 

SELECT * FROM moviesdb.movies where imdb_rating is NOT NULL;

-- Print all bollywood movies ordered by their imdb rating

select * from moviesdb.movies
where industry = 'bollywood' 
order by imdb_rating ASC;


-- Print first 5 bollywood movies with highest rating

select * from moviesdb.movies
where industry = 'bollywood' 
order by imdb_rating Desc
Limit 5;

-- Select movies starting from second highest rating movie till next 5 movies for bollywood
select * from moviesdb.movies
where industry = 'bollywood' 
order by imdb_rating Desc
Limit 5 OFFSET 1;


### Module: Summary Analytics (COUNT, MAX, MIN, AVG, GROUP BY)

-- How many total movies do we have in our movies table?

SELECT COUNT(*) FROM moviesdb.movies ;


-- Select highest imdb rating for bollywood movies

SELECT max(imdb_rating) from moviesdb.movies where industry = 'Bollywood';

select * from moviesdb.movies 
where industry = 'Bollywood'
order by imdb_rating desc
limit 1;

SELECT max(imdb_rating) from moviesdb.movies where industry = 'Bollywood';

-- Select lowest imdb rating for bollywood movies

select * from moviesdb.movies 
where industry = 'Bollywood' and imdb_rating is NOT NULL
order by imdb_rating asc
limit 1;

-- Print average rating of Marvel Studios movies
SELECT ROUND(AVG(imdb_rating),2) from moviesdb.movies where studio like '%MARVEL%'
SELECT Min(imdb_rating) from moviesdb.movies where studio like '%MARVEL%'
SELECT max(imdb_rating) from moviesdb.movies where studio like '%MARVEL%';

SELECT ROUND(AVG(imdb_rating),2) as avg_rating,
 Min(imdb_rating) as min_rating,
 max(imdb_rating) as max_rating,
 count(imdb_rating) as total_rating
from moviesdb.movies
where studio like '%MARVEL%';

-- Print count of movies by industry

select distinct industry,
count(*) as movies_count ,
AVG(imdb_rating) as average_rating 
from moviesdb.movies
group by industry;

-- Count number of movies released by a given production studio
 select studio,count(*) as movies_released
 from moviesdb.movies
 where studio != ''
 group by studio
order by movies_released desc
 

-- What is the average rating of movies per studio and also order them by average rating in descending format?

 select studio,count(*) as movies_released, avg(imdb_rating) as average_rating
 from moviesdb.movies
 where studio != ''
 group by studio
order by movies_released desc

-- Print all the years where more than 2 movies were released

select distinct release_year, count(*) as movies_count from moviesdb.movies
group by release_year 
having movies_count > 2
order by movies_count Desc

-- Print actor name, their birth_year and age
select name, birth_year, (YEAR(CURDATE()) - birth_year) as age from moviesdb.actors

SELECT * , (revenue - budget) as profit FROM moviesdb.financials;



-- Print revenue of all movies in INR currency

SELECT movie_id,revenue, budget, unit, IF (currency = 'USD', revenue * 83, revenue) as revenue_inr
from moviesdb.financials;




-- Print revenue in millions 

SELECT movie_id, revenue, budget, unit,
case 
when unit = 'Billions' then revenue/1000
when unit = 'Billions' then budget/1000
Else revenue
END as revenue_mln
from moviesdb.financials





















