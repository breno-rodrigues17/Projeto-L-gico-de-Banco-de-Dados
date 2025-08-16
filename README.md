📦 Projeto de Banco de Dados: E-commerce
📖 Descrição

Este projeto apresenta a modelagem lógica de um banco de dados para um sistema de e-commerce, desenvolvido em SQLite.
O objetivo é oferecer uma solução capaz de gerenciar clientes, pedidos, produtos, fornecedores, pagamentos e entregas de forma estruturada.

🎯 Funcionalidades do Modelo

Cadastro de Clientes (Pessoa Física e Jurídica).

Registro de Pedidos com múltiplos produtos.

Controle de fornecedores e produtos fornecidos.

Vários métodos de pagamento por pedido.

Registro de status e rastreamento de entrega.

Cálculo automático do valor total dos pedidos.

🗂️ Entidades e Relacionamentos
Entidades Principais

Cliente

cliente_id (PK)

tipo_cliente (PF/PJ)

nome, cpf_cnpj, email, telefone

Fornecedor

fornecedor_id (PK)

nome, contato

Produto

produto_id (PK)

nome, descricao, preco, estoque

Pedido

pedido_id (PK)

cliente_id (FK)

data_pedido, status_pedido

Pagamento

pagamento_id (PK)

pedido_id (FK)

tipo_pagamento, valor, status_pagamento

Entrega

entrega_id (PK)

pedido_id (FK)

status_entrega, codigo_rastreamento

Relacionamentos

PedidoProduto → Relacionamento N:M entre Pedido e Produto (quantidade, preco_unitario).

FornecedorProduto → Relacionamento N:M entre Fornecedor e Produto.

📊 Diagrama do Banco de Dados


O diagrama foi criado no Draw.io e exportado como imagem.

📝 Script SQL

O arquivo script.sql contém:

Criação das tabelas (com IF NOT EXISTS).

Inserção de dados de teste (clientes, fornecedores, produtos, pedidos, pagamentos e entregas).

Consultas SQL demonstrando:

SELECT simples.

Filtros com WHERE.

Atributos derivados (valor total do pedido).

Ordenação (ORDER BY).

Agrupamento com HAVING.

Junções entre tabelas (JOIN).

🔎 Exemplos de Consultas

1. Pedidos por cliente

SELECT c.nome, COUNT(p.pedido_id) AS total_pedidos
FROM Cliente c
JOIN Pedido p ON c.cliente_id = p.cliente_id
GROUP BY c.nome;


2. Valor total de cada pedido

SELECT p.pedido_id, SUM(pp.quantidade * pp.preco_unitario) AS valor_total
FROM Pedido p
JOIN PedidoProduto pp ON p.pedido_id = pp.pedido_id
GROUP BY p.pedido_id;


3. Produtos e seus fornecedores

SELECT f.nome AS fornecedor, pr.nome AS produto
FROM Fornecedor f
JOIN FornecedorProduto fp ON f.fornecedor_id = fp.fornecedor_id
JOIN Produto pr ON fp.produto_id = pr.produto_id;

🚀 Como Executar

Abra o arquivo script.sql no SQLiteOnline ou em outro cliente SQLite.

Execute todo o script para criar e popular o banco.

Rode as queries de teste para validar o funcionamento.

👤 Autor

Breno Rodrigues Bittencourt
Autor

Breno Rodrigues Bittencourt

