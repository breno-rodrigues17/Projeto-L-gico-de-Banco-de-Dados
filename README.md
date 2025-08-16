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
