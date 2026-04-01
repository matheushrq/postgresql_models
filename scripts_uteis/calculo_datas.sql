/* -- Cálculo de datas -- */

-- 1:
	SELECT '2024-11-08'::date - '2024-10-25'::date AS dias_diferenca; -- Resultado: 14

-- 2:
	SELECT AGE('2024-11-08'::date, '2024-10-25'::date); -- Resultado: "14 days"

-- 3:
	select extract(month from AGE(current_date, '2026-01-01')) as meses

-- 4:
	SELECT DATE_PART('day', AGE('2024-11-08'::date, '2024-10-25'::date)) AS dias; -- Resultado: 14

-- Formatação de datas
do $$
declare
	data_exp date := '20260228';

	begin
		select case
					when extract(day from age(@data_exp)) > 28 and extract(month from age(@data_exp)) = 2
						then cast(@data_exp as date, format(select @data_exp::date + interval '1 months';))
					else null
				end teste
	end $$