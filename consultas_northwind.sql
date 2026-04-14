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
			--percent_rank() over(order by country) percent_r,
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
		--percent_r,
		empresa,
		administrador,
		cargo,
		cidade,
		pais
from	companhias
where	pais = 'Brazil'
and		cidade = 'Sao Paulo'

with compras_brasil as(
	select	distinct
			row_number() over(order by o.order_id) id_seq,
			o.order_id numero_ordem,
			to_char(o.order_date, 'DD/MM/YYYY') data_pedido,
			to_char(o.required_date, 'DD/MM/YYYY') data_requerida,
			to_char(o.shipped_date, 'DD/MM/YYYY') data_envio,
			extract(day from age(shipped_date, order_date)) || ' dias' prazo_envio,
			case
				when extract(day from age(shipped_date, order_date)) < 5
					then 'Antes do prazo'
				when extract(day from age(shipped_date, order_date)) between 5 and 10
					then 'Dentro do prazo'
				when extract(day from age(shipped_date, order_date)) > 10
					then 'Atrasado'
				else null
			end prazo,
			p.product_name nome_produto,
			p.unit_price preco_unitario_produto,
			o.freight frete,
			o.ship_name estabelecimento,
			o.ship_address endereco,
			o.ship_city cidade,
			case
				when o.ship_city in ('Rio de Janeiro', 'Resende')
					then 'RJ'
				when o.ship_city in ('Sao Paulo', 'Campinas')
					then 'SP'
				else 'Outros'
			end estado,
			o.ship_country pais,
			od.unit_price preco_unitario_compra,
			p.quantity_per_unit qtd_unidade,
			od.quantity,
			case
				when od.quantity < 20
					then 'Estoque baixo'
				when od.quantity between 21 and 40
					then 'Estoque normal'
				else 'Estoque alto'
			end estoque,
			od.discount desconto
	from	orders o
	join	order_details od
	on		od.order_id = o.order_id
	join	products p
	on		p.product_id = od.product_id
	where	p.discontinued not in (1)
	and		o.ship_country = 'Brazil'
	limit	100
)
select	*
from	compras_brasil
where	right(endereco, 3) = '267'

-- criação de perfil
select	orders, count(*)
from	(
	select	customer_id, count(order_id) orders
	from	orders
	group	by 1
)
group	by 1;

-- bins
select	123456.789,
		round(123456.789, 2),
		round(123456.789, 1),
		round(123456.789, 0),
		round(123456.789, -1),
		round(123456.789, -2)

-- log
select	1,
		log(1),
		log(10),
		log(100),
		log(1000),
		log(10000)