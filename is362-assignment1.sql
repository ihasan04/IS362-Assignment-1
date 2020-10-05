-- Ismael Hasan
-- Assignment 1: SQL and Tableau

-- IS 362
-- Dr. Charles Pak
-- CUNY School of Professional Studies

-- Part 1. SQL and NULLs

-- Question 1.0: How many airplanes have listed speeds?
-- Answer: 23
select count(speed) from planes 
	where speed is not NULL;

-- Question 1.1: What is the minimum listed speed and the maximum listed speed?
-- Answer: Max speed is 432, Min speed is 90
select max(speed) from planes;
select min(speed) from planes;

-- Question 2.0: What is the total distance flown by all of the planes in January 2013?
-- Answer: 27188805
select sum(distance) as 'Total Distance Jan 13' from flights 
	where year = 2013 and month =1;

-- Question 2.1: What is the total distance flown by all of the planes in January 2013 where the tailnum is missing?
-- Answer: 81763
select sum(distance) as 'Total Distance Jan 2013 NULL' from flights 
	where year = 2013 and month = 1 and tailnum = "";

-- Question 3: What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer?
-- Write this statement first using an INNER JOIN, then using a LEFT OUTER JOIN. How do your results compare?
-- Answer: Inner Join does not include data with a missing manufacturer.
-- Left Outer Join includes the distance of flights with missing manufacturer and returns it as NULL.

/*Inner Join
manufacturer	Total Distance July 5, 2013
AIRBUS INDUSTRIE	78786
BOEING	335028
EMBRAER	77909
BOMBARDIER INC	31160
AIRBUS	195089
AMERICAN AIRCRAFT INC	2199
CESSNA	2898
MCDONNELL DOUGLAS	7486
DOUGLAS	1089
BARKER JACK L	937
CANADAIR	1142
MCDONNELL DOUGLAS AIRCRAFT CO	15690
MCDONNELL DOUGLAS CORPORATION	4767
GULFSTREAM AEROSPACE	1157
*/
select planes.manufacturer, sum(distance) as 'Total Distance July 5, 2013' from flights
	inner join planes on flights.tailnum = planes.tailnum
    where flights.year = 2013 and flights.month = 7 and flights.day = 5
    group by manufacturer;

/*Left Outer Join
manufacturer	Total Distance July 5, 2013
AIRBUS INDUSTRIE	78786
BOEING	335028
EMBRAER	77909
BOMBARDIER INC	31160
AIRBUS	195089
AMERICAN AIRCRAFT INC	2199
CESSNA	2898
MCDONNELL DOUGLAS	7486
DOUGLAS	1089
BARKER JACK L	937
NULL	127671
MCDONNELL DOUGLAS AIRCRAFT CO	15690
MCDONNELL DOUGLAS CORPORATION	4767
CANADAIR	1142
GULFSTREAM AEROSPACE	1157
*/
select planes.manufacturer, sum(distance) as 'Total Distance July 5, 2013' from flights
	left outer join planes on flights.tailnum = planes.tailnum
    where flights.year = 2013 and flights.month = 7 and flights.day = 5
    group by manufacturer;
    
-- Question 4: Write and answer at least one question of your own choosing that joins information from at least three of the tables in the flights database.
-- How many flights by each manufacturer were made on the first day of 2013, including airports missing names of manufacturers?

/*
manufacturer	airport name	number of flights
NULL	John F Kennedy Intl	49
NULL	La Guardia	81
NULL	Newark Liberty Intl	16
AIRBUS	John F Kennedy Intl	84
AIRBUS	La Guardia	25
AIRBUS	Newark Liberty Intl	18
AIRBUS INDUSTRIE	John F Kennedy Intl	24
AIRBUS INDUSTRIE	La Guardia	32
AIRBUS INDUSTRIE	Newark Liberty Intl	37
BARKER JACK L	John F Kennedy Intl	1
BOEING	John F Kennedy Intl	57
BOEING	La Guardia	45
BOEING	Newark Liberty Intl	118
BOMBARDIER INC	John F Kennedy Intl	29
BOMBARDIER INC	La Guardia	4
BOMBARDIER INC	Newark Liberty Intl	3
CANADAIR	John F Kennedy Intl	1
CANADAIR	La Guardia	3
CESSNA	La Guardia	3
CIRRUS DESIGN CORP	La Guardia	1
CIRRUS DESIGN CORP	Newark Liberty Intl	1
EMBRAER	John F Kennedy Intl	44
EMBRAER	La Guardia	7
EMBRAER	Newark Liberty Intl	108
FRIEDEMANN JON	Newark Liberty Intl	1
GULFSTREAM AEROSPACE	La Guardia	3
HURLEY JAMES LARRY	Newark Liberty Intl	1
MCDONNELL DOUGLAS	La Guardia	8
MCDONNELL DOUGLAS	Newark Liberty Intl	1
MCDONNELL DOUGLAS AIRCRAFT CO	John F Kennedy Intl	6
MCDONNELL DOUGLAS AIRCRAFT CO	La Guardia	21
MCDONNELL DOUGLAS CORPORATION	La Guardia	4
MCDONNELL DOUGLAS CORPORATION	Newark Liberty Intl	1
PAIR MIKE E	John F Kennedy Intl	1
PIPER	La Guardia	2
ROBINSON HELICOPTER CO	John F Kennedy Intl	1
ROBINSON HELICOPTER CO	La Guardia	1
*/

select m.manufacturer, n.name as 'airport name', count(*) as 'number of flights' from flights
left outer join airports n on flights.origin = n.faa
left outer join planes m on m.tailnum = flights.tailnum
where flights.year = 2013 and flights.month = 1 and flights.day = 1
GROUP BY m.manufacturer, n.name
ORDER BY m.manufacturer, n.name;

