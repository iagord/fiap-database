--CRIAÇÃO DAS TABELAS

--Criação da tabela endereço do fornecedor
CREATE TABLE tb_endereco_fornecedor (
    id_endereco_fornecedor    NUMBER(9) NOT NULL,
    id_fornecedor             NUMBER(10) NOT NULL,
    nm_logradouro_fornecedor  VARCHAR2(100) NOT NULL,
    nr_logradouro_fornecedor  NUMBER(7),
    ds_complemento_fornecedor VARCHAR2(30),
    nr_cep_fornecedor         NUMBER(8),
    nm_bairro_fornecedor      VARCHAR2(45) NOT NULL,
    nm_cidade_fornecedor      VARCHAR2(60) NOT NULL,
    nm_estado_fornecedor      VARCHAR2(30) NOT NULL
);
ALTER TABLE tb_endereco_fornecedor ADD CONSTRAINT tb_endereco_fornecedor_pk PRIMARY KEY ( id_endereco_fornecedor );

--Criação da tabela endereço do usuário
CREATE TABLE tb_endereco_usuario (
    id_endereco_usuario    NUMBER(9) NOT NULL,
    id_usuario             NUMBER(10) NOT NULL,
    nm_logradouro_usuario  VARCHAR2(100) NOT NULL,
    nr_logradouro_usuario  NUMBER(7),
    ds_complemento_usuario VARCHAR2(30),
    nr_cep_usuario         NUMBER(8) NOT NULL,
    nm_bairro_usuario      VARCHAR2(45) NOT NULL,
    nm_cidade_usuario      VARCHAR2(60) NOT NULL,
    nm_estado_usuario      VARCHAR2(30) NOT NULL
);

ALTER TABLE tb_endereco_usuario ADD CONSTRAINT tb_endereco_usuario_pk PRIMARY KEY ( id_endereco_usuario );

--Criação da tabela fornecedor
CREATE TABLE tb_fornecedor (
    id_fornecedor          NUMBER(10) NOT NULL,
    nr_cnpj_fornecedor     NUMBER(14) NOT NULL,
    nm_fantasia_fornecedor VARCHAR2(80) NOT NULL
);

ALTER TABLE tb_fornecedor ADD CONSTRAINT tb_fornecedor_pk PRIMARY KEY ( id_fornecedor );

--Criação da tabela material
CREATE TABLE tb_material (
    id_material       NUMBER(10) NOT NULL,
    id_fornecedor     NUMBER(10) NOT NULL,
    nr_qt_material    NUMBER(10) NOT NULL,
    nr_valor_material NUMBER(10) NOT NULL
);

ALTER TABLE tb_material ADD CONSTRAINT tb_material_pk PRIMARY KEY ( id_material );

--Criação da tabela pedido
CREATE TABLE tb_pedido (
    id_pedido          NUMBER(10) NOT NULL,
    id_usuario         NUMBER(10) NOT NULL,
    id_material        NUMBER(10) NOT NULL,
    nr_nota_fiscal     NUMBER(30) NOT NULL,
    nr_qt_itens_totais NUMBER(5) NOT NULL,
    nr_valor_total     NUMBER(6) NOT NULL
);

ALTER TABLE tb_pedido ADD CONSTRAINT tb_pedido_pk PRIMARY KEY ( id_pedido );

--Criação da tabela usuário
CREATE TABLE tb_usuario (
    id_usuario          NUMBER(10) NOT NULL,
    nr_cnpj_usuario     NUMBER(14) NOT NULL,
    nm_fantasia_usuario VARCHAR2(80) NOT NULL
);
ALTER TABLE tb_usuario ADD CONSTRAINT tb_usuario_pk PRIMARY KEY ( id_usuario );


--Criação das Foreign Keys
ALTER TABLE tb_endereco_fornecedor
    ADD CONSTRAINT tb_end_forn_tb_forn_fk FOREIGN KEY ( id_fornecedor )
        REFERENCES tb_fornecedor ( id_fornecedor );

ALTER TABLE tb_endereco_usuario
    ADD CONSTRAINT tb_end_usu_tb_usu_fk FOREIGN KEY ( id_usuario )
        REFERENCES tb_usuario ( id_usuario );

ALTER TABLE tb_material
    ADD CONSTRAINT tb_material_tb_fornecedor_fk FOREIGN KEY ( id_fornecedor )
        REFERENCES tb_fornecedor ( id_fornecedor );

ALTER TABLE tb_pedido
    ADD CONSTRAINT tb_pedido_tb_material_fk FOREIGN KEY ( id_material )
        REFERENCES tb_material ( id_material );

ALTER TABLE tb_pedido
    ADD CONSTRAINT tb_pedido_tb_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES tb_usuario ( id_usuario );

