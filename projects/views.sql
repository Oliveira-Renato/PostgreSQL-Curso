SELECT nome, numero FROM banco;

CREATE OR REPLACE VIEW vw_banco AS (
	SELECT nome, numero,ativo
	FROM banco
);

SELECT * FROM vw_banco;

CREATE OR REPLACE VIEW vw_banco_2 (bank_name, bank_num, bank_active) AS (
	SELECT nome, numero,ativo
	FROM banco
);

SELECT * FROM vw_banco_2;

-- INSERT VALUES
INSERT INTO vw_banco_2 (bank_name, bank_num, bank_active) 
VALUES ('Gringotts', 51, true) ;

SELECT bank_name, bank_num, bank_active FROM vw_banco_2
WHERE bank_num = 51;

SELECT nome, numero, ativo FROM banco
WHERE numero = 51;

UPDATE vw_banco_2 SET bank_active = FALSE
WHERE bank_name ILIKE '%Gringotts%';

DELETE FROM vw_banco_2 WHERE bank_num = 51;


-- TEMPORARY VIEW
CREATE OR REPLACE TEMPORARY VIEW vw_agencia AS (
	SELECT nome FROM agencia
);

SELECT * FROM vw_agencia;


-- WITH LOCAL CHECK OPTION
CREATE OR REPLACE VIEW vw_banco_ativo AS (
	SELECT nome, numero, ativo
	FROM banco
	WHERE ativo IS TRUE
) ;


INSERT INTO vw_banco_ativo (nome, numero, ativo) 
VALUES ('Gringotts', 51, FALSE) ;


CREATE OR REPLACE VIEW vw_bancos_com_a AS (
	SELECT nome, numero, ativo
	FROM vw_banco_ativo
	WHERE nome ILIKE 'a%'
) WITH LOCAL CHECK OPTION;

SELECT nome, numero, ativo FROM banco
WHERE numero = 3331;


INSERT INTO vw_bancos_com_A (nome, numero, ativo) 
VALUES ('Absalom  Bank', 333, TRUE) ;

UPDATE vw_bancos_com_A SET numero = 333
WHERE nome ILIKE 'Absalom%';

INSERT INTO vw_bancos_com_A (nome, numero, ativo) 
VALUES ('Akira Bank', 3331, FALSE) ;

------------RECURSIVE VIEW--------------------------

CREATE TABLE IF NOT EXISTS funcionarios (
	id SERIAL,
	nome VARCHAR (50),
	gerente INTEGER,
	PRIMARY KEY (id),
	FOREIGN KEY (gerente) REFERENCES funcionarios(id)
);


SELECT * FROM funcionarios;

INSERT INTO funcionarios (nome, gerente)
VALUES ('Sarutobi', null);
INSERT INTO funcionarios (nome, gerente)
VALUES ('Jiraya', 1);
INSERT INTO funcionarios (nome, gerente)
VALUES ('Tsunade', 1);
INSERT INTO funcionarios (nome, gerente)
VALUES ('Minato', 2);
INSERT INTO funcionarios (nome, gerente)
VALUES ('Kakashi', 4);


CREATE OR REPLACE RECURSIVE VIEW vw_func(id, gerente, funcionarios)AS (
	SELECT id, gerente, nome
	FROM funcionarios
	WHERE gerente is NULL
	
	UNION ALL
	
	SELECT funcionarios.id, funcionarios.gerente, funcionarios.nome
	FROM funcionarios
	JOIN vw_func ON vw_func.id = funcionarios.gerente
);

SELECT id, gerente, funcionarios FROM vw_func;