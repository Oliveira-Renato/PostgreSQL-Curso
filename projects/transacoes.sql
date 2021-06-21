SELECT numero, nome, ativo FROM banco ORDER BY numero;
SELECT numero, nome, ativo FROM banco WHERE numero = 0;

UPDATE banco SET ativo = FALSE WHERE numero = 0;

-----------TRANSAÇÕES----------------------------------
BEGIN;

UPDATE banco SET ativo = TRUE WHERE numero = 0;

ROLLBACK;

BEGIN;
UPDATE banco SET ativo = TRUE WHERE numero = 0;
COMMIT;

SELECT id, gerente, nome FROM funcionarios;

BEGIN;
UPDATE funcionarios SET gerente = 2 WHERE id = 3;
SAVEPOINT sp_func;
UPDATE funcionarios SET nome = 'Orochimaru' WHERE nome = 'Sarutobi';
ROLLBACK TO sp_func;
UPDATE funcionarios SET gerente = 1  WHERE id = 5;
COMMIT;