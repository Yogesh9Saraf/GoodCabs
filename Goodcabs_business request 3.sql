/*
Business Request 3 - City- Level Repeat Passenger Trip Frequency Report

Generate a report that shows the percentage distribution of repeat passengers by the nuber of trips they have taken in each city.
Calculate the percentage of repeat passengers who took 2 Trips, 3 trips and so on, up to 10 trips.

Each column should represent a trip count category, displaying the percentage of repeat passengers who fall into that category 
out of the total repeat passengers for that city.

This report will help identify cities with high repeat trip frequency, which can indicate strong customer loyalty or frequent usage patterns
Fields: city_name, 2-trips so on 10-Trips
*/

WITH cte AS (
    SELECT 
        city_name,
        SUM(CASE WHEN trip_count = 2 THEN repeat_passenger_count ELSE 0 END) AS 2_Trips,
        SUM(CASE WHEN trip_count = 3 THEN repeat_passenger_count ELSE 0 END) AS 3_Trips,
        SUM(CASE WHEN trip_count = 4 THEN repeat_passenger_count ELSE 0 END) AS 4_Trips,
        SUM(CASE WHEN trip_count = 5 THEN repeat_passenger_count ELSE 0 END) AS 5_Trips,
        SUM(CASE WHEN trip_count = 6 THEN repeat_passenger_count ELSE 0 END) AS 6_Trips,
        SUM(CASE WHEN trip_count = 7 THEN repeat_passenger_count ELSE 0 END) AS 7_Trips,
        SUM(CASE WHEN trip_count = 8 THEN repeat_passenger_count ELSE 0 END) AS 8_Trips,
        SUM(CASE WHEN trip_count = 9 THEN repeat_passenger_count ELSE 0 END) AS 9_Trips,
        SUM(CASE WHEN trip_count = 10 THEN repeat_passenger_count ELSE 0 END) AS 10_Trips,
        SUM(repeat_passenger_count) AS total_repeat_passengers
    FROM trips_db.dim_repeat_trip_distribution rp
    JOIN dim_city c ON c.city_id = rp.city_id
    GROUP BY city_name
)
SELECT 	city_name,
		round(2_Trips*100/total_repeat_passengers,2) as 2_Trips,
        round(3_Trips*100/total_repeat_passengers,2) as 3_Trips,
        round(4_Trips*100/total_repeat_passengers,2) as 4_Trips,
        round(5_Trips*100/total_repeat_passengers,2) as 5_Trips,
        round(6_Trips*100/total_repeat_passengers,2) as 6_Trips,
        round(7_Trips*100/total_repeat_passengers,2) as 7_Trips,
        round(8_Trips*100/total_repeat_passengers,2) as 8_Trips,
        round(9_Trips*100/total_repeat_passengers,2) as 9_Trips,
        round(10_Trips*100/total_repeat_passengers,2) as 10_Trips
		
      
FROM cte
ORDER BY total_repeat_passengers DESC;
