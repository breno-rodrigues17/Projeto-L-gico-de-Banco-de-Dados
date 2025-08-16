# Projeto de Banco de Dados: E-commerce

## Descrição do Projeto

Este projeto consiste na modelagem lógica de um banco de dados para um **sistema de e-commerce**. O objetivo é controlar clientes, pedidos, produtos, fornecedores, pagamentos e entregas.  

O projeto contempla:

- Clientes **PF** (Pessoa Física) e **PJ** (Pessoa Jurídica)  
- Vários métodos de pagamento por pedido  
- Status e rastreamento de entrega  
- Relações entre fornecedores e produtos  
- Produtos em pedidos (itens, quantidade e preço unitário)  

O modelo foi criado em **SQLite**, permitindo execução online sem necessidade de instalação de servidor.

---

## Entidades e Relacionamentos

### Entidades Principais:

1. **Cliente**
   - `cliente_id` (PK)  
   - `tipo_cliente` (PF/PJ)  
   - `nome`, `cpf_cnpj`, `email`, `telefone`  

2. **Fornecedor**
   - `fornecedor_id` (PK)  
   - `nome`, `contato`  

3. **Produto**
   - `produto_id` (PK)  
   - `nome`, `descricao`, `preco`, `estoque`  

4. **Pedido**
   - `pedido_id` (PK)  
   - `cliente_id` (FK)  
   - `data_pedido`, `status_pedido`  

5. **Pagamento**
   - `pagamento_id` (PK)  
   - `pedido_id` (FK)  
   - `tipo_pagamento`, `valor`, `status_pagamento`  

6. **Entrega**
   - `entrega_id` (PK)  
   - `pedido_id` (FK)  
   - `status_entrega`, `codigo_rastreamento`  

### Relacionamentos:

- **PedidoProduto**: relacionamento N:M entre `Pedido` e `Produto` (quantidade e preço unitário)  
- **FornecedorProduto**: relacionamento N:M entre `Fornecedor` e `Produto`  

---

## Diagrama do Banco de Dados

![Diagrama do E-commerce](Esquema_Conceitual_Ecommerce.png)  

> Obs.: O diagrama foi criado no Draw.io e exportado como imagem PNG.

---

## Script SQL

O arquivo `script.sql` contém:

1. Criação de todas as tabelas (`IF NOT EXISTS`)  
2. Inserção de **dados de teste** (clientes PF/PJ, fornecedores, produtos, pedidos, pagamentos e entregas)  
3. Queries complexas exigidas pelo desafio, incluindo:  
   - SELECT simples  
   - Filtros com WHERE  
   - Atributos derivados (valor total do pedido)  
   - Ordenação com ORDER BY  
   - Filtros em grupo com HAVING  
   - Junções entre tabelas (JOIN)  

---

## Queries Exemplos

1. **Pedidos por cliente**  

SELECT c.nome, COUNT(p.pedido_id) AS total_pedidos
FROM Cliente c
JOIN Pedido p ON c.cliente_id = p.cliente_id
GROUP BY c.nome;


2. **Valor total de cada pedido**

SELECT p.pedido_id, SUM(pp.quantidade * pp.preco_unitario) AS valor_total
FROM Pedido p
JOIN PedidoProduto pp ON p.pedido_id = pp.pedido_id
GROUP BY p.pedido_id;

3. **Produto e Fornecedores**

SELECT f.nome AS fornecedor, pr.nome AS produto
FROM Fornecedor f
JOIN FornecedorProduto fp ON f.fornecedor_id = fp.fornecedor_id
JOIN Produto pr ON fp.produto_id = pr.produto_id;

Observações

Todo o projeto foi feito em SQLite, podendo ser executado em SQLiteOnline ou em qualquer cliente SQLite.
O banco está populado com dados de teste, permitindo validação das queries.
O diagrama no Draw.io ajuda a visualizar os relacionamentos e cardinalidades.

Como Testar

Abrir o arquivo script.sql no SQLiteOnline
Executar todo o script (criação de tabelas + INSERTs)
Rodar as queries de teste para validar o funcionamento

Autor
Breno Rodrigues Bittencourt