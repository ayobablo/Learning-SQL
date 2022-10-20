use sql_store;

select order_id, o.customer_id, first_name, last_name  
from orders o
join customers c
	on o.customer_id = c.customer_id;
    
-- exercise--
select order_id, oid.product_id, p.name, oid.quantity, oid.unit_price
from order_items oid
join products p
	on oid.product_id = p.product_id;
    
-- Self Join --
use sql_hr;
select e.employee_id, e.first_name, m.first_name as manager
from employees e
join employees m
	on e.reports_to = m.employee_id 
