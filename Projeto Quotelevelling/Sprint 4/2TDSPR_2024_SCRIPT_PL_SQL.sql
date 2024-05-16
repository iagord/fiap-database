CREATE TABLE tb_endereco (
    id_endereco                 NUMBER(9) NOT NULL,
    tb_fornecedor_id_fornecedor NUMBER(10) NOT NULL,
    nm_logradouro               VARCHAR2(100) NOT NULL,
    nr_logradouro               NUMBER(7),
    ds_complemento              VARCHAR2(30),
    nr_cep                      NUMBER(8),
    nm_bairro                   VARCHAR2(45) NOT NULL,
    nm_cidade                   VARCHAR2(60) NOT NULL,
    nm_estado                   VARCHAR2(30) NOT NULL,
    tb_usuario_id_usuario       NUMBER(10) NOT NULL
);

ALTER TABLE tb_endereco ADD CONSTRAINT tb_endereco_pk PRIMARY KEY ( id_endereco );

CREATE TABLE tb_fornecedor (
    id_fornecedor          NUMBER(10) NOT NULL,
    nr_cnpj_fornecedor     NUMBER(14) NOT NULL,
    nm_fantasia_fornecedor VARCHAR2(80) NOT NULL
);

ALTER TABLE tb_fornecedor ADD CONSTRAINT tb_fornecedor_pk PRIMARY KEY ( id_fornecedor );

CREATE TABLE tb_material (
    id_material                 NUMBER(10) NOT NULL,
    tb_fornecedor_id_fornecedor NUMBER(10) NOT NULL,
    nr_qt_material              NUMBER(10) NOT NULL,
    nr_valor_material           NUMBER(10) NOT NULL
);

ALTER TABLE tb_material ADD CONSTRAINT tb_material_pk PRIMARY KEY ( id_material );

CREATE TABLE tb_pedido (
    id_pedido               NUMBER(10) NOT NULL,
    tb_usuario_id_usuario   NUMBER(10) NOT NULL,
    tb_material_id_material NUMBER(10) NOT NULL,
    nr_nota_fiscal          NUMBER(30) NOT NULL,
    nr_qt_itens_totais      NUMBER(5) NOT NULL,
    nr_valor_total          NUMBER(6) NOT NULL
);

ALTER TABLE tb_pedido ADD CONSTRAINT tb_pedido_pk PRIMARY KEY ( id_pedido );

CREATE TABLE tb_usuario (
    id_usuario          NUMBER(10) NOT NULL,
    nr_cnpj_usuario     NUMBER(14) NOT NULL,
    nm_fantasia_usuario VARCHAR2(80) NOT NULL
);

ALTER TABLE tb_usuario ADD CONSTRAINT tb_usuario_pk PRIMARY KEY ( id_usuario );

ALTER TABLE tb_endereco
    ADD CONSTRAINT tb_endereco_tb_fornecedor_fk FOREIGN KEY ( tb_fornecedor_id_fornecedor )
        REFERENCES tb_fornecedor ( id_fornecedor );

ALTER TABLE tb_endereco
    ADD CONSTRAINT tb_endereco_tb_usuario_fk FOREIGN KEY ( tb_usuario_id_usuario )
        REFERENCES tb_usuario ( id_usuario );

ALTER TABLE tb_material
    ADD CONSTRAINT tb_material_tb_fornecedor_fk FOREIGN KEY ( tb_fornecedor_id_fornecedor )
        REFERENCES tb_fornecedor ( id_fornecedor );

ALTER TABLE tb_pedido
    ADD CONSTRAINT tb_pedido_tb_material_fk FOREIGN KEY ( tb_material_id_material )
        REFERENCES tb_material ( id_material );

ALTER TABLE tb_pedido
    ADD CONSTRAINT tb_pedido_tb_usuario_fk FOREIGN KEY ( tb_usuario_id_usuario )
        REFERENCES tb_usuario ( id_usuario );
        
CREATE TABLE tb_erros (
    codigo_erro     NUMBER,
    nome_erro       VARCHAR2(100),
    data_ocorrencia DATE,
    usuario_logado  VARCHAR2(100)
);
        
INSERT INTO tb_usuario (id_usuario, nr_cnpj_usuario, nm_fantasia_usuario)
VALUES (1, 11111111000111, 'Usuário A');

INSERT INTO tb_usuario (id_usuario, nr_cnpj_usuario, nm_fantasia_usuario)
VALUES (2, 22222222000122, 'Usuário B');

INSERT INTO tb_usuario (id_usuario, nr_cnpj_usuario, nm_fantasia_usuario)
VALUES (3, 33333333000133, 'Usuário C');

