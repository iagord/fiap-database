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

SET SERVEROUTPUT ON;
    
CREATE OR REPLACE FUNCTION valida_qt_material(p_qt_material NUMBER) 
    RETURN NUMBER 
    IS 
        v_resultado NUMBER;
BEGIN 
    IF p_qt_material <= 0 THEN 
        v_resultado := -1; 
    ELSE 
        v_resultado := 1; 
    END IF; 

    RETURN v_resultado; 
END valida_qt_material;

CREATE OR REPLACE FUNCTION valida_valor_material(p_valor_material NUMBER) 
    RETURN NUMBER 
    IS 
        v_resultado NUMBER;
BEGIN 
    IF p_valor_material <= 0 THEN 
        v_resultado := -1; 
    ELSE 
        v_resultado := 1; 
    END IF; 

    RETURN v_resultado; 
END valida_valor_material;

CREATE OR REPLACE PROCEDURE sp_tb_endereco_insert(
    p_id_endereco tb_endereco.id_endereco%TYPE,
    p_tb_fornecedor_id_fornecedor tb_fornecedor.id_fornecedor%TYPE,
    p_nm_logradouro tb_endereco.nm_logradouro%TYPE,
    p_nr_logradouro tb_endereco.nr_logradouro%TYPE,
    p_ds_complemento tb_endereco.ds_complemento%TYPE,
    p_nr_cep tb_endereco.nr_cep%TYPE,
    p_nm_bairro tb_endereco.nm_bairro%TYPE,
    p_nm_cidade tb_endereco.nm_cidade%TYPE,
    p_nm_estado tb_endereco.nm_estado%TYPE,
    p_tb_usuario_id_usuario tb_usuario.id_usuario%TYPE
) IS
BEGIN
    INSERT INTO tb_endereco (
        id_endereco,
        tb_fornecedor_id_fornecedor,
        nm_logradouro,
        nr_logradouro,
        ds_complemento,
        nr_cep,
        nm_bairro,
        nm_cidade,
        nm_estado,
        tb_usuario_id_usuario
    ) VALUES (
        p_id_endereco,
        p_tb_fornecedor_id_fornecedor,
        p_nm_logradouro,
        p_nr_logradouro,
        p_ds_complemento,
        p_nr_cep,
        p_nm_bairro,
        p_nm_cidade,
        p_nm_estado,
        p_tb_usuario_id_usuario
    );

    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_tb_endereco_update(
    p_id_endereco tb_endereco.id_endereco%TYPE,
    p_tb_fornecedor_id_fornecedor tb_fornecedor.id_fornecedor%TYPE,
    p_nm_logradouro tb_endereco.nm_logradouro%TYPE,
    p_nr_logradouro tb_endereco.nr_logradouro%TYPE,
    p_ds_complemento tb_endereco.ds_complemento%TYPE,
    p_nr_cep tb_endereco.nr_cep%TYPE,
    p_nm_bairro tb_endereco.nm_bairro%TYPE,
    p_nm_cidade tb_endereco.nm_cidade%TYPE,
    p_nm_estado tb_endereco.nm_estado%TYPE,
    p_tb_usuario_id_usuario tb_usuario.id_usuario%TYPE
) IS
BEGIN
    UPDATE tb_endereco SET
        tb_fornecedor_id_fornecedor = p_tb_fornecedor_id_fornecedor,
        nm_logradouro = p_nm_logradouro,
        nr_logradouro = p_nr_logradouro,
        ds_complemento = p_ds_complemento,
        nr_cep = p_nr_cep,
        nm_bairro = p_nm_bairro,
        nm_cidade = p_nm_cidade,
        nm_estado = p_nm_estado,
        tb_usuario_id_usuario = p_tb_usuario_id_usuario
    WHERE id_endereco = p_id_endereco;

    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_tb_endereco_delete(
    p_id_endereco tb_endereco.id_endereco%TYPE
) IS
BEGIN
    DELETE FROM tb_endereco WHERE id_endereco = p_id_endereco;
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_tb_fornecedor_insert(
    p_id_fornecedor tb_fornecedor.id_fornecedor%TYPE,
    p_nr_cnpj_fornecedor tb_fornecedor.nr_cnpj_fornecedor%TYPE,
    p_nm_fantasia_fornecedor tb_fornecedor.nm_fantasia_fornecedor%TYPE
) IS
BEGIN
    INSERT INTO tb_fornecedor (
        id_fornecedor,
        nr_cnpj_fornecedor,
        nm_fantasia_fornecedor
    ) VALUES (
        p_id_fornecedor,
        p_nr_cnpj_fornecedor,
        p_nm_fantasia_fornecedor
    );

    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_tb_fornecedor_update(
    p_id_fornecedor tb_fornecedor.id_fornecedor%TYPE,
    p_nr_cnpj_fornecedor tb_fornecedor.nr_cnpj_fornecedor%TYPE,
    p_nm_fantasia_fornecedor tb_fornecedor.nm_fantasia_fornecedor%TYPE
) IS
BEGIN
    UPDATE tb_fornecedor SET
        nr_cnpj_fornecedor = p_nr_cnpj_fornecedor,
        nm_fantasia_fornecedor = p_nm_fantasia_fornecedor
    WHERE id_fornecedor = p_id_fornecedor;

    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_tb_fornecedor_delete(
    p_id_fornecedor tb_fornecedor.id_fornecedor%TYPE
) IS
BEGIN
    DELETE FROM tb_fornecedor WHERE id_fornecedor = p_id_fornecedor;
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_tb_material_insert(
    p_id_material tb_material.id_material%TYPE,
    p_tb_fornecedor_id_fornecedor tb_fornecedor.id_fornecedor%TYPE,
    p_nr_qt_material tb_material.nr_qt_material%TYPE,
    p_nr_valor_material tb_material.nr_valor_material%TYPE
) IS
BEGIN
    INSERT INTO tb_material (
        id_material,
        tb_fornecedor_id_fornecedor,
        nr_qt_material,
        nr_valor_material
    ) VALUES (
        p_id_material,
        p_tb_fornecedor_id_fornecedor,
        p_nr_qt_material,
        p_nr_valor_material
    );

    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_tb_material_update(
    p_id_material tb_material.id_material%TYPE,
    p_tb_fornecedor_id_fornecedor tb_fornecedor.id_fornecedor%TYPE,
    p_nr_qt_material tb_material.nr_qt_material%TYPE,
    p_nr_valor_material tb_material.nr_valor_material%TYPE
) IS
BEGIN
    UPDATE tb_material SET
        tb_fornecedor_id_fornecedor = p_tb_fornecedor_id_fornecedor,
        nr_qt_material = p_nr_qt_material,
        nr_valor_material = p_nr_valor_material
    WHERE id_material = p_id_material;

    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_tb_material_delete(
    p_id_material tb_material.id_material%TYPE
) IS
BEGIN
    DELETE FROM tb_material WHERE id_material = p_id_material;
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_tb_pedido_insert(
    p_id_pedido tb_pedido.id_pedido%TYPE,
    p_tb_usuario_id_usuario tb_usuario.id_usuario%TYPE,
    p_tb_material_id_material tb_material.id_material%TYPE,
    p_nr_nota_fiscal tb_pedido.nr_nota_fiscal%TYPE,
    p_nr_qt_itens_totais tb_pedido.nr_qt_itens_totais%TYPE,
    p_nr_valor_total tb_pedido.nr_valor_total%TYPE
) IS
BEGIN
    INSERT INTO tb_pedido (
        id_pedido,
        tb_usuario_id_usuario,
        tb_material_id_material,
        nr_nota_fiscal,
        nr_qt_itens_totais,
        nr_valor_total
    ) VALUES (
        p_id_pedido,
        p_tb_usuario_id_usuario,
        p_tb_material_id_material,
        p_nr_nota_fiscal,
        p_nr_qt_itens_totais,
        p_nr_valor_total
    );

    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_tb_pedido_update(
    p_id_pedido tb_pedido.id_pedido%TYPE,
    p_tb_usuario_id_usuario tb_usuario.id_usuario%TYPE,
    p_tb_material_id_material tb_material.id_material%TYPE,
    p_nr_nota_fiscal tb_pedido.nr_nota_fiscal%TYPE,
    p_nr_qt_itens_totais tb_pedido.nr_qt_itens_totais%TYPE,
    p_nr_valor_total tb_pedido.nr_valor_total%TYPE
) IS
BEGIN
    UPDATE tb_pedido SET
        tb_usuario_id_usuario = p_tb_usuario_id_usuario,
        tb_material_id_material = p_tb_material_id_material,
        nr_nota_fiscal = p_nr_nota_fiscal,
        nr_qt_itens_totais = p_nr_qt_itens_totais,
        nr_valor_total = p_nr_valor_total
    WHERE id_pedido = p_id_pedido;

    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_tb_pedido_delete(
    p_id_pedido tb_pedido.id_pedido%TYPE
) IS
BEGIN
    DELETE FROM tb_pedido WHERE id_pedido = p_id_pedido;
    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_tb_usuario_insert(
    p_id_usuario tb_usuario.id_usuario%TYPE,
    p_nr_cnpj_usuario tb_usuario.nr_cnpj_usuario%TYPE,
    p_nm_fantasia_usuario tb_usuario.nm_fantasia_usuario%TYPE
) IS
BEGIN
    INSERT INTO tb_usuario (
        id_usuario,
        nr_cnpj_usuario,
        nm_fantasia_usuario
    ) VALUES (
        p_id_usuario,
        p_nr_cnpj_usuario,
        p_nm_fantasia_usuario
    );

    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_tb_usuario_update(
    p_id_usuario tb_usuario.id_usuario%TYPE,
    p_nr_cnpj_usuario tb_usuario.nr_cnpj_usuario%TYPE,
    p_nm_fantasia_usuario tb_usuario.nm_fantasia_usuario%TYPE
) IS
BEGIN
    UPDATE tb_usuario SET
        nr_cnpj_usuario = p_nr_cnpj_usuario,
        nm_fantasia_usuario = p_nm_fantasia_usuario
    WHERE id_usuario = p_id_usuario;

    COMMIT;
