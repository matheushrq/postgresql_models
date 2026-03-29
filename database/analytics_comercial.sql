create table clientes(
	id_cliente int primary key,
	nome varchar(100) not null,
	email varchar(100) not null unique,
	cidade varchar(100) not null,
	estado char(2) not null,
	data_cadastro date not null
);

create table vendedores(
	id_vendedor int primary key,
	nome varchar(100) not null,
	email varchar(100) not null,
	regiao varchar(50) not null,
	data_admissao date not null
);

create table categorias(
	id_categoria int primary key,
	nome_categoria varchar(50) not null
);

create table produtos(
	id_produto int primary key,
	nome_produto varchar(100) not null,
	id_categoria int not null,
	preco_unitario decimal(10,2) not null,
	estoque int not null,
	foreign key (id_categoria) references categorias(id_categoria)
);

create table pedidos(
	id_pedido int primary key,
	id_cliente int not null,
	id_vendedor int not null,
	data_pedido date not null,
	status_pedido varchar(50) not null,
	valor_total decimal(10,2) not null,
	foreign key(id_cliente) references clientes(id_cliente),
	foreign key(id_vendedor) references vendedores(id_vendedor)
);

create table itens_pedido(
	id_item int primary key,
	id_pedido int not null,
	id_produto int not null,
	quantidade int not null,
	preco_unitario decimal(10,2),
	subtotal decimal(10,2),
	foreign key(id_pedido) references pedidos(id_pedido),
	foreign key(id_produto) references produtos(id_produto)
);

insert into categorias(id_categoria, nome_categoria) values
(1, 'Eletrônicos'),
(2, 'Periféricos'),
(3, 'Mobiliário'),
(4, 'Armazenamento');

insert into vendedores(id_vendedor, nome, email, regiao, data_admissao) values
(1, 'Mariana Costa', 'mariana.costa@email.com', 'Sudeste', '2022-03-10'),
(2, 'Felipe Souza', 'felipe.souza@email.com', 'Sul', '2021-08-15'),
(3, 'Camila Rocha', 'camila.rocha@email.com', 'Nordeste', '2023-01-20'),
(4, 'Rafael Lima', 'rafael.lima@email.com', 'Centro-Oeste', '2020-11-05'),
(5, 'Patricia Gomes', 'patricia.gomes@email.com', 'Norte', '2022-06-01'),
(6, 'Lucas Martins', 'lucas.martins@email.com', 'Sudeste', '2024-02-12');

insert into clientes (id_cliente, nome, email, cidade, estado, data_cadastro) values
(1,'Carlos Silva','carlos.silva@email.com','Porto Alegre','RS', '2025-01-10'),
(2,'Ana Souza','ana.souza@email.com','Belo Horizonte','MG', '2025-02-14'),
(3,'Marcos Oliveira','marcos.oliveira@email.com','São Paulo','SP', '2025-03-02'),
(4,'Juliana Pereira','juliana.pereira@email.com','Rio de Janeiro','RJ', '2025-03-19'),
(5,'Fernando Costa','fernando.costa@email.com','Brasília','DF', '2025-04-05'),
(6,'Natalia Freitas','natalia.freitas@email.com','Recife','PE', '2025-04-22'),
(7,'Ricardo Mendes','ricardo.mendes@email.com','Florianópolis','SC', '2025-05-10'),
(8,'Juliana Alves','juliana.alves@email.com','Campo Grande','MT', '2025-05-27'),
(9,'Diego Santos','diego.santos@email.com','Belém','PA', '2025-06-11'),
(10,'Otavio Ribeiro','otavio.ribeiro@email.com','Manaus','AM', '2025-06-28'),
(11,'Paula Correia','paula.correia@email.com','Salvador','BA', '2025-07-08'),
(12,'Renato Carvalho','renato.carvalho@email.com','João Pessoa','PB', '2025-07-21'),
(13,'Sofia Araujo','sofia.araujo@email.com','Campinas','SP', '2025-08-03'),
(14,'Karina Lopes','karina.lopes@email.com','Curitiba','PR', '2025-09-01'),
(15,'Igor Pereira','igor.pereira@email.com','Goiânia','GO', '2025-09-19'),
(16,'Marcelo Teixeira','marcelo.teixeira@email.com','Tocantins','TO','2025-09-26'),
(17,'Carla Novais','carla.novais@email.com','Juiz de Fora','MG','2025-10-03'),
(18,'Pedro Augusto','pedro.augusto@email.com','Niterói','RJ','2025-10-21');

