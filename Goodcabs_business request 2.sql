/*
Business Request - 2 Monthly City-Level Trips Target Performance Report
Generate a report that evaluates the target performance fo trips at the monthly 
and city level. For each city and month, compare the actual total trips with the 
target trips and categorise the performance as follows:

	* If actual trips are greater than target trips, mark it as "Above Target".
	* If actual trips are less than or equal to target trips, mark it as "Below Target".

Additionally, calculate the % difference between actual and target trips to quantify the 
performance gap.

Fields

City_name,
month_name,
actual_trips,
target_trips
performance_Status
%difference*/
with x as
			(select 
					monthname(date) as month_name,
					city_id,
				   count(trip_id)as actual_trips
			from fact_trips
			group by city_id ,monthname(date)
),

y as 
			(select 
				monthname(month) as month_name,
				city_id,
				sum(total_target_trips) as target_trips
			from targets_db.monthly_target_trips  
			group by city_id, monthname(month)
		)

select
		x.month_name,
		x.city_id,
        actual_trips,
        target_trips,
        case 
			when actual_trips >= target_trips then "Above Target"
            when actual_trips <= target_trips then "Below Target"
		end as performance_status,
        round((target_trips-actual_trips)*100/actual_trips,2) as per_Difference
from x as x
join y as y on 
x.city_id = y.city_id and 
x.month_name = y.month_name




