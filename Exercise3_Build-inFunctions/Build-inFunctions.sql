-- Ex1
SELECT `first_name`, `last_name`
FROM `employees`
WHERE `first_name` LIKE 'Sa%'
ORDER BY `employee_id`;

-- Ex2
SELECT `first_name`, `last_name`
FROM `employees`
WHERE `last_name` LIKE '%ei%'
ORDER BY `employee_id`;

-- Ex3
SELECT `first_name`
FROM `employees`
WHERE `department_id` IN (3, 10) AND
YEAR(`hire_date`) BETWEEN 1995 AND 2005
ORDER BY `employee_id`;

-- Ex4
SELECT `first_name`, `last_name`
FROM `employees`
WHERE `job_title` NOT LIKE '%engineer%'
ORDER BY `employee_id`;

-- Ex5
SELECT `name`
FROM `towns`
WHERE char_length(`name`) = 5 OR char_length(`name`) = 6
ORDER BY `name`;

-- Ex6
SELECT `town_id`, `name`
FROM `towns`
WHERE left(`name`, 1) IN ('M', 'K', 'B', 'E')
ORDER BY `name`;

-- Ex7
SELECT `town_id`, `name`
FROM `towns`
WHERE left(`name`, 1) NOT IN ('R', 'B', 'D')
ORDER BY `name`;

-- Ex8
CREATE VIEW `v_employees_hired_after_2000` AS
SELECT `first_name`, `last_name`
FROM `employees`
WHERE YEAR(`hire_date`) > 2000;

SELECT * FROM `v_employees_hired_after_2000`;

-- Ex9
SELECT `first_name`, `last_name`
FROM `employees`
WHERE char_length(`last_name`) = 5;

USE `geography`;
-- Ex10
SELECT `country_name`, `iso_code`
FROM `continents`, `countries`
WHERE `continents`.`continent_code` = `countries`.`continent_code` AND
`country_name` LIKE '%A%A%A%'
ORDER BY `iso_code`;

-- Ex11
SELECT `peak_name`, `river_name`,
lower(concat(substring(`peak_name`, 1, char_length(`peak_name`) - 1), `river_name`))
AS `mix`
FROM `peaks`, `rivers`
WHERE right(`peaks`.`peak_name`, 1) = left(`rivers`.`river_name`, 1)
ORDER BY `mix`;

USE `diablo`;
-- Ex12
SELECT `name`, date_format(`start`, '%Y-%m-%d') AS `start`
FROM `games`
WHERE year(`start`) IN (2011, 2012)
ORDER BY `start`, `name`
LIMIT 50;

-- Ex13
SELECT `user_name`, substring(`email`, locate('@', `email`) + 1) AS `Email Provider`
FROM `users`
ORDER BY `Email Provider`, `user_name`;

-- Ex14
SELECT `user_name`, `ip_address`
FROM `users`
WHERE `ip_address` LIKE '___.1%.%.___' 
ORDER BY `user_name`;

-- Ex15
SELECT `name` AS `game`, 
CASE
    WHEN hour(`start`) BETWEEN 0 AND 11 THEN 'Morning'
    WHEN hour(`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN hour(`start`) BETWEEN 18 AND 23 THEN 'Evening'
END AS `Part of the Day`,
CASE
    WHEN `duration` <= 3 THEN 'Extra Short'
    WHEN `duration` BETWEEN 3 AND 6 THEN 'Short'
    WHEN `duration` BETWEEN 6 AND 10 THEN 'Long'
    ELSE 'Extra Long '
END  AS `Duration`
FROM `games`;

USE `orders`;
-- Ex16
SELECT `product_name`, `order_date`, 
date_add(`order_date`, INTERVAL 3 DAY) AS `pay_due`,
date_add(`order_date`, INTERVAL 1 MONTH) AS `deliver_due`
FROM `orders`;