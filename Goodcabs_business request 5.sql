/*
Business Request - 5: Identify Month with Highest Revenue for Each City

Genereate a report that identifies the month with the highest revenue for each city.alter
For each city, display the month_name, the revenue amount for that month, and the percentage 
contribution of that month's revenue to the city's total revenue.

Fields 
	* city_name
    * highest_revenue_month
    * revenue
    * percentage_contribution(%)
*/
with cte as (SELECT
	c.city_name,
    c.city_id,
	monthname(date) as month_name,
	round(sum(fare_amount)/1000000,2) as highest_revenue_month,
    (select round(sum(fare_amount)/1000000,2) from fact_trips) as revenue
FROM trips_db.fact_trips t
join dim_city c on c.city_id = t.city_id
group by c.city_id ,monthname(date),year(date)
)
select 
	*,
    round(highest_revenue_month*100/revenue,2) as per_contribution,
    rank() over(partition by city_name order by round(highest_revenue_month*100/revenue,2) desc ) as rrank
from cte

 ;
 with cte as (SELECT
	c.city_name,
    c.city_id,
	monthname(date) as month_name,
	round(sum(fare_amount)/1000000,2) as highest_revenue_month,
    (select round(sum(fare_amount)/1000000,2) from fact_trips) as revenue
FROM trips_db.fact_trips t
join dim_city c on c.city_id = t.city_id
group by c.city_id ,monthname(date),year(date)
),
cte2 as(select 
	*,
    round(highest_revenue_month*100/revenue,2) as per_contribution,
    rank() over(partition by city_name order by round(highest_revenue_month*100/revenue,2) desc ) as rrank
from cte)
select * from cte2
where rrank <=1
order by per_contribution desc
;