--INSERÇÃO DE DADOS

-- Inserindo dados na tabela tb_endereco_fornecedor
INSERT INTO tb_endereco_fornecedor (id_endereco_fornecedor, id_fornecedor, nm_logradouro_fornecedor, nr_logradouro_fornecedor, ds_complemento_fornecedor, nr_cep_fornecedor, nm_bairro_fornecedor, nm_cidade_fornecedor, nm_estado_fornecedor)
VALUES (1, 1, 'Rua A', 123, 'Apt 101', 12345678, 'Bairro A', 'Cidade A', 'Estado A');

INSERT INTO tb_endereco_fornecedor (id_endereco_fornecedor, id_fornecedor, nm_logradouro_fornecedor, nr_logradouro_fornecedor, ds_complemento_fornecedor, nr_cep_fornecedor, nm_bairro_fornecedor, nm_cidade_fornecedor, nm_estado_fornecedor)
VALUES (2, 1, 'Rua B', 456, NULL, 23456789, 'Bairro B', 'Cidade B', 'Estado B');

INSERT INTO tb_endereco_fornecedor (id_endereco_fornecedor, id_fornecedor, nm_logradouro_fornecedor, nr_logradouro_fornecedor, ds_complemento_fornecedor, nr_cep_fornecedor, nm_bairro_fornecedor, nm_cidade_fornecedor, nm_estado_fornecedor)
VALUES (3, 2, 'Rua X', 789, 'Casa 2', 34567890, 'Bairro X', 'Cidade X', 'Estado X');

INSERT INTO tb_endereco_fornecedor (id_endereco_fornecedor, id_fornecedor, nm_logradouro_fornecedor, nr_logradouro_fornecedor, ds_complemento_fornecedor, nr_cep_fornecedor, nm_bairro_fornecedor, nm_cidade_fornecedor, nm_estado_fornecedor)
VALUES (4, 3, 'Rua Y', 111, 'Sala 5', 45678901, 'Bairro Y', 'Cidade Y', 'Estado Y');

INSERT INTO tb_endereco_fornecedor (id_endereco_fornecedor, id_fornecedor, nm_logradouro_fornecedor, nr_logradouro_fornecedor, ds_complemento_fornecedor, nr_cep_fornecedor, nm_bairro_fornecedor, nm_cidade_fornecedor, nm_estado_fornecedor)
VALUES (5, 4, 'Rua Z', 222, 'Apt 303', 56789012, 'Bairro Z', 'Cidade Z', 'Estado Z');

-- Inserindo dados na tabela tb_endereco_usuario
INSERT INTO tb_endereco_usuario (id_endereco_usuario, id_usuario, nm_logradouro_usuario, nr_logradouro_usuario, ds_complemento_usuario, nr_cep_usuario, nm_bairro_usuario, nm_cidade_usuario, nm_estado_usuario)
VALUES (1, 1, 'Rua A', 123, 'Apt 101', 12345678, 'Bairro A', 'Cidade A', 'Estado A');

INSERT INTO tb_endereco_usuario (id_endereco_usuario, id_usuario, nm_logradouro_usuario, nr_logradouro_usuario, ds_complemento_usuario, nr_cep_usuario, nm_bairro_usuario, nm_cidade_usuario, nm_estado_usuario)
VALUES (2, 1, 'Rua B', 456, NULL, 23456789, 'Bairro B', 'Cidade B', 'Estado B');

INSERT INTO tb_endereco_usuario (id_endereco_usuario, id_usuario, nm_logradouro_usuario, nr_logradouro_usuario, ds_complemento_usuario, nr_cep_usuario, nm_bairro_usuario, nm_cidade_usuario, nm_estado_usuario)
VALUES (3, 2, 'Rua X', 789, 'Casa 2', 34567890, 'Bairro X', 'Cidade X', 'Estado X');

INSERT INTO tb_endereco_usuario (id_endereco_usuario, id_usuario, nm_logradouro_usuario, nr_logradouro_usuario, ds_complemento_usuario, nr_cep_usuario, nm_bairro_usuario, nm_cidade_usuario, nm_estado_usuario)
VALUES (4, 3, 'Rua Y', 111, 'Sala 5', 45678901, 'Bairro Y', 'Cidade Y', 'Estado Y');

INSERT INTO tb_endereco_usuario (id_endereco_usuario, id_usuario, nm_logradouro_usuario, nr_logradouro_usuario, ds_complemento_usuario, nr_cep_usuario, nm_bairro_usuario, nm_cidade_usuario, nm_estado_usuario)
VALUES (5, 4, 'Rua Z', 222, 'Apt 303', 56789012, 'Bairro Z', 'Cidade Z', 'Estado Z');

