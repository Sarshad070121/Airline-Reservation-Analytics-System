-- Checking if there are any flights where origin_id and destination_id match

SELECT 
    *
FROM
    flights
WHERE
    origin_id = destination_id;
    
--  Find duplicate flights with same airline, departure, arrival and time

SELECT 
    airline,
    origin_id,
    destination_id,
    departure_time,
    arrival_time,
    COUNT(*)
FROM
    flights
GROUP BY airline , origin_id , destination_id , departure_time , arrival_time
HAVING COUNT(*) > 1;
  
    
-- checkign payment less than 0
SELECT 
    *
FROM
    payments
WHERE
    amount < 0;
