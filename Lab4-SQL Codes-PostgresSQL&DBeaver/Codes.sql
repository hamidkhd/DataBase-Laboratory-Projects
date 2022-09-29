----- Q1
select r.region_description, t.territory_description
from region as r
inner join territories as t on r.region_id = t.region_id


----- Q2
select r.region_description, count(et.employee_id)
from region as r
inner join territories as t on r.region_id = t.region_id
inner join employee_territories as et on t.territory_id = et.territory_id
group by r.region_id


----- Q3
select od.order_id, sum(od.quantity * od.unit_price * (1 - od.discount))
from order_details as od
group by od.order_id


----- Q4
select od.product_id, sum(od.quantity)
from order_details as od
group by od.product_id 
order by sum(od.quantity) desc
limit 10


----- Q5-1
select p.product_id
from products as p
where p.product_id not in (
	select od.product_id
	from order_details as od
)

----- Q5-2
select od.product_id, sum(od.quantity)
from order_details as od
group by od.product_id 
having sum(od.quantity) = 0



----- Q6
select p.product_id, p.product_name, count(od.order_id)
from products as p
left join order_details as od on p.product_id = od.product_id
group by p.product_id




----- Q7
with order_cost as (
	select od.order_id, sum(od.quantity * od.unit_price * (1 - od.discount)) as total_price
	from order_details as od
	group by od.order_id	
	)
select e.employee_id, e.first_name, e.last_name, e.address, e.postal_code, sum(oc.total_price)
from employees as e
inner join orders as o on e.employee_id = o.employee_id
inner join order_cost as oc on o.order_id = oc.order_id
where date_part('year', o.order_date) = 1998
group by e.employee_id
order by sum(oc.total_price) desc
limit 1



----- Q8
select o.order_id, o.order_date, o.shipped_date,
	case
		when (o.shipped_date::date - o.order_date::date) = 0 then 'Excellent'
		when (o.shipped_date::date - o.order_date::date) <= 3 then 'Good'
		else 'Inappropriate'
	end as label
from orders as o



----- Q9
with recursive reports_log as (
	select e.employee_id, e.reports_to
	from employees as e
	where e.employee_id = 9
    union 
    	select e.employee_id, e.reports_to
		from employees as e
		inner join reports_log as rl on e.reports_to = rl.employee_id
)	
select *
from reports_log



----- Q10
with annual_sales as (
	select distinct date(o.shipped_date) as ShippedDate, o.order_id, b.Subtotal, date_part('year', o.shipped_date) as ShippedYear
	from orders o
	inner join (
		select distinct od.order_id, sum(od.unit_price * od.quantity) as Subtotal
 		from order_details as od
 		group by od.order_id
	) as b on o.order_id = b.order_id
where o.shipped_date is not null 
order by o.shipped_date
)
select a.ShippedYear, sum(a.Subtotal)
from annual_sales as a
group by a.ShippedYear 


----- Q11
create view products_to_buy as
	select p.product_id, p.product_name, p.supplier_id, p.quantity_per_unit, p.units_in_stock, p.reorder_level
	from products as p
	where p.units_in_stock < p.reorder_level
	order by p.units_in_stock
	
	
	
----- Q12 & Q13
select *
from categories as c
where c.category_id not in (
	select c.category_id
	from categories as c
	inner join products as p on c.category_id = p.category_id
	inner join order_details as od on p.product_id = od.product_id
	inner join orders as o on od.order_id = o.order_id
	where o.ship_country = 'France'
)



----- Q14
select *
from customers as c
where c.fax is null




----- Q15
create view age as
	select *, age(e.birth_date) as "age"
	from employees as e
	
select r.region_id, r.region_description, avg(a.age)
from region as r
inner join territories as t on r.region_id = t.region_id
inner join employee_territories as et on t.territory_id = et.territory_id
inner join age as a on et.employee_id = a.employee_id
group by r.region_id



