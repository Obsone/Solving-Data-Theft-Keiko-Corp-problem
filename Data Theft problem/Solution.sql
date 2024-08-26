/*
available Data
-- -74.997 to -74.9968 latitude
-- 40.5 to 40.6 longtitude
-- date 2020-06-23
*/

/*
clues
It's one of the employees
data breach happened during a certain time
you had to be on the location to steal the data
It's not the drivers
It's not the riders
It was an inside job
*/


CREATE VIEW suspected_rides AS
SELECT * FROM vehicle_location_histories AS vlh
WHERE
    city = 'new york' AND
    lat BETWEEN -74.997 AND -74.9968
    AND
    (long BETWEEN 40.5 AND 40.6)
    AND
    "vlh"."timestamp"::date = '2020-06-23'
ORDER BY long;

SELECT DISTINCT r.vehicle_id
FROM suspected_rides AS sr
JOIN rides AS r ON r.id = sr.ride_id;
-- 89 records of vehicle_id

SELECT DISTINCT r.vehicle_id, u.name AS "owner name", u.address, v.status, v.current_location
FROM suspected_rides AS sr
JOIN rides AS r ON r.id = sr.ride_id
JOIN vehicles AS v ON v.id = r.vehicle_id
JOIN users AS u ON u.id = v.owner_id;
--after questioning, it's not the drivers

SELECT DISTINCT r.vehicle_id, u.name AS "rider name", u.address
FROM suspected_rides AS sr
JOIN rides AS r ON r.id = sr.ride_id
JOIN users AS u ON u.id = r.rider_id;
--it's not the riders