insert into produtos (id_produto, nome_produto, id_categoria, preco_unitario, estoque) values
(1,'Notebook Pro 15', 1, 3500.00, 15),
(2,'Mouse Sem Fio', 2, 80.00, 120),
(3,'Teclado Mecânico', 2, 150.00, 85),
(4,'Monitor 24 polegadas', 1, 900.00, 30),
(5,'Cadeira Ergonômica', 3, 1200.00, 20),
(6,'Mesa de Escritório', 3, 950.00, 12),
(7,'Headset Corporativo', 2, 220.00, 60),
(8,'Webcam HD', 2, 180.00, 40),
(9,'SSD 480GB', 4, 380.00, 50),
(10,'Impressora Multifuncional', 1, 650.00, 18);

insert into pedidos (id_pedido, id_cliente, id_vendedor, data_pedido, status_pedido, valor_total) values
(1, 1, 1, '2026-01-05', 'Concluído', 3660.00),
(2, 2, 2, '2026-01-06', 'Concluído', 2190.00),
(3, 3, 1, '2026-01-08', 'Concluído', 2150.00),
(4, 4, 3, '2026-01-10', 'Em transporte', 1920.00),
(5, 5, 2, '2026-01-12', 'Concluído', 4700.00),
(6, 6, 4, '2026-01-15', 'Pendente', 1700.00),
(7, 7, 1, '2026-01-18', 'Concluído', 1040.00),
(8, 8, 3, '2026-01-20', 'Concluído', 1160.00),
(9, 9, 4, '2026-01-22', 'Concluído', 7000.00),
(10, 10, 2, '2026-01-25', 'Em transporte', 4300.00),
(11, 11, 5, '2026-02-01', 'Em transporte', 1360.00),
(12, 12, 6, '2026-02-03', 'Concluído', 1190.00),
(13, 13, 1, '2026-02-07', 'Concluído', 1120.00),
(14, 14, 2, '2026-02-10', 'Concluído', 2400.00),
(15, 15, 3, '2026-02-12', 'Em transporte', 4920.00),
(16, 16, 4, '2026-02-15', 'Concluído', 1600.00),
(17, 17, 5, '2026-02-18', 'Concluído', 830.00),
(18, 18, 6, '2026-02-20', 'Pendente', 1640.00);

insert into itens_pedido (id_item, id_pedido, id_produto, quantidade, preco_unitario, subtotal) values
(1,1,1,1, 3500.00, 3500.00),
(2,1,2,2, 80.00, 80.00),
(3,2,4,2, 900.00, 1800.00),
(4,2,3,2, 150.00, 300.00),
(5,3,5,1, 1200.00, 1200.00),
(6,3,6,1, 950.00, 950.00),
(7,4,7,3, 220.00, 660.00),
(8,4,8,2, 180.00, 360.00),
(9,5,9,4, 300.00, 1200.00),
(10,5,1,1, 3500.00, 3500.00),
(11,6,10,2, 650.00, 1300.00),
(12,6,2,5, 80.00, 400.00),
(13,7,3,4, 150.00, 600.00),
(14,7,7,2, 220.00, 440.00),
(15,8,4,1, 900.00, 900.00),
(16,8,8,1, 180.00, 180.00),
(17,8,2,1, 80.00, 80.00),
(18,9,1,2, 3500.00, 7000.00),
(19,10,5,2, 1200.00, 2400.00),
(20,10,6,2, 950.00, 1900.00),
(21,11,9,3, 300.00, 900.00),
(22,11,3,2, 150.00, 300.00),
(23,11,2,2, 80.00, 160.00),
(24,12,10,1, 650.00, 650.00),
(25,12,8,3, 180.00, 540.00),
(26,13,7,4, 220.00, 880.00),
(27,13,2,3, 80.00, 240.00),
(28,14,4,2, 900.00, 1800.00),
(29,14,6,2, 950.00, 1900.00),
(30,15,3,4, 150.00, 600.00),
(31,15,5,3, 1200.00, 3600.00),
(32,16,8,2, 180.00, 360.00),
(33,16,2,5, 80.00, 400.00),
(34,17,3,2, 150.00, 300.00),
(35,18,10,3, 650.00, 1950.00),
(36,18,9,1, 300.00, 300.00);