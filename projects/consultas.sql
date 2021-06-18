-- Consultas aleatórias
SELECT * FROM banco;
SELECT numero, nome, ativo FROM banco;
SELECT banco_numero, nome FROM agencia;
SELECT nome, email FROM cliente
WHERE ativo IS true;
SELECT valor FROM cliente_transacoes;
SELECT banco_numero, agencia_numero, data_criacao FROM conta_corrente;
SELECT id, nome FROM tipo_transacao 
ORDER BY id DESC;

SELECT * FROM information_schema.columns WHERE table_name = 'banco';

SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'banco';

-- Criando tabela para teste
CREATE TABLE IF NOT EXISTS teste (
	cpf VARCHAR (11) NOT NULL,
	nome VARCHAR (50) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (cpf)
);

INSERT INTO teste VALUES ('12376523445', 'Monkey D. Luffy', '2019-04-28 13:00:00');
SELECT * FROM teste;

INSERT INTO teste VALUES ('12376523445', 'Monkey D. Luffy', '2019-04-28 13:00:00')
ON CONFLICT (cpf) DO NOTHING;

UPDATE teste SET nome = 'Zeca Urubu' WHERE cpf = '12376523445';

----------------- testando funções de agregação ----------------------------------
-- AVG
-- COUNT (HAVING)
-- SUM
-- MIN
-- MAX

SELECT * FROM cliente_transacoes;
SELECT AVG (valor) FROM cliente_transacoes;

SELECT COUNT(numero)
FROM cliente;

SELECT COUNT(numero), email
FROM cliente
WHERE email ILIKE '%gmail.com'
GROUP BY email;

SELECT COUNT(numero), email FROM cliente
GROUP BY email
HAVING(email) ILIKE '%gmail.com';

SELECT COUNT(id), tipo_transacao_id 
FROM cliente_transacoes
GROUP BY tipo_transacao_id
HAVING COUNT(id) > 150;

SELECT MIN(valor) FROM cliente_transacoes;
SELECT MIN(valor), tipo_transacao_id FROM cliente_transacoes
GROUP BY tipo_transacao_id;

SELECT MAX(valor) FROM cliente_transacoes;

SELECT MAX(valor), tipo_transacao_id FROM cliente_transacoes
GROUP BY tipo_transacao_id;

SELECT SUM (valor)
FROM cliente_transacoes;

SELECT SUM (valor), tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id
ORDER BY tipo_transacao_id DESC;


