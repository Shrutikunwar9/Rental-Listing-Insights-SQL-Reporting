CREATE DATABASE oyo_analytics;
USE oyo_analytics;

SELECT *
FROM oyo_hotel_rooms
limit 10;

# 1. Top Performing Locations by Rating

SELECT 
    Location, AVG(Rating) AS avg_rating, COUNT(*) AS hotel_count
FROM
    oyo_hotel_rooms
GROUP BY Location
HAVING COUNT(*) > 1
ORDER BY avg_rating DESC
LIMIT 5;

# 2. High-Rating, Low-Price Hotels (Hidden Gems)

SELECT 
    Hotel_name, Price, Rating
FROM
    oyo_hotel_rooms
WHERE
    Rating > 1000 AND Price < 2500
ORDER BY Rating DESC , Price ASC
LIMIT 10;

# 3. Price Sensitivity Buckets vs Ratings

SELECT 
    CASE
        WHEN Price < 2000 THEN 'Under 2000'
        WHEN Price BETWEEN 2000 AND 2500 THEN '2000-2500'
        WHEN Price BETWEEN 2501 AND 3000 THEN '2501-3000'
        ELSE 'Above 3000'
    END AS price_band,
    AVG(Rating) AS avg_rating,
    COUNT(*) AS total_hotels
FROM
    oyo_hotel_rooms
GROUP BY price_band
ORDER BY avg_rating DESC;

# 4. Potential Revenue Uplift from High-Rating Hotels

SELECT 
    Hotel_name,
    Price,
    Rating,
    CASE
        WHEN Rating > 1000 AND Price < 2500 THEN 'Can Increase Price'
        ELSE 'Price Optimal'
    END AS pricing_strategy
FROM
    oyo_hotel_rooms
ORDER BY Rating DESC;

# 5. Average Hotel Price in Mumbai

SELECT 
    AVG(Price) AS avg_price_mumbai
FROM
    oyo_hotel_rooms
WHERE
    Location LIKE '%Mumbai%';
    
# 6. Highest Rated Hotel

SELECT 
    Hotel_name, Rating
FROM
    oyo_hotel_rooms
ORDER BY Rating DESC
LIMIT 3;

# 7. Hotel with Maximum Discount

SELECT 
    Hotel_name, Discount
FROM
    oyo_hotel_rooms
ORDER BY CAST(REPLACE(Discount, '% off', '') AS UNSIGNED) DESC
LIMIT 3;

# 8. Average Rating by Location

SELECT 
    Location, AVG(Rating) AS avg_rating
FROM
    oyo_hotel_rooms
GROUP BY Location
ORDER BY avg_rating DESC;

# 9. Total Revenue (Post-Discount Approximation)

SELECT 
    SUM(Price * (1 - CAST(REPLACE(Discount, '% off', '') AS DECIMAL (5 , 2 )) / 100)) AS estimated_revenue
FROM
    oyo_hotel_rooms;

# 10. Total Number of Hotels Listed

SELECT 
    COUNT(*) AS total_hotels
FROM
    oyo_hotel_rooms;
    
# 11. Top 5 Most Reviewed Hotels

SELECT 
    Hotel_name, Rating
FROM
    oyo_hotel_rooms
ORDER BY Rating DESC
LIMIT 5;

# 12. Price Range Distribution

SELECT 
    price_segment, COUNT(*) AS hotel_count
FROM
    (SELECT 
        CASE
                WHEN Price < 2000 THEN 'Budget'
                WHEN Price BETWEEN 2000 AND 3000 THEN 'Mid-range'
                ELSE 'Premium'
            END AS price_segment
    FROM
        oyo_hotel_rooms) AS categorized
GROUP BY price_segment;

# 13. Count of Hotels per Discount Tier

SELECT 
    Discount, COUNT(*) AS hotel_count
FROM
    oyo_hotel_rooms
GROUP BY Discount
ORDER BY Discount DESC;

# 14. Duplicate Price-Rating Combos (Quality Control)

SELECT 
    Price, Rating, COUNT(*) AS duplicate_count
FROM
    oyo_hotel_rooms
GROUP BY Price , Rating
HAVING COUNT(*) > 1;



















