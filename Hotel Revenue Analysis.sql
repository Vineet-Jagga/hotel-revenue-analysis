-- what's the total revenue generated from the hotels
WITH hotels AS (
SELECT * FROM [2018]
UNION 
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)

SELECT ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights) * (daily_rate * (1 - discount))), 2) AS revenue
FROM hotels
LEFT JOIN market_segment ON hotels.market_segment = market_segment.market_segment;


-- How has our hotel revenue trended over the years? Is it growing or declining?
WITH hotels AS (
SELECT * FROM [2018]
UNION
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)

SELECT
  arrival_date_year,
  hotel,
  ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights) * (daily_rate * (1 - discount))), 2) AS revenue
FROM
  hotels
LEFT JOIN
  [market_segment] ON hotels.market_segment = [market_segment].market_segment
GROUP BY
  arrival_date_year,
  hotel
ORDER BY
  revenue DESC;


-- What is the revenue breakdown by hotel type? Are there any differences in revenue growth between the two hotel types?
WITH hotels AS (
SELECT * FROM [2018]
UNION
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)
  
SELECT
  hotel,
  ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights) * (daily_rate * (1 - Discount))), 2) AS revenue
FROM
  hotels
LEFT JOIN
  [market_segment] ON hotels.market_segment = [market_segment].market_segment
GROUP BY
  hotel;


-- What is the hotel type's average daily rate (ADR)?
WITH hotels AS (
SELECT * FROM [2018]
UNION
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)

SELECT ROUND(AVG(daily_rate), 2) AS Average_daily_rate
FROM hotels;


-- Calculate the average discount from the hotel chain
WITH hotels AS (
SELECT * FROM [2018]
UNION
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)

SELECT
  ROUND(AVG(Discount) * 100, 2) AS Average_discount_percentage
FROM
  hotels
LEFT JOIN
  [market_segment] ON hotels.market_segment = [market_segment].market_segment;


-- Identify any seasonal trends in hotel revenue, such as peak or low seasons?
WITH hotels AS (
  SELECT * FROM [2018]
  UNION 
  SELECT * FROM [2019]
  UNION 
  SELECT * FROM [2020]
)

SELECT 
	DATENAME(MONTH, reservation_status_date) AS reservation_month,
	ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights) * (daily_rate * (1 - Discount))), 2) AS revenue
FROM
	hotels
LEFT JOIN 
	[market_segment] ON [market_segment].market_segment = hotels.market_segment
GROUP BY 
	DATENAME(MONTH, reservation_status_date)
ORDER BY
	revenue DESC;


-- calculates the total number of nights stayed by guest
WITH hotels AS (
SELECT * FROM [2018]
UNION
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)

SELECT
	SUM(stays_in_week_nights ) + SUM(stays_in_weekend_nights) AS Total_nights
FROM hotels;


-- Count the number of required car parking spaces
WITH hotels AS (
SELECT * FROM [2018]
UNION
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)

SELECT COUNT(required_car_parking_spaces) AS Car_spaces
FROM hotels;


-- What is the market segment distribution revenue
WITH hotels AS (
SELECT * FROM [2018]
UNION
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)

SELECT [market_segment].market_segment, 
	ROUND(SUM((Stays_in_week_nights + stays_in_weekend_nights) * (daily_rate * (1 - discount))), 2) AS revenue
FROM hotels
LEFT JOIN 
	[market_segment] ON hotels.market_segment = [market_segment].market_segment
GROUP BY [market_segment].market_segment
ORDER BY revenue DESC;


-- Calculate the revenue by customer type.
WITH hotels AS (
SELECT * FROM [2018]
UNION
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)

SELECT
  customer_type,
  ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights) * (daily_rate * (1 - discount))), 2) AS revenue
FROM
  hotels
LEFT JOIN
  [market_segment] ON hotels.market_segment = [market_segment].market_segment
GROUP BY
  customer_type
ORDER BY
  revenue DESC;


-- Calculate the revenue, count of required car parking spaces, and parking percentage for each arrival year and hotel
WITH hotels AS (
SELECT * FROM [2018]
UNION
SELECT * FROM [2019]
UNION
SELECT * FROM [2020]
)

SELECT
  arrival_date_year,
  hotel,
  ROUND(SUM((stays_in_week_nights + stays_in_weekend_nights) * (daily_rate * (1 - discount))), 2) AS revenue,
  COUNT(required_car_parking_spaces) as required_car_parking_spaces,
  ROUND((SUM(required_car_parking_spaces) * 100.0) / SUM(stays_in_week_nights + stays_in_weekend_nights), 2) AS parking_percentage
FROM
  hotels
LEFT JOIN
  [market_segment] ON hotels.market_segment = [market_segment].market_segment
GROUP BY
  arrival_date_year,
  hotel
ORDER BY
  revenue DESC;