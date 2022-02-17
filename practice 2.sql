USE classicmodels;
-- SELECT * FROM customers
-- WHERE creditLimit > 100000 and country <> 'USA'
-- WHERE state NOT IN ('CA')
-- WHERE state IN ('CA', 'NY', 'CT')

-- SELECT * FROM products
-- WHERE quantityInStock BETWEEN 5000 AND 7000

-- SELECT * FROM orders
-- WHERE orderDate BETWEEN '2003-06-06' AND '2004-12-01'

SELECT * FROM customers
WHERE addressLine1 LIKE '%strong%'
-- WHERE phone LIKE ('%9')