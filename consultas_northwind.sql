select	distinct
		employee_id,
		title_of_courtesy,
		upper(last_name) || ', ' || first_name nome,
		to_char(birth_date, 'DD/MM/YYYY') birth_date,
		to_char(hire_date, 'DD/MM/YYYY') hire_date,
		city,
		extract(year from age(current_date, birth_date)) idade,
		extract(year from age(current_date, hire_date)) tempo_empresa,
		coalesce(region, 'LON') region,
		country
from	employees
limit 	10

-- window functions e CTE
with companhias as(
	select	distinct
			row_number() over(order by country) id_seq,
			customer_id,
			company_name 		empresa,
			contact_name 		administrador,
			contact_title 		cargo,
			city 				cidade,
			country pais
	from	customers
	limit	50
)

select	id_seq,
		empresa,
		administrador,
		cargo,
		cidade,
		pais
from	companhias
where	pais = 'Brazil'
and		cidade = 'Sao Paulo'

select	distinct
		row_number() over(order by o.order_id) id_seq,
		o.order_id,
		to_char(o.order_date, 'DD/MM/YYYY') order_date,
		to_char(o.required_date, 'DD/MM/YYYY') required_date,
		to_char(o.shipped_date, 'DD/MM/YYYY') shipped_date,
		extract(day from age(shipped_date, order_date)) || ' dias' prazo_entrega,
		p.product_name,
		p.unit_price,
		o.freight,
		o.ship_name,
		o.ship_address,
		o.ship_city,
		case
			when o.ship_city in ('Rio de Janeiro', 'Resende')
				then 'RJ'
			when o.ship_city in ('Sao Paulo', 'Campinas')
				then 'SP'
			else 'Outros'
		end state,
		o.ship_country,
		od.unit_price,
		p.quantity_per_unit,
		p.discontinued,
		od.quantity,
		case
			when od.quantity < 20
				then 'Estoque baixo'
			when od.quantity between 21 and 40
				then 'Estoque normal'
			else 'Estoque alto'
		end estoque,
		od.discount
from	orders o
join	order_details od
on		od.order_id = o.order_id
join	products p
on		p.product_id = od.product_id
where	p.discontinued not in (1)
and		o.ship_country = 'Brazil'
limit	100;

/*
	Possibilidade para calcular data:
	select	current_date::date - '2026/01/01'::date diff
*/