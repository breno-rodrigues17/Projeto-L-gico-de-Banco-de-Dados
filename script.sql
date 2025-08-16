-- ==============================================
-- Projeto de Banco de Dados: E-commerce (SQLite)
-- ==============================================
-- Criado para o desafio de modelagem lógica
-- Inclui: tabelas, dados de teste e queries complexas
-- ==============================================

-- ===========================
-- 1. Criação das Tabelas
-- ===========================

CREATE TABLE IF NOT EXISTS Cliente (
    cliente_id INTEGER PRIMARY KEY AUTOINCREMENT,
    tipo_cliente TEXT NOT NULL CHECK(tipo_cliente IN ('PF','PJ')),
    nome TEXT NOT NULL,
    cpf_cnpj TEXT UNIQUE NOT NULL,
    email TEXT,
    telefone TEXT
);

CREATE TABLE IF NOT EXISTS Fornecedor (
    fornecedor_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    contato TEXT
);

CREATE TABLE IF NOT EXISTS Produto (
    produto_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    descricao TEXT,
    preco REAL,
    estoque INTEGER
);

CREATE TABLE IF NOT EXISTS FornecedorProduto (
    fornecedor_id INTEGER,
    produto_id INTEGER,
    PRIMARY KEY (fornecedor_id, produto_id),
    FOREIGN KEY (fornecedor_id) REFERENCES Fornecedor(fornecedor_id),
    FOREIGN KEY (produto_id) REFERENCES Produto(produto_id)
);

CREATE TABLE IF NOT EXISTS Pedido (
    pedido_id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER,
    data_pedido TEXT,
    status_pedido TEXT,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id)
);

CREATE TABLE IF NOT EXISTS PedidoProduto (
    pedido_id INTEGER,
    produto_id INTEGER,
    quantidade INTEGER,
    preco_unitario REAL,
    PRIMARY KEY (pedido_id, produto_id),
    FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id),
    FOREIGN KEY (produto_id) REFERENCES Produto(produto_id)
);

CREATE TABLE IF NOT EXISTS Pagamento (
    pagamento_id INTEGER PRIMARY KEY AUTOINCREMENT,
    pedido_id INTEGER,
    tipo_pagamento TEXT,
    valor REAL,
    status_pagamento TEXT,
    FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id)
);

CREATE TABLE IF NOT EXISTS Entrega (
    entrega_id INTEGER PRIMARY KEY AUTOINCREMENT,
    pedido_id INTEGER,
    status_entrega TEXT,
    codigo_rastreamento TEXT,
    FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id)
);

-- ===========================
-- 2. Inserindo Dados de Teste
-- ===========================

-- Clientes PF e PJ
INSERT INTO Cliente (tipo_cliente, nome, cpf_cnpj, email, telefone) VALUES
('PF', 'João Silva', '123.456.789-00', 'joao@email.com', '11999990000'),
('PJ', 'Empresa XYZ', '12.345.678/0001-00', 'contato@xyz.com', '1133333000');

-- Fornecedores
INSERT INTO Fornecedor (nome, contato) VALUES
('Fornecedor A', 'fornecedorA@email.com'),
('Fornecedor B', 'fornecedorB@email.com');

-- Produtos
INSERT INTO Produto (nome, descricao, preco, estoque) VALUES
('Produto 1', 'Descrição 1', 50.00, 100),
('Produto 2', 'Descrição 2', 150.00, 50);

-- Relacionamento Fornecedor x Produto
INSERT INTO FornecedorProduto (fornecedor_id, produto_id) VALUES
(1,1),(1,2),(2,2);

-- Pedidos
INSERT INTO Pedido (cliente_id, data_pedido, status_pedido) VALUES
(1, '2025-08-16', 'Em andamento'),
(2, '2025-08-15', 'Concluído');

-- Produtos nos Pedidos
INSERT INTO PedidoProduto (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1,1,2,50.00),(1,2,1,150.00),(2,2,3,150.00);

-- Pagamentos
INSERT INTO Pagamento (pedido_id, tipo_pagamento, valor, status_pagamento) VALUES
(1, 'Cartão', 250.00, 'Aprovado'),
(2, 'Boleto', 450.00, 'Pago');

-- Entregas
INSERT INTO Entrega (pedido_id, status_entrega, codigo_rastreamento) VALUES
(1, 'Em trânsito', 'BR1234567890'),
(2, 'Entregue', 'BR0987654321');

-- ===========================
-- 3. Queries Complexas do Desafio
-- ===========================

-- 3.1 Recuperação simples
SELECT nome, email FROM Cliente;

-- 3.2 Filtro WHERE
SELECT * FROM Pedido WHERE status_pedido = 'Concluído';

-- 3.3 Atributo derivado: valor total do pedido
SELECT p.pedido_id, SUM(pp.quantidade * pp.preco_unitario) AS valor_total
FROM Pedido p
JOIN PedidoProduto pp ON p.pedido_id = pp.pedido_id
GROUP BY p.pedido_id;

-- 3.4 Ordenação: produtos mais caros
SELECT nome, preco FROM Produto ORDER BY preco DESC;

-- 3.5 Filtro em grupo (HAVING): clientes com mais de 1 pedido
SELECT c.nome, COUNT(p.pedido_id) AS total_pedidos
FROM Cliente c
JOIN Pedido p ON c.cliente_id = p.cliente_id
GROUP BY c.cliente_id
HAVING COUNT(p.pedido_id) > 1;

-- 3.6 Junção entre tabelas: cliente, pedido e valor total
SELECT c.nome AS cliente, p.pedido_id, SUM(pp.quantidade * pp.preco_unitario) AS valor_total
FROM Cliente c
JOIN Pedido p ON c.cliente_id = p.cliente_id
JOIN PedidoProduto pp ON p.pedido_id = pp.pedido_id
GROUP BY c.nome, p.pedido_id;

-- 3.7 Produtos e fornecedores
SELECT f.nome AS fornecedor, pr.nome AS produto
FROM Fornecedor f
JOIN FornecedorProduto fp ON f.fornecedor_id = fp.fornecedor_id
JOIN Produto pr ON fp.produto_id = pr.produto_id;
