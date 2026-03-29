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