INSERT INTO tb_usuario (id_usuario, nr_cnpj_usuario, nm_fantasia_usuario)
VALUES (4, 44444444000144, 'Usuário D');

INSERT INTO tb_usuario (id_usuario, nr_cnpj_usuario, nm_fantasia_usuario)
VALUES (5, 55555555000155, 'Usuário E');

INSERT INTO tb_fornecedor (id_fornecedor, nr_cnpj_fornecedor, nm_fantasia_fornecedor)
VALUES (1, 12345678000199, 'Fornecedor A');

INSERT INTO tb_fornecedor (id_fornecedor, nr_cnpj_fornecedor, nm_fantasia_fornecedor)
VALUES (2, 98765432000188, 'Fornecedor B');

INSERT INTO tb_fornecedor (id_fornecedor, nr_cnpj_fornecedor, nm_fantasia_fornecedor)
VALUES (3, 11223344000177, 'Fornecedor C');

INSERT INTO tb_fornecedor (id_fornecedor, nr_cnpj_fornecedor, nm_fantasia_fornecedor)
VALUES (4, 22334455000166, 'Fornecedor D');

INSERT INTO tb_fornecedor (id_fornecedor, nr_cnpj_fornecedor, nm_fantasia_fornecedor)
VALUES (5, 33445566000155, 'Fornecedor E');

INSERT INTO tb_endereco (id_endereco, tb_fornecedor_id_fornecedor, nm_logradouro, nr_logradouro, ds_complemento, nr_cep, nm_bairro, nm_cidade, nm_estado, tb_usuario_id_usuario)
VALUES (1, 1, 'Rua das Flores', 123, 'Apto 101', 12345678, 'Centro', 'São Paulo', 'SP', 1);

INSERT INTO tb_endereco (id_endereco, tb_fornecedor_id_fornecedor, nm_logradouro, nr_logradouro, ds_complemento, nr_cep, nm_bairro, nm_cidade, nm_estado, tb_usuario_id_usuario)
VALUES (2, 2, 'Avenida Paulista', 456, 'Sala 200', 87654321, 'Bela Vista', 'São Paulo', 'SP', 2);

INSERT INTO tb_endereco (id_endereco, tb_fornecedor_id_fornecedor, nm_logradouro, nr_logradouro, ds_complemento, nr_cep, nm_bairro, nm_cidade, nm_estado, tb_usuario_id_usuario)
VALUES (3, 3, 'Rua XV de Novembro', 789, NULL, 12312312, 'Centro', 'Curitiba', 'PR', 3);

INSERT INTO tb_endereco (id_endereco, tb_fornecedor_id_fornecedor, nm_logradouro, nr_logradouro, ds_complemento, nr_cep, nm_bairro, nm_cidade, nm_estado, tb_usuario_id_usuario)
VALUES (4, 4, 'Avenida Rio Branco', 321, 'Bloco A', 98765432, 'Centro', 'Rio de Janeiro', 'RJ', 4);

INSERT INTO tb_endereco (id_endereco, tb_fornecedor_id_fornecedor, nm_logradouro, nr_logradouro, ds_complemento, nr_cep, nm_bairro, nm_cidade, nm_estado, tb_usuario_id_usuario)
VALUES (5, 5, 'Rua das Palmeiras', 654, 'Casa 2', 45678901, 'Jardim', 'Belo Horizonte', 'MG', 5);

INSERT INTO tb_material (id_material, tb_fornecedor_id_fornecedor, nr_qt_material, nr_valor_material)
VALUES (1, 1, 100, 5000);

INSERT INTO tb_material (id_material, tb_fornecedor_id_fornecedor, nr_qt_material, nr_valor_material)
VALUES (2, 2, 200, 10000);

INSERT INTO tb_material (id_material, tb_fornecedor_id_fornecedor, nr_qt_material, nr_valor_material)
VALUES (3, 3, 300, 15000);

INSERT INTO tb_material (id_material, tb_fornecedor_id_fornecedor, nr_qt_material, nr_valor_material)
VALUES (4, 4, 400, 20000);

INSERT INTO tb_material (id_material, tb_fornecedor_id_fornecedor, nr_qt_material, nr_valor_material)
VALUES (5, 5, 500, 25000);

INSERT INTO tb_pedido (id_pedido, tb_usuario_id_usuario, tb_material_id_material, nr_nota_fiscal, nr_qt_itens_totais, nr_valor_total)
VALUES (1, 1, 1, 12345, 10, 500);