END;

CREATE OR REPLACE PROCEDURE sp_tb_usuario_delete(
    p_id_usuario tb_usuario.id_usuario%TYPE
) IS
BEGIN
    DELETE FROM tb_usuario WHERE id_usuario = p_id_usuario;
    COMMIT;
END;

DECLARE
    CURSOR cursor_consulta IS
        SELECT e.id_endereco, e.nm_logradouro, e.nr_logradouro, e.ds_complemento, e.nr_cep, e.nm_bairro, e.nm_cidade, e.nm_estado, u.id_usuario, u.nr_cnpj_usuario, u.nm_fantasia_usuario
        FROM tb_endereco e
        JOIN tb_usuario u ON e.tb_usuario_id_usuario = u.id_usuario;
    registro_consulta cursor_consulta%ROWTYPE;
BEGIN
    OPEN cursor_consulta;

    LOOP
        FETCH cursor_consulta INTO registro_consulta;

        EXIT WHEN cursor_consulta%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('ID do Endereço: ' || registro_consulta.id_endereco);
        DBMS_OUTPUT.PUT_LINE('Nome do Logradouro: ' || registro_consulta.nm_logradouro);
        DBMS_OUTPUT.PUT_LINE('Número do Logradouro: ' || registro_consulta.nr_logradouro);
        DBMS_OUTPUT.PUT_LINE('Complemento: ' || registro_consulta.ds_complemento);
        DBMS_OUTPUT.PUT_LINE('CEP: ' || registro_consulta.nr_cep);
        DBMS_OUTPUT.PUT_LINE('Bairro: ' || registro_consulta.nm_bairro);
        DBMS_OUTPUT.PUT_LINE('Cidade: ' || registro_consulta.nm_cidade);
        DBMS_OUTPUT.PUT_LINE('Estado: ' || registro_consulta.nm_estado);
        DBMS_OUTPUT.PUT_LINE('ID do Usuário: ' || registro_consulta.id_usuario);
        DBMS_OUTPUT.PUT_LINE('CNPJ do Usuário: ' || registro_consulta.nr_cnpj_usuario);
        DBMS_OUTPUT.PUT_LINE('Nome Fantasia do Usuário: ' || registro_consulta.nm_fantasia_usuario);
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
    END LOOP;

    CLOSE cursor_consulta;
END;

CREATE OR REPLACE PROCEDURE sp_relatorio_pedidos_por_fornecedor 
IS
BEGIN
   DBMS_OUTPUT.PUT_LINE('RELATÓRIO DE PEDIDOS POR FORNECEDOR');
   DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
   DBMS_OUTPUT.PUT_LINE('| Fornecedor                 | Total Valor dos Pedidos |');
   DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
   
   FOR cur IN (SELECT f.nm_fantasia_fornecedor, SUM(p.nr_valor_total) AS total_valor_pedidos
               FROM tb_fornecedor f
               INNER JOIN tb_material m ON f.id_fornecedor = m.tb_fornecedor_id_fornecedor
               INNER JOIN tb_pedido p ON m.id_material = p.tb_material_id_material
               GROUP BY f.nm_fantasia_fornecedor
               ORDER BY total_valor_pedidos DESC) LOOP
      
      DBMS_OUTPUT.PUT_LINE('| ' || cur.nm_fantasia_fornecedor || '                 | ' || TO_CHAR(cur.total_valor_pedidos, '9,999.99') || ' |');
      DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
   
   END LOOP;

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ERRO: ' || SQLERRM);
      RAISE;
END sp_relatorio_pedidos_por_fornecedor;