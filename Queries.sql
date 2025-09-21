-- 01. Retriving all the airports with city and country information
SELECT 
    airport_name, airport_city, airport_country
FROM
    airport;
   
   
-- Q2. Count the total no of flight
SELECT 
    COUNT(*) AS total_flights
FROM
    flights;
    

-- Q3. Show all the passenger full name with their passenger_id

SELECT 
    passenger_id,
    CONCAT(first_name, ' ', last_name) AS full_name
FROM
    passengers;
    

-- Q4. Counting reservation by status
SELECT 
    status, COUNT(*) AS reservation_status
FROM
    reservation
GROUP BY status;

-- Q5. Fethching the payment amount with payment method

SELECT 
    payment_id, amount, method
FROM
    payments;
    

-- Q6. Count number of flights departing from each airport

SELECT 
    a.airport_name, COUNT(f.flight_id) AS departing_flights
FROM
    airport a
        LEFT JOIN
    flights f ON a.airport_id = f.origin_id
GROUP BY a.airport_name
ORDER BY departing_flights DESC;

-- Q7. Passenger counts per flight
SELECT 
    f.flight_id,
    f.airline,
    COUNT(r.passenger_id) AS passenger_count
FROM
    flights f
        LEFT JOIN
    reservation r ON f.flight_id = r.flight_id
GROUP BY f.flight_id;


-- 	Q8 Average by payment method
SELECT 
    method, ROUND(AVG(amount), 2) AS average_amount
FROM
    payments
GROUP BY method;


-- Q9. Top 5 destination cities
SELECT 
  a.airport_city AS destination_city, 
  COUNT(*) AS flight_count,
  RANK() OVER (ORDER BY COUNT(*) DESC) AS city_rank
FROM flights f
JOIN airport a ON f.destination_id = a.airport_id
GROUP BY a.airport_city
ORDER BY flight_count DESC
LIMIT 5;


-- Q10. Total amount spent by each customer
SELECT 
    p.passenger_id,
    p.first_name,
    p.last_name,
    ROUND(SUM(a.amount), 2) AS total_amount
FROM
    passengers p
        JOIN
    reservation r ON p.passenger_id = r.passenger_id
        JOIN
    payments a ON r.reservation_id = a.reservation_id
GROUP BY p.passenger_id , p.first_name , p.last_name;

-- Q11. Reservation in last 30 days
SELECT 
    *
FROM
    reservation
WHERE
    booking_date >= NOW() - INTERVAL 30 DAY;
	
    
-- Q12 Passenger without a payment history (possible nonpayment)
SELECT 
    p.passenger_id, p.first_name, p.last_name
FROM
    passengers p
        JOIN
    reservation r ON p.passenger_id = r.passenger_id
        JOIN
    payments a ON r.reservation_id = a.reservation_id
WHERE
    a.payment_id IS NULL;
    
-- Q13 Reservation count by seat number
SELECT 
    seat_no, COUNT(*) AS seat_number_count
FROM
    reservation
GROUP BY seat_no
ORDER BY seat_number_count DESC;
	
-- Q14 Flight count by airline and status
SELECT 
    airline, status, COUNT(*) AS flight_count
FROM
    flights
GROUP BY airline , status;

-- Q15 Reservation with passengers details
SELECT 
    r.reservation_id,
    p.first_name,
    p.last_name,
    f.airline,
    f.departure_time
FROM
    reservation r
        JOIN
    passengers p ON r.passenger_id = p.passenger_id
        JOIN
    flights f ON r.flight_id = f.flight_id;

-- Q16. Top 3 cities by airport
WITH top_3_cities AS (
	SELECT airport_city,
		COUNT(*) AS airport_count
	FROM
		airport
	GROUP BY airport_city
)
SELECT * FROM top_3_cities ORDER BY airport_count DESC LIMIT 3;
    

-- Q17 Passengers with multiple bookings on same flight
SELECT 
    r.passenger_id,
    r.flight_id,
    f.departure_time,
    COUNT(*) AS booking_count
FROM
    reservation r
        JOIN
    flights f ON r.flight_id = f.flight_id
GROUP BY r.passenger_id , r.flight_id , f.departure_time
HAVING booking_count > 1;


-- Q18 Rank passengers by total spendings
SELECT
	p.passenger_id,
    p.first_name,
    p.last_name,
    ROUND(SUM(a.amount),2) AS totl_spent,
    RANK() OVER (ORDER BY ROUND(SUM(a.amount),2) DESC) AS spend_rank
FROM passengers p
JOIN reservation r ON p.passenger_id = r.passenger_id
JOIN payments a ON r.reservation_id = a.reservation_id
GROUP BY p.passenger_id;
	
	
-- Q19 Ranking airline by delay percentage
WITH airline_stats AS (
  SELECT airline,
         COUNT(*) AS total_flights,
         SUM(CASE WHEN status = 'Delayed' THEN 1 ELSE 0 END) AS delayed_flights
  FROM flights
  GROUP BY airline
)
SELECT airline,
       delayed_flights,
       total_flights,
       ROUND((delayed_flights/total_flights)*100, 2) AS delay_percent,
       RANK() OVER (ORDER BY ROUND((delayed_flights/total_flights)*100, 2) DESC) AS delay_rank
FROM airline_stats;

-- Q20 Running patment by date
SELECT paymentdate, amount,
       SUM(amount) OVER (ORDER BY paymentdate) AS running_total
FROM payments;
	
-- Q21 Flight counts by airline with rank.
SELECT airline, COUNT(*) AS flight_count,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS airline_rank
FROM flights
GROUP BY airline;


-- Q22 Percent rank of passengers by reservations.
SELECT passenger_id, COUNT(*) AS reservations,
       PERCENT_RANK() OVER (ORDER BY COUNT(*) DESC) AS reservation_percent_rank
FROM reservation
GROUP BY passenger_id;


-- Q23 Top 5 passengers with cancellations
WITH cancelled AS (
  SELECT passenger_id, COUNT(*) AS cancellations
  FROM reservation
  WHERE status = 'Cancelled'
  GROUP BY passenger_id
)
SELECT * FROM cancelled ORDER BY cancellations DESC LIMIT 5;

-- Q24. Routes by revenue
SELECT origin_id, destination_id,
       SUM(pay.amount) AS total_revenue,
       RANK() OVER (ORDER BY SUM(pay.amount) DESC) AS revenue_rank
FROM flights f
JOIN reservation r ON f.flight_id = r.flight_id
JOIN payments pay ON r.reservation_id = pay.reservation_id
GROUP BY origin_id, destination_id;


-- Q25. Flights ranked by number of unique passengers.
SELECT f.flight_id, f.airline, COUNT(DISTINCT r.passenger_id) AS unique_passengers,
       RANK() OVER (ORDER BY COUNT(DISTINCT r.passenger_id) DESC) AS passenger_rank
FROM flights f
JOIN reservation r ON f.flight_id = r.flight_id
GROUP BY f.flight_id;

-- Q26. Flight departure hour popularity with rank.
SELECT HOUR(departure_time) AS hour, COUNT(*) AS flights_count,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS hour_rank
FROM flights
GROUP BY hour;

-- Q27. Ranks of delayed flights per airline.
SELECT flight_id, airline, status,
       RANK() OVER (PARTITION BY airline ORDER BY departure_time) AS flight_rank
FROM flights
WHERE status = 'Delayed';

