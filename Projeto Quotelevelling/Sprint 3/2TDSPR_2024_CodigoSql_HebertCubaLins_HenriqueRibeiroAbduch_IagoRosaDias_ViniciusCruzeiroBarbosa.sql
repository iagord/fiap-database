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

CREATE TABLE tb_log_atualizacao_material (
    id_log             NUMBER GENERATED ALWAYS AS IDENTITY,
    id_material        NUMBER(10) NOT NULL,
    valor_anterior     NUMBER(10) NOT NULL,
    valor_atual        NUMBER(10) NOT NULL,
    usuario_atualizacao VARCHAR2(100),
    CONSTRAINT tb_log_atualizacao_material_pk PRIMARY KEY (id_log)
);

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

CREATE OR REPLACE TRIGGER trg_monitoramento_material
AFTER UPDATE ON tb_material
FOR EACH ROW
DECLARE
    v_valor_anterior NUMBER;
BEGIN
    -- Captura o valor anterior antes da atualização
    SELECT nr_valor_material
    INTO v_valor_anterior
    FROM tb_material
    WHERE id_material = :OLD.id_material;

    -- Insere o registro de log na tabela de log de atualização de materiais
    INSERT INTO tb_log_atualizacao_material (id_material, valor_anterior, valor_atual, usuario_atualizacao)
    VALUES (:OLD.id_material, v_valor_anterior, :NEW.nr_valor_material, USER);
END;