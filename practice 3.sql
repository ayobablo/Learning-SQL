-- The REGEXP --
-- use sakila;
-- select * from customer
-- first name contains AR or IT
-- where first_name regexp 'AR|IT'

-- last name starts with car
-- where last_name regexp '^car'

-- first name ends with ith
-- where first_name regexp 'ith$'

-- the letters g,e are combined with into i
-- where last_name regexp '[g,e]i'

-- the letters a-f are combined with into u
-- where first_name regexp '[a-f]u'

-- last name contains field, mac or rose
-- where last_name regexp 'field|mac|rose'

--  IS NULL --
use classicmodels;
-- select * from customers
-- where addressLine2 is null
-- where (addressLine2 and state) is null
-- where (addressLine2|state) is null
-- where state is not null
-- where postalCode is null

-- select * from orders
-- where comments is null
