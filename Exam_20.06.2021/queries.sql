INSERT INTO clients (full_name, phone_number)
SELECT CONCAT(d.first_name, ' ', d.last_name), CONCAT('(088) 9999', (d.id * 2))
FROM drivers AS d
WHERE id BETWEEN 10 AND 20;

UPDATE cars AS c
SET c.`condition` = 'C'
WHERE c.`mileage` > 800000 or c.`mileage` IS NULL
AND c.`year` < 2010
AND c.`make` != 'Mercedes-Benz';

DELETE FROM clients
WHERE clients.id NOT IN (SELECT client_id FROM courses)
AND char_length(clients.full_name) > 3;


SELECT make, model, `condition`
FROM cars
ORDER BY id;

SELECT d.first_name, d.last_name, c.make, c.model, c.mileage
FROM drivers AS d
JOIN cars_drivers as cd
ON d.id = cd.driver_id
JOIN cars AS c
ON c.id = cd.car_id
WHERE c.mileage IS NOT NULL
ORDER BY c.mileage DESC, d.first_name;

SELECT c.id AS cars_id, c.make, c.mileage, COUNT(cr.id) AS count_of_courses,
 ROUND(AVG(cr.bill), 2) AS avg_bill
FROM cars AS c
LEFT JOIN courses AS cr
ON c.id = cr.car_id
GROUP BY c.id
HAVING count_of_courses <> 2
ORDER BY count_of_courses DESC, c.id;

SELECT c.full_name, COUNT(cars.id) AS count_of_cars, SUM(cr.bill) AS total_sum
FROM clients AS c
JOIN courses AS cr
ON c.id = cr.client_id
JOIN cars
ON cr.car_id = cars.id
GROUP BY c.id
HAVING c.full_name LIKE '_a%'
AND count_of_cars > 1
ORDER BY c.full_name;

SELECT a.`name` AS `name`, IF(HOUR(cr.`start`) >= 6 AND HOUR(cr.`start`) <= 20, 'Day', 'Night')
 AS day_time, SUM(cr.bill) AS bill, c.full_name, cars.make, cars.model, ca.`name` AS category_name
FROM addresses AS a
JOIN courses AS cr
ON cr.from_address_id = a.id
JOIN clients AS c
ON c.id = cr.client_id
JOIN cars
ON cr.car_id = cars.id
JOIN categories AS ca
ON ca.id = cars.category_id
GROUP BY cr.id
ORDER BY cr.id;

DELIMITER $
CREATE FUNCTION udf_courses_by_client (phone_num VARCHAR (20))
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN (SELECT COUNT(cr.id) FROM clients AS c
    JOIN courses AS cr
    ON c.id = cr.client_id
    WHERE c.phone_number = phone_num);
END $
DELIMITER ;

DELIMITER $
CREATE PROCEDURE udp_courses_by_address (address_name VARCHAR (100))
DETERMINISTIC
BEGIN
	SELECT a.`name`, cl.full_name, 
    (CASE
		WHEN cr.bill < 20 THEN 'Low'
        WHEN cr.bill < 30 THEN 'Medium'
        ELSE 'High'
	END) AS level_of_bill,
    c.make, c.`condition`, ca.`name` AS cat_name
    FROM addresses AS a
    JOIN courses AS cr
    ON cr.from_address_id = a.id
    JOIN cars AS c
    ON cr.car_id = c.id
    JOIN clients AS cl
    ON cr.client_id = cl.id
    JOIN categories AS ca
    ON c.category_id = ca.id
    WHERE a.`name` = address_name
    ORDER BY c.make, cl.full_name;
END $
DELIMITER ;