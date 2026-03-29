-- 1 - Qual é o faturamento total da empresa?
select	sum(valor_total) faturamento
from	pedidos
where	status_pedido in ('Concluído', 'Em transporte')

-- 2 - Quais são os 5 produtos com maior faturamento?
select	distinct
		pr.nome_produto,
		sum(ip.subtotal) faturamento_produto
from	itens_pedido ip
join	pedidos pe
on		pe.id_pedido = ip.id_pedido
join	produtos pr
on		pr.id_produto = ip.id_produto
where	pe.status_pedido in ('Concluído', 'Em transporte')
group	by pr.nome_produto
order	by faturamento_produto desc
limit 	5

-- 3 - Quais produtos tiveram maior volume de unidades vendidas?
select	p.nome_produto,
		sum(ip.quantidade) total
from	produtos p
join	itens_pedido ip
on		ip.id_produto = p.id_produto
join	pedidos pe
on		pe.id_pedido = ip.id_pedido
where	status_pedido in ('Concluído', 'Em transporte')
group	by p.nome_produto
order	by total desc

-- 4 - Qual vendedor gerou mais receita em vendas?
select	v.nome,
		count(p.id_pedido) quantidade_pedidos,
		sum(p.valor_total) receita
from	vendedores v
join	pedidos p
on		p.id_vendedor = v.id_vendedor
where	p.status_pedido in ('Concluído', 'Em transporte')
group	by v.nome
order	by receita desc

-- 5 - Quais clientes mais compraram em valor total?
select	c.nome,
		c.cidade,
		c.estado,
		count(p.id_pedido) qtd,
		sum(p.valor_total) valor
from	clientes c
join	pedidos p
on		p.id_cliente = c.id_cliente
where	p.status_pedido in ('Concluído', 'Em transporte')
group	by c.nome, c.cidade, c.estado
order	by valor desc

-- 6 - Qual categoria de produto gera mais faturamento?
select	c.nome_categoria,
		sum(pe.valor_total) faturamento
from	itens_pedido ip
join	produtos p
on		p.id_produto = ip.id_produto
join	pedidos pe
on		pe.id_pedido = ip.id_pedido
join	categorias c
on		c.id_categoria = p.id_categoria
where	ip.status_pedido in ('Concluído', 'Em transporte')
group	by c.nome_categoria
order	by faturamento desc

-- 7 - Qual é o ticket médio dos pedidos?
select	round(avg(valor_total), 2) ticket_medio
from	pedidos

-- 8 - Quais produtos estão com estoque baixo?
select	nome_produto,
		preco_unitario,
		estoque
from	produtos
where	estoque < 20

-- 9 - Quantos pedidos cada vendedor atendeu?
select	v.nome,
		count(p.id_pedido) qtd
from	vendedores v
join	pedidos p
on		p.id_vendedor = v.id_vendedor
group	by v.nome
order	by qtd desc

-- 10 - Qual o faturamento por mês?
select	to_char(data_pedido, 'MM/YYYY') mes,
		sum(valor_total) faturamento
from	pedidos
where	status_pedido in ('Concluído', 'Em transporte')
group	by mes
order	by faturamento desc