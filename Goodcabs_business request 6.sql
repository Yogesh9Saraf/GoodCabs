/*
Business Request - 6 : Repeat Passenger Rate Analysis

Generate a report that calculates two metrics:
	1. Monthly Repat Passenger Rate: Calculate the repeat passenger rate for each city and monthly
	   and month by comparing thenumber of repeat passengers to the total passengers.
	2. City-wide Repeat Passenger Rate: Calculate the overall reapeat passenger rate for each city,
       considering all passengers across months.
These metrics will provide insights into monthly repeat trends as well as the overall repeat behavious 
for each city

	Fields:
		* city_name
        * month
        * total_passengers
        * repeat_passengers
        * month_repeat_passenger_rate(%) : Repeat passenger rate at the city and month level
        * city_repeat_passenger_rate (%) : overall repeat passenger rate for each city, 
										   aggregated across months
*/

with cte as (SELECT 
		s.city_id,
        c.city_name,
        monthname(month)as month_name,
        total_passengers,
        repeat_passengers,
        round(repeat_passengers*100/total_passengers,2) as montly_per_repeater,
        sum(repeat_passengers) over(partition by city_name) as monthly_wise_repeat_passenger_rate
        
        FROM trips_db.fact_passenger_summary s
join dim_city c on c.city_id = s.city_id
)
,cte2 as (select *,(sum(total_passengers) over(partition by city_id) ) as city_wise_total_passenger from cte)

select 
	*,
    (monthly_wise_repeat_passenger_rate*100/city_wise_total_passenger) as city_wise_repeat_passenger_rate

from cte2
order by city_wise_repeat_passenger_rate desc
;