INSERT INTO tb_pedido (id_pedido, tb_usuario_id_usuario, tb_material_id_material, nr_nota_fiscal, nr_qt_itens_totais, nr_valor_total)
VALUES (2, 2, 2, 12346, 20, 1000);

INSERT INTO tb_pedido (id_pedido, tb_usuario_id_usuario, tb_material_id_material, nr_nota_fiscal, nr_qt_itens_totais, nr_valor_total)
VALUES (3, 3, 3, 12347, 30, 1500);

INSERT INTO tb_pedido (id_pedido, tb_usuario_id_usuario, tb_material_id_material, nr_nota_fiscal, nr_qt_itens_totais, nr_valor_total)
VALUES (4, 4, 4, 12348, 40, 2000);

INSERT INTO tb_pedido (id_pedido, tb_usuario_id_usuario, tb_material_id_material, nr_nota_fiscal, nr_qt_itens_totais, nr_valor_total)
VALUES (5, 5, 5, 12349, 50, 2500);

CREATE OR REPLACE PROCEDURE relatorio_fornecedores IS
BEGIN
    FOR fornecedor IN (SELECT * FROM tb_fornecedor) LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || fornecedor.id_fornecedor || ', CNPJ: ' || fornecedor.nr_cnpj_fornecedor || ', Nome Fantasia: ' || fornecedor.nm_fantasia_fornecedor);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        INSERT INTO tb_erros (codigo_erro, nome_erro, data_ocorrencia, usuario_logado)
        VALUES (-20001, 'Erro ao gerar relatório de fornecedores', SYSDATE, USER);
END;

CREATE OR REPLACE PROCEDURE relatorio_pedidos IS
BEGIN
    FOR pedido IN (SELECT * FROM tb_pedido) LOOP
        DBMS_OUTPUT.PUT_LINE('ID Pedido: ' || pedido.id_pedido || ', ID Usuário: ' || pedido.tb_usuario_id_usuario || ', ID Material: ' || pedido.tb_material_id_material || ', Nota Fiscal: ' || pedido.nr_nota_fiscal || ', Qt. Itens: ' || pedido.nr_qt_itens_totais || ', Valor Total: ' || pedido.nr_valor_total);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        INSERT INTO tb_erros (codigo_erro, nome_erro, data_ocorrencia, usuario_logado)
        VALUES (-20002, 'Erro ao gerar relatório de pedidos', SYSDATE, USER);
END;

CREATE OR REPLACE FUNCTION validar_dados(
    p_id_pedido NUMBER
) RETURN BOOLEAN IS
    v_valido BOOLEAN := TRUE;
BEGIN
    IF p_id_pedido IS NULL THEN
        v_valido := FALSE;
    END IF;
    
    RETURN v_valido;
EXCEPTION
    WHEN OTHERS THEN
        INSERT INTO tb_erros (codigo_erro, nome_erro, data_ocorrencia, usuario_logado)
        VALUES (-20003, 'Erro na validação de dados', SYSDATE, USER);
        RETURN FALSE;
END;

CREATE OR REPLACE FUNCTION calcular_cotacao(
    p_valor_material NUMBER,
    p_qt_material NUMBER
) RETURN NUMBER IS
    v_cotacao NUMBER;
BEGIN
    IF p_valor_material IS NOT NULL AND p_qt_material IS NOT NULL THEN
        v_cotacao := p_valor_material * p_qt_material;
        RETURN v_cotacao;
    ELSE
        RAISE_APPLICATION_ERROR(-20004, 'Valor ou quantidade de material inválido');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        INSERT INTO tb_erros (codigo_erro, nome_erro, data_ocorrencia, usuario_logado)
        VALUES (-20004, 'Erro no cálculo da cotação', SYSDATE, USER);
        RETURN NULL;
END;

CREATE OR REPLACE PACKAGE pkg_relatorios AS
    PROCEDURE relatorio_fornecedores;
    PROCEDURE relatorio_pedidos;
    FUNCTION validar_dados(p_id_pedido NUMBER) RETURN BOOLEAN;
    FUNCTION calcular_cotacao(p_valor_material NUMBER, p_qt_material NUMBER) RETURN NUMBER;
END pkg_relatorios;

