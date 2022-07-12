

insert into usuario(id_usuario, nome, rg, cpf, email, telefone, data_nasc)
values (1, 'Guilherme', '12345678', '12345678', 'guilherme@gmail.com', '44444444','12/12/1999');


insert into produto(id_produto, nome, valor, quantidade, id_usuario)
values (1, 'camisa', '20', '2',1)
select *from usuario
select *from produto
create table produto_auditoria(
log_id INT NOT NULL,
    data_criacao TEXT NOT NULL,
    operacao_realizada CHARACTER VARYING
);

CREATE OR REPLACE FUNCTION produto_log_function()
RETURNS trigger AS $BODY$
BEGIN
-- aqui fica um bloco if que confirmará o tipo de operação.
IF (TG_OP = 'INSERT') THEN
INSERT INTO produto_auditoria (log_id, data_criacao, operacao_realizada)
VALUES (new.id_produto, current_timestamp, 'Operação de inserção.
A linha de código ' || NEW.id_produto || 'foi inserido');
RETURN NEW;
-- aqui fica o bloco que confirmará o tipo de operação UPDATE.
ELSIF (TG_OP = 'UPDATE') THEN
INSERT INTO produto_auditoria (log_id, data_criacao, operacao_realizada)
VALUES (NEW.id_produto, current_timestamp, 'Operação de UPDATE.
A linha de código ' || NEW.id_produto || 'teve os valores atualizados '
 || OLD || 'com' || NEW.* || '.');
 RETURN NEW;
 -- aqui o bloco que confirmará o tipo de operação DELETE
 ELSIF (TG_OP = 'DELETE') THEN
 INSERT INTO produto_auditoria (log_id, data_criacao, opercao_realizada)
 VALUES (OLD.id_produto, current_timestamp, 'Operação DELETE. A linha de código '
 || OLD.id_produto || 'foi excluída ');
 RETURN OLD;
 END IF;
 RETURN NULL;
 END; 
 $BODY$
 
 LANGUAGE plpgsql
 

CREATE TRIGGER trigger_log_todas_as_operacoes
AFTER INSERT OR UPDATE OR DELETE ON produto
FOR EACH ROW 
EXECUTE PROCEDURE produto_log_function();

INSERT INTO produto ( nome, valor, quantidade, id_usuario)
VALUES ('bone', '30', '3', 1);
UPDATE produto set nome = 'Guilherme' where id_produto = '1';

select *from produto_auditoria