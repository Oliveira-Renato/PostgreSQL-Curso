---------FUNÇÕES---------------------------------------
CREATE OR REPLACE FUNCTION func_somar (INTEGER, INTEGER)
RETURNS INTEGER
SECURITY DEFINER
--RETURNS NULL ON NULL INPUT
CALLED ON NULL INPUT
LANGUAGE SQL
AS $$
	SELECT COALESCE($1, 0) + COALESCE($2, 0)
$$;

SELECT func_somar(10, NULL);

-------------------------------------------------------
CREATE OR REPLACE FUNCTION banco_add (b_numero INTEGER, b_nome VARCHAR, b_ativo BOOLEAN)
RETURNS INTEGER
SECURITY INVOKER
--RETURNS NULL ON NULL INPUT
LANGUAGE PLPGSQL
CALLED ON NULL INPUT
AS $$
DECLARE variavel_id INTEGER;
BEGIN
	IF b_numero IS NULL OR b_nome IS NULL OR b_ativo IS NULL THEN
		RETURN 0;
	END IF;

	SELECT INTO variavel_id numero
	FROM banco
	WHERE numero = b_numero;
	
	IF variavel_id IS NULL THEN
		INSERT INTO banco(numero, nome, ativo) VALUES
		(b_numero, b_nome, b_ativo);
	ELSE
		RETURN variavel_id;
	END IF;
	
	SELECT INTO variavel_id numero
	FROM banco
	WHERE numero = b_numero;
	
	RETURN variavel_id;
	
END; $$;

SELECT banco_add(5432, 'Sasuga Bank', false);
SELECT * FROM banco WHERE numero = 5432;
