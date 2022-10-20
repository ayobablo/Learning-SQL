-- Retrieving Data From Multuple Databases

-- USE classicmodels;
-- SELECT orderDate, shippedDate, status
-- FROM orders o
-- JOIN orderdetails od
	-- ON o.orderNumber = od.orderNumber
    
-- USE sakila;
-- SELECT country, city
-- FROM country
-- JOIN city
	-- ON country.country_id = city.country_id
    

-- SELF JOIN - JOINING A TABLE TO ITSELF
-- using the reportsTo as the maanger, check for the manager of each employee using the employeeNumber
-- USE classicmodels;
-- SELECT e.employeeNumber,
	-- CONCAT(e.lastName, ' ', e.firstName) AS employeeName,
	-- CONCAT(m.lastName, ' ', m.firstName) AS managerName
-- FROM employees e
-- JOIN employees m
	-- ON e.reportsTo = m.employeeNumber
    
    
-- JOINING MULTIPLE TABLES
-- USE classicmodels;
-- SELECT c.customerName,
-- p.paymentDate,
-- o.shippedDate, 
-- o.status
-- FROM customers c
-- JOIN payments p
	-- ON c.customerNumber = p.customerNumber
-- JOIN orders o
	-- ON c.customerNumber = o.customerNumber
    
-- COMPOUND JOIN CONDITIONS
SELECT * FROM classicmodels.orderdetails
JOIN 

