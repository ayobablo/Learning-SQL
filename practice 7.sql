-- OUTER JOINS
USE store;
select 
	c.customer_id,
	c.first_name,
    o.order_id
from orders o
right join customers c
	on o.customer_id = c.customer_id
order by c.customer_id

-- exercise
select  
	p.product_id,
    p.name,
    oit.quantity
from products p
left join order_items oit
	on p.product_id = oit.order_id
order by p.product_id

-- OUTER JOINS BETWEEN MULTIPLE TABLES
select 
	c.customer_id,
    c.first_name,
    o.order_id,
    sh.name as shipper
from customers c
left join orders o
	on c.customer_id = o.customer_id
left join shippers sh
	on o.shipper_id = sh.shipper_id
order by c.customer_id

-- exercise
select 
	o.order_date,
    o.order_id,
    c.first_name,
    sh.name as shipper,
    os.name as status
from customers c
right join orders o
	on c.customer_id = o.customer_id
left join shippers sh
	on o.shipper_id = sh.shipper_id
left join order_statuses os
	on o.status = os.order_status_id
order by o.order_date