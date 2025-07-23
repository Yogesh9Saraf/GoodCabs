/*
Business Request 4 - Identify Cities with Highest and Lowest Total New Passengers

Generate a report that calculates the total new passengers for each city and ranks them based
on this value. Identify the top 3 cities with the highest number of new passengers as well as
the bottom 3 cities with the lowest number of new passengers, categorising them them as "Top 3"
or "Bottom 3" accordingly.

Fields
	* city_name
    * total_new_passengers
    * city_category ("Top 3" or "Bottom 3")
*/
with cte as (SELECT 
		city_name,
        sum(new_passengers)as new_passenger
FROM trips_db.fact_passenger_summary p
join dim_city c on c.city_id = p.city_id
group by city_name)
select 
	*,
	dense_rank() over( order by new_passenger desc) as Bottom_3
		
from cte
limit 3 ;


with cte as (SELECT 
		city_name,
        sum(new_passengers)as new_passenger
FROM trips_db.fact_passenger_summary p
join dim_city c on c.city_id = p.city_id
group by city_name)
select 
	*,
	dense_rank() over( order by new_passenger desc) as Bottom_3
		
from cte
limit 3 offset 7;