-- Inserindo dados na tabela tb_fornecedor
INSERT INTO tb_fornecedor (id_fornecedor, nr_cnpj_fornecedor, nm_fantasia_fornecedor)
VALUES (1, 12345678901234, 'Fornecedor A');

INSERT INTO tb_fornecedor (id_fornecedor, nr_cnpj_fornecedor, nm_fantasia_fornecedor)
VALUES (2, 98765432109876, 'Fornecedor B');

INSERT INTO tb_fornecedor (id_fornecedor, nr_cnpj_fornecedor, nm_fantasia_fornecedor)
VALUES (3, 55555555555555, 'Fornecedor C');

INSERT INTO tb_fornecedor (id_fornecedor, nr_cnpj_fornecedor, nm_fantasia_fornecedor)
VALUES (4, 11111111111111, 'Fornecedor D');

INSERT INTO tb_fornecedor (id_fornecedor, nr_cnpj_fornecedor, nm_fantasia_fornecedor)
VALUES (5, 99999999999999, 'Fornecedor E');

-- Inserindo dados na tabela tb_material
INSERT INTO tb_material (id_material, id_fornecedor, nr_qt_material, nr_valor_material)
VALUES (1, 1, 100, 50.00);

INSERT INTO tb_material (id_material, id_fornecedor, nr_qt_material, nr_valor_material)
VALUES (2, 2, 200, 30.00);

INSERT INTO tb_material (id_material, id_fornecedor, nr_qt_material, nr_valor_material)
VALUES (3, 3, 150, 45.00);

INSERT INTO tb_material (id_material, id_fornecedor, nr_qt_material, nr_valor_material)
VALUES (4, 4, 300, 25.00);

INSERT INTO tb_material (id_material, id_fornecedor, nr_qt_material, nr_valor_material)
VALUES (5, 5, 250, 35.00);

-- Inserindo dados na tabela tb_pedido
INSERT INTO tb_pedido (id_pedido, id_usuario, id_material, nr_nota_fiscal, nr_qt_itens_totais, nr_valor_total)
VALUES (1, 1, 1, 001, 10, 500.00);

INSERT INTO tb_pedido (id_pedido, id_usuario, id_material, nr_nota_fiscal, nr_qt_itens_totais, nr_valor_total)
VALUES (2, 2, 2, 002, 15, 450.00);

INSERT INTO tb_pedido (id_pedido, id_usuario, id_material, nr_nota_fiscal, nr_qt_itens_totais, nr_valor_total)
VALUES (3, 3, 3, 003, 12, 540.00);

INSERT INTO tb_pedido (id_pedido, id_usuario, id_material, nr_nota_fiscal, nr_qt_itens_totais, nr_valor_total)
VALUES (4, 4, 4, 004, 18, 450.00);

INSERT INTO tb_pedido (id_pedido, id_usuario, id_material, nr_nota_fiscal, nr_qt_itens_totais, nr_valor_total)
VALUES (5, 5, 5, 005, 14, 490.00);

-- Inserindo dados na tabela tb_usuario
INSERT INTO tb_usuario (id_usuario, nr_cnpj_usuario, nm_fantasia_usuario)
VALUES (1, 12345678901234, 'Empresa A');

INSERT INTO tb_usuario (id_usuario, nr_cnpj_usuario, nm_fantasia_usuario)
VALUES (2, 98765432109876, 'Empresa B');

INSERT INTO tb_usuario (id_usuario, nr_cnpj_usuario, nm_fantasia_usuario)
VALUES (3, 55555555555555, 'Empresa C');

INSERT INTO tb_usuario (id_usuario, nr_cnpj_usuario, nm_fantasia_usuario)
VALUES (4, 11111111111111, 'Empresa D');

INSERT INTO tb_usuario (id_usuario, nr_cnpj_usuario, nm_fantasia_usuario)
VALUES (5, 99999999999999, 'Empresa E');

--CONSULTA COM PELO MENOS 2 JOINS MOSTRANDO DADOS INSERIDOS
SELECT
    p.id_pedido,
    u.nm_fantasia_usuario AS nome_usuario,
    f.nm_fantasia_fornecedor AS nome_fornecedor,
    m.nr_qt_material AS quantidade_material,
    m.nr_valor_material AS valor_unitario,
    p.nr_qt_itens_totais AS quantidade_itens,
    p.nr_valor_total AS valor_total,
    p.nr_nota_fiscal AS nota_fiscal
FROM tb_pedido p
INNER JOIN tb_usuario u ON p.id_usuario = u.id_usuario
INNER JOIN tb_material m ON p.id_material = m.id_material
INNER JOIN tb_fornecedor f ON m.id_fornecedor = f.id_fornecedor;
