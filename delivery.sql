CREATE DATABASE delivery;
USE delivery;

CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    telefone VARCHAR(20)
);

CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2)
);

CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    data_pedido DATETIME,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    produto_id INT,
    quantidade INT,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

INSERT INTO clientes (nome, telefone)
VALUES 
('Maria', '99999-0000'),
('João', '88888-1111');

INSERT INTO produtos (nome, preco)
VALUES 
('Hamburguer', 20.00),
('Refrigerante', 5.00),
('Batata Frita', 10.00);

INSERT INTO pedidos (cliente_id, data_pedido)
VALUES 
(1, NOW()),
(2, NOW());

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade)
VALUES 
(1, 1, 2),
(1, 2, 1),
(2, 3, 1);

-- Consulta com JOIN
SELECT 
    c.nome AS cliente,
    p.id AS pedido,
    pr.nome AS produto,
    i.quantidade,
    (pr.preco * i.quantidade) AS total
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.id
JOIN itens_pedido i ON p.id = i.pedido_id
JOIN produtos pr ON i.produto_id = pr.id;

-- Total por pedido
SELECT 
    p.id AS pedido,
    c.nome,
    SUM(pr.preco * i.quantidade) AS total_pedido
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.id
JOIN itens_pedido i ON p.id = i.pedido_id
JOIN produtos pr ON i.produto_id = pr.id
GROUP BY p.id, c.nome;