CREATE OR REPLACE PACKAGE BODY pkg_relatorios AS

    PROCEDURE relatorio_fornecedores IS
    BEGIN
        FOR fornecedor IN (SELECT * FROM tb_fornecedor) LOOP
            DBMS_OUTPUT.PUT_LINE('ID: ' || fornecedor.id_fornecedor || ', CNPJ: ' || fornecedor.nr_cnpj_fornecedor || ', Nome Fantasia: ' || fornecedor.nm_fantasia_fornecedor);
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            INSERT INTO tb_erros (codigo_erro, nome_erro, data_ocorrencia, usuario_logado)
            VALUES (-20001, 'Erro ao gerar relatório de fornecedores', SYSDATE, USER);
    END relatorio_fornecedores;

    PROCEDURE relatorio_pedidos IS
    BEGIN
        FOR pedido IN (SELECT * FROM tb_pedido) LOOP
            DBMS_OUTPUT.PUT_LINE('ID Pedido: ' || pedido.id_pedido || ', ID Usuário: ' || pedido.tb_usuario_id_usuario || ', ID Material: ' || pedido.tb_material_id_material || ', Nota Fiscal: ' || pedido.nr_nota_fiscal || ', Qt. Itens: ' || pedido.nr_qt_itens_totais || ', Valor Total: ' || pedido.nr_valor_total);
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            INSERT INTO tb_erros (codigo_erro, nome_erro, data_ocorrencia, usuario_logado)
            VALUES (-20002, 'Erro ao gerar relatório de pedidos', SYSDATE, USER);
    END relatorio_pedidos;

    FUNCTION validar_dados(p_id_pedido NUMBER) RETURN BOOLEAN IS
        v_valido BOOLEAN := TRUE;
    BEGIN
        IF p_id_pedido IS NULL THEN
            v_valido := FALSE;
        END IF;
        
        RETURN v_valido;
    EXCEPTION
        WHEN OTHERS THEN
            INSERT INTO tb_erros (codigo_erro, nome_erro, data_ocorrencia, usuario_logado)
            VALUES (-20003, 'Erro na validação de dados', SYSDATE, USER);
            RETURN FALSE;
    END validar_dados;

    FUNCTION calcular_cotacao(p_valor_material NUMBER, p_qt_material NUMBER) RETURN NUMBER IS
        v_cotacao NUMBER;
    BEGIN
        IF p_valor_material IS NOT NULL AND p_qt_material IS NOT NULL THEN
            v_cotacao := p_valor_material * p_qt_material;
            RETURN v_cotacao;
        ELSE
            RAISE_APPLICATION_ERROR(-20004, 'Valor ou quantidade de material inválido');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            INSERT INTO tb_erros (codigo_erro, nome_erro, data_ocorrencia, usuario_logado)
            VALUES (-20004, 'Erro no cálculo da cotação', SYSDATE, USER);
            RETURN NULL;
    END calcular_cotacao;

END pkg_relatorios;

CREATE TABLE tb_usuario_audit (
    audit_id         NUMBER(10) NOT NULL,
    id_usuario       NUMBER(10),
    nr_cnpj_usuario  NUMBER(14),
    nm_fantasia_usuario VARCHAR2(80),
    operacao         VARCHAR2(10),
    data_operacao    DATE
);

CREATE OR REPLACE TRIGGER trg_audit_tb_usuario
AFTER INSERT ON tb_usuario
FOR EACH ROW
BEGIN
    INSERT INTO tb_usuario_audit (audit_id, id_usuario, nr_cnpj_usuario, nm_fantasia_usuario, operacao, data_operacao)
    VALUES (
        (SELECT NVL(MAX(audit_id), 0) + 1 FROM tb_usuario_audit),
        :NEW.id_usuario,
        :NEW.nr_cnpj_usuario,
        :NEW.nm_fantasia_usuario,
        'INSERT',
        SYSDATE
    );
END;

CREATE TABLE tb_log_atualizacao_material (
    id_log             NUMBER GENERATED ALWAYS AS IDENTITY,
    id_material        NUMBER(10) NOT NULL,
    valor_anterior     NUMBER(10) NOT NULL,
    valor_atual        NUMBER(10) NOT NULL,
    usuario_atualizacao VARCHAR2(100),
    CONSTRAINT tb_log_atualizacao_material_pk PRIMARY KEY (id_log)
);

CREATE OR REPLACE TRIGGER trg_monitoramento_material
AFTER UPDATE ON tb_material
FOR EACH ROW
DECLARE
    v_valor_anterior NUMBER;
BEGIN
    SELECT nr_valor_material
    INTO v_valor_anterior
    FROM tb_material
    WHERE id_material = :OLD.id_material;

    INSERT INTO tb_log_atualizacao_material (id_material, valor_anterior, valor_atual, usuario_atualizacao)
    VALUES (:OLD.id_material, v_valor_anterior, :NEW.nr_valor_material, USER);
END;