CREATE TABLE AUDIT_TABLE
  (
    aud_id              INTEGER ,
    aud_nome_tabela     VARCHAR2 (30) ,
    aud_tipo_evento     VARCHAR2 (30) ,
    aud_ident_linha     VARCHAR2 (200) ,
    aud_campos          VARCHAR2 (255) ,
    aud_valores_antigos VARCHAR2 (2000) ,
    aud_valores_novos   VARCHAR2 (2000) ,
    aud_usuario_bd      VARCHAR2 (30) ,
    aud_usuario_so      VARCHAR2 (100) ,
    aud_timestamp       TIMESTAMP
  ) ;
  
  ALTER TABLE AUDIT_TABLE ADD CONSTRAINT CK_AUD_01 CHECK(AUD_TIMESTAMP IS NOT NULL);

  CREATE SEQUENCE seq_aud NOCACHE;

  CREATE TRIGGER TG_SEQ_AUD
  BEFORE INSERT ON AUDIT_TABLE
  FOR EACH ROW
  begin
    :new.aud_id := seq_aud.nextval;
  end;
  /

CREATE OR REPLACE PROCEDURE INSERT_AUDIT(
  p_aud_nome_tabela VARCHAR,
  p_aud_tipo_evento VARCHAR,
  p_aud_ident_linha VARCHAR,
  p_aud_campos VARCHAR,
  p_aud_valores_antigos VARCHAR,
  p_aud_valores_novos VARCHAR,
  p_aud_usuario_bd VARCHAR,
  p_aud_usuario_so VARCHAR,
  p_aud_timestamp TIMESTAMP
)IS
begin
  INSERT INTO AUDIT_TABLE VALUES(0, p_aud_nome_tabela, p_aud_tipo_evento, p_aud_ident_linha, p_aud_campos, p_aud_valores_antigos, p_aud_valores_novos, p_aud_usuario_bd, p_aud_usuario_so, p_aud_timestamp);
end INSERT_AUDIT;
/

CREATE FUNCTION FC_USER_BD RETURN VARCHAR
AS
  v_user VARCHAR(30);
begin
    SELECT USER INTO v_user FROM DUAL;
    RETURN v_user;
end;
/

  COMMENT ON TABLE audit_table IS 'Respons�vel pelo armazenamento dos dados referente as a��es realizadas nas tabelas de neg�cio';
COMMENT ON COLUMN AUDIT_TABLE.aud_id
IS
  'Chave primaria da tabela de auditoria' ;
  COMMENT ON COLUMN AUDIT_TABLE.aud_nome_tabela
IS
  'Nome da tabela' ;
  COMMENT ON COLUMN AUDIT_TABLE.aud_tipo_evento
IS
  'Tipo do evento realizado' ;
  COMMENT ON COLUMN AUDIT_TABLE.aud_ident_linha
IS
  'Identificador de linha' ;
  COMMENT ON COLUMN AUDIT_TABLE.aud_timestamp
IS
  'Timestamp da tabela' ;
ALTER TABLE AUDIT_TABLE ADD CONSTRAINT AUDIT_TABLE_PK PRIMARY KEY ( aud_id ) ;


CREATE OR REPLACE TRIGGER tg_par_audit
AFTER UPDATE OR DELETE ON PARTIDOS
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('PARTIDOS', 'D', :old.par_id, null, null, null, FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.par_sigla<> :new.par_sigla) THEN
            insert_audit('PARTIDOS','U',:old.par_id,'PAR_SIGLA', :old.par_sigla, :new.par_sigla, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    END IF;
END;
/

CREATE TRIGGER tg_can_audit
AFTER UPDATE OR DELETE ON CANDIDATOS
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('CANDIDATOS', 'D', :old.can_id, null, null, null,FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.can_nome<> :new.can_nome) THEN
            insert_audit('CANDIDATOS','U',:old.can_id,'CAN_NOME', :old.can_nome, :new.can_nome, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.can_condicao<> :new.can_condicao) THEN
            insert_audit('CANDIDATOS','U',:old.can_id,'CAN_CONDICAO', :old.can_condicao, :new.can_condicao, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    END IF;
END;
/

CREATE TRIGGER tg_abo_audit
AFTER UPDATE OR DELETE ON ABORDAGENS
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('ABORDAGENS', 'D', :old.abo_id, null, null, null,FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.abo_nome<> :new.abo_nome) THEN
            insert_audit('ABORDAGENS','U', :old.abo_id,'ABO_NOME', :old.abo_nome, :new.abo_nome, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER tg_cen_audit
AFTER UPDATE OR DELETE ON CENARIOS
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('CENARIOS', 'D', :old.cen_id, null, null, null,FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.cen_descricao<> :new.cen_descricao) THEN
            insert_audit('CENARIOS','U', :old.cen_id,'CEN_DESCRICAO', :old.cen_descricao, :new.cen_descricao, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.cen_turno<> :new.cen_turno) THEN
            insert_audit('CENARIOS','U', :old.cen_id,'CEN_TURNO', :old.cen_turno, :new.cen_turno, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.cen_voto_tipo<> :new.cen_voto_tipo) THEN
            insert_audit('CENARIOS','U', :old.cen_id,'CEN_TIPO_VOTO', :old.cen_voto_tipo, :new.cen_voto_tipo, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.cen_pes_id<> :new.cen_pes_id) THEN
            insert_audit('CENARIOS','U', :old.cen_id,'CEN_PES_ID', :old.cen_pes_id, :new.cen_pes_id, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.cen_abo_id<> :new.cen_abo_id) THEN
            insert_audit('CENARIOS','U', :old.cen_id,'CEN_ABO_ID', :old.cen_abo_id, :new.cen_abo_id, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    END IF;
END;
/

CREATE TRIGGER tg_est_audit
AFTER UPDATE OR DELETE ON ESTADOS
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('ESTADOS', 'D', :old.est_id, null, null, null,FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.est_sigla<> :new.est_sigla) THEN
            insert_audit('ESTADOS','U', :old.est_id,'EST_SIGLA', :old.est_sigla, :new.est_sigla, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.est_nome<> :new.est_nome) THEN
            insert_audit('ESTADOS','U', :old.est_id,'EST_NOME', :old.est_nome, :new.est_nome, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    END IF;
END;
/

CREATE TRIGGER tg_ins_audit
AFTER UPDATE OR DELETE ON INSTITUTOS
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('INSTITUTOS', 'D', :old.ins_id, null, null, null,FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.ins_nome<> :new.ins_nome) THEN
            insert_audit('INSTITUTOS','U', :old.ins_id,'INS_NOME', :old.ins_nome, :new.ins_nome, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    END IF;
END;
/

CREATE TRIGGER tg_pes_audit
AFTER UPDATE OR DELETE ON PESQUISAS
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('PESQUISAS', 'D', :old.pes_id, null, null, null,FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.pes_ano<> :new.pes_ano) THEN
            insert_audit('PESQUISAS','U', :old.pes_id,'PES_ANO', :old.pes_ano, :new.pes_ano, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.pes_cargo<> :new.pes_cargo) THEN
            insert_audit('PESQUISAS','U', :old.pes_id,'pes_cargo', :old.pes_cargo, :new.pes_cargo, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.pes_nome_municipio<> :new.pes_nome_municipio) THEN
            insert_audit('PESQUISAS','U', :old.pes_id,'pes_nome_municipio', :old.pes_nome_municipio, :new.pes_nome_municipio, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.pes_data<> :new.pes_data) THEN
            insert_audit('PESQUISAS','U', :old.pes_id,'pes_data', :old.pes_data, :new.pes_data, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.pes_qnt_entrevistas<> :new.pes_qnt_entrevistas) THEN
            insert_audit('PESQUISAS','U', :old.pes_id,'pes_qnt_entrevistas', :old.pes_qnt_entrevistas, :new.pes_qnt_entrevistas, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.pes_margem_mais<> :new.pes_margem_mais) THEN
            insert_audit('PESQUISAS','U', :old.pes_id,'pes_margem_mais', :old.pes_margem_mais, :new.pes_margem_mais, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.pes_margem_menos<> :new.pes_margem_menos) THEN
            insert_audit('PESQUISAS','U', :old.pes_id,'pes_margem_menos', :old.pes_margem_menos, :new.pes_margem_menos, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.pes_ins_id<> :new.pes_ins_id) THEN
            insert_audit('PESQUISAS','U', :old.pes_id,'pes_ins_id', :old.pes_ins_id, :new.pes_ins_id, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.pes_org_id<> :new.pes_org_id) THEN
            insert_audit('PESQUISAS','U', :old.pes_id,'pes_org_id', :old.pes_org_id, :new.pes_org_id, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.pes_est_id<> :new.pes_est_id) THEN
            insert_audit('PESQUISAS','U', :old.pes_id,'pes_est_id', :old.pes_est_id, :new.pes_est_id, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    END IF;
END;
/

CREATE TRIGGER tg_org_audit
AFTER UPDATE OR DELETE ON ORGAOS
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('ORGAOS', 'D', :old.org_id, null, null, null,FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.org_nome<> :new.org_nome) THEN
            insert_audit('ORGAOS','U', :old.org_id,'ORG_NOME', :old.org_nome, :new.org_nome, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.org_num_reg<> :new.org_num_reg) THEN
            insert_audit('ORGAOS','U', :old.org_id,'ORG_NUM_REG', :old.org_num_reg, :new.org_num_reg, FC_USER_BD(), 'APP', systimestamp);
        END IF;
   END IF;
END;
/

CREATE TRIGGER tg_fil_audit
AFTER UPDATE OR DELETE ON FILIACOES
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('FILIACOES', 'D', CONCAT(CONCAT(:old.fil_par_id, CONCAT(', ', :old.fil_can_id)), CONCAT(', ', :old.fil_pes_id)), null, null, null,FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.fil_par_id<> :new.fil_par_id) THEN
            insert_audit('FILIACOES','U', CONCAT(CONCAT(:old.fil_par_id, CONCAT(', ', :old.fil_can_id)), CONCAT(', ', :old.fil_pes_id)) ,'FIL_PAR_ID', :old.fil_par_id, :new.fil_par_id, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.fil_can_id<> :new.fil_can_id) THEN
            insert_audit('FILIACOES','U', CONCAT(CONCAT(:old.fil_par_id, CONCAT(', ', :old.fil_can_id)), CONCAT(', ', :old.fil_pes_id)) ,'FIL_PAR_ID', :old.fil_can_id, :new.fil_can_id, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.fil_pes_id<> :new.fil_pes_id) THEN
            insert_audit('FILIACOES','U', CONCAT(CONCAT(:old.fil_pes_id, CONCAT(', ', :old.fil_can_id)), CONCAT(', ', :old.fil_pes_id)) ,'FIL_PAR_ID', :old.fil_pes_id, :new.fil_pes_id, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    END IF;
END;
/

CREATE TRIGGER tg_per_audit
AFTER UPDATE OR DELETE ON PERCENTUAIS
FOR EACH ROW
BEGIN
    IF DELETING THEN
        insert_audit('PERCENTUAIS', 'D', CONCAT(CONCAT(:old.per_can_id, ', '), :old.per_cen_id), null, null, null, FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.per_numero<> :new.per_numero) THEN
            insert_audit('PERCENTUAIS', 'D', CONCAT(CONCAT(:old.per_can_id, ', '), :old.per_cen_id), 'PER_NUMERO', :old.per_numero, :new.per_numero, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    END IF;
END;

--------------
--
CREATE OR REPLACE TRIGGER tg_habo_audit
AFTER UPDATE OR DELETE ON H_ABORDAGENS
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('H_ABORDAGENS', 'D', CONCAT(CONCAT(:old.habo_id, ', '), :old.habo_dt_entrada), null, null, null,FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.habo_nome<> :new.habo_nome) THEN
            insert_audit('H_ABORDAGENS','U', CONCAT(CONCAT(:old.habo_id, ', '), :old.habo_dt_entrada),'HABO_NOME', :old.habo_nome, :new.habo_nome, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.habo_dt_entrada<> :new.habo_dt_entrada) THEN
            insert_audit('H_ABORDAGENS','U', CONCAT(CONCAT(:old.habo_id, ', '), :old.habo_dt_entrada),'HABO_DT_ENTRADA', :old.habo_dt_entrada, :new.habo_dt_entrada, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    END IF;
END;
/

CREATE TRIGGER tg_hcan_audit
AFTER UPDATE OR DELETE ON H_CANDIDATOS
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('H_CANDIDATOS', 'D', CONCAT(CONCAT(:old.hcan_id, ', '), :old.hcan_dt_entrada), null, null, null,FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.hcan_nome<> :new.hcan_nome) THEN
            insert_audit('H_CANDIDATOS','U', CONCAT(CONCAT(:old.hcan_id, ', '), :old.hcan_dt_entrada),'HCAN_NOME', :old.hcan_nome, :new.hcan_nome, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.hcan_condicao<> :new.hcan_condicao) THEN
            insert_audit('H_CANDIDATOS','U', CONCAT(CONCAT(:old.hcan_id, ', '), :old.hcan_dt_entrada),'HCAN_CONDICAO', :old.hcan_condicao, :new.hcan_condicao, FC_USER_BD(), 'APP', systimestamp);
        END IF;
	IF(:old.hcan_dt_entrada<> :new.hcan_dt_entrada) THEN
            insert_audit('H_CANDIDATOS','U', CONCAT(CONCAT(:old.hcan_id, ', '), :old.hcan_dt_entrada),'HCAN_DT_ENTRADA', :old.hcan_dt_entrada, :new.hcan_dt_entrada, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER tg_hcen_audit
AFTER UPDATE OR DELETE ON H_CENARIOS
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('H_CENARIOS', 'D', CONCAT(CONCAT(:old.hcen_id, ', '), :old.hcen_dt_entrada), null, null, null,FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.hcen_descricao<> :new.hcen_descricao) THEN
            insert_audit('H_CENARIOS','U', CONCAT(CONCAT(:old.hcen_id, ', '), :old.hcen_dt_entrada),'HCEN_DESCRICAO', :old.hcen_descricao, :new.hcen_descricao, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.hcen_turno<> :new.hcen_turno) THEN
            insert_audit('H_CENARIOS','U', CONCAT(CONCAT(:old.hcen_id, ', '), :old.hcen_dt_entrada),'HCEN_TURNO', :old.hcen_turno, :new.hcen_turno, FC_USER_BD(), 'APP', systimestamp);
        END IF;
	IF(:old.hcen_voto_tipo<> :new.hcen_voto_tipo) THEN
            insert_audit('H_CENARIOS','U', CONCAT(CONCAT(:old.hcen_id, ', '), :old.hcen_dt_entrada),'HCEN_VOTO_TIPO', :old.hcen_voto_tipo, :new.hcen_voto_tipo, FC_USER_BD(), 'APP', systimestamp);
        END IF;
	IF(:old.hcen_pes_id<> :new.hcen_pes_id) THEN
            insert_audit('H_CENARIOS','U', CONCAT(CONCAT(:old.hcen_id, ', '), :old.hcen_dt_entrada),'HCEN_PES_ID', :old.hcen_pes_id, :new.hcen_pes_id, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.hcen_abo_id<> :new.hcen_abo_id) THEN
            insert_audit('H_CENARIOS','U', CONCAT(CONCAT(:old.hcen_id, ', '), :old.hcen_dt_entrada),'HCEN_ABO_ID', :old.hcen_abo_id, :new.hcen_abo_id, FC_USER_BD(), 'APP', systimestamp);
        END IF;
	IF(:old.hcen_dt_entrada<> :new.hcen_dt_entrada) THEN
            insert_audit('H_CENARIOS','U', CONCAT(CONCAT(:old.hcen_id, ', '), :old.hcen_dt_entrada),'HCEN_DT_ENTRADA', :old.hcen_dt_entrada, :new.hcen_dt_entrada, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER tg_hest_audit
AFTER UPDATE OR DELETE ON H_ESTADOS
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('H_ESTADOS', 'D', CONCAT(CONCAT(:old.hest_id, ', '), :old.hest_dt_entrada), null, null, null,FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.hest_sigla<> :new.hest_sigla) THEN
            insert_audit('H_ESTADOS','U', CONCAT(CONCAT(:old.hest_id, ', '), :old.hest_dt_entrada),'HEST_SIGLA', :old.hest_sigla, :new.hest_sigla, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.est_nome<> :new.hest_nome) THEN
            insert_audit('H_ESTADOS','U', CONCAT(CONCAT(:old.hest_id, ', '), :old.hest_dt_entrada),'HEST_NOME', :old.hest_nome, :new.hest_nome, FC_USER_BD(), 'APP', systimestamp);
        END IF;
	IF(:old.est_dt_entrada<> :new.hest_dt_entrada) THEN
            insert_audit('H_ESTADOS','U', CONCAT(CONCAT(:old.hest_id, ', '), :old.hest_dt_entrada),'HEST_DT_ENTRADA', :old.hest_dt_entrada, :new.hest_dt_entrada, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    END IF;
END;
/
describe h_estados;

CREATE TRIGGER tg_hfil_audit
AFTER UPDATE OR DELETE ON H_FILIACOES
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('H_FILIACOES', 'D', CONCAT(CONCAT(:old.hfil_par_id, CONCAT(', ', :old.hfil_can_id)), CONCAT(CONCAT(', ', :old.hfil_pes_id), CONCAT(', ', :old.hfil_dt_entrada))), null, null, null,FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.hfil_par_id<> :new.hfil_par_id) THEN
            insert_audit('H_FILIACOES','U', CONCAT(CONCAT(:old.hfil_par_id, CONCAT(', ', :old.hfil_can_id)), CONCAT(CONCAT(', ', :old.hfil_pes_id), CONCAT(', ', :old.hfil_dt_entrada))),'HFIL_PAR_ID', :old.hfil_par_id, :new.hfil_par_id, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.hfil_can_id<> :new.hfil_can_id) THEN
            insert_audit('H_FILIACOES','U', CONCAT(CONCAT(:old.hfil_par_id, CONCAT(', ', :old.hfil_can_id)), CONCAT(CONCAT(', ', :old.hfil_pes_id), CONCAT(', ', :old.hfil_dt_entrada))),'HFIL_CAN_ID', :old.hfil_can_id, :new.hfil_can_id, FC_USER_BD(), 'APP', systimestamp);
        END IF;
	IF(:old.hfil_pes_id<> :new.hfil_pes_id) THEN
            insert_audit('H_FILIACOES','U', CONCAT(CONCAT(:old.hfil_par_id, CONCAT(', ', :old.hfil_can_id)), CONCAT(CONCAT(', ', :old.hfil_pes_id), CONCAT(', ', :old.hfil_dt_entrada))),'HFIL_PES_ID', :old.hfil_pes_id, :new.hfil_pes_id, FC_USER_BD(), 'APP', systimestamp);
        END IF;
	IF(:old.hfil_dt_entrada<> :new.hfil_dt_entrada) THEN
            insert_audit('H_FILIACOES','U', CONCAT(CONCAT(:old.hfil_par_id, CONCAT(', ', :old.hfil_can_id)), CONCAT(CONCAT(', ', :old.hfil_pes_id), CONCAT(', ', :old.hfil_dt_entrada))),'HFIL_DT_ENTRADA', :old.hfil_dt_entrada, :new.hfil_dt_entrada, FC_USER_BD(), 'APP', systimestamp);
        END IF;
   END IF;
END;
/

CREATE OR REPLACE TRIGGER tg_hins_audit
AFTER UPDATE OR DELETE ON H_INSTITUTOS
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('H_INSTITUTOS', 'D', CONCAT(CONCAT(:old.hins_id, ', '), :old.hins_dt_entrada), null, null, null,FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.hins_nome<> :new.hins_nome) THEN
            insert_audit('H_INSTITUTOS','U', CONCAT(CONCAT(:old.hins_id, ', '), :old.hins_dt_entrada),'HINS_NOME', :old.hins_nome, :new.hins_nome, FC_USER_BD(), 'APP', systimestamp);
        END IF;
	IF(:old.hins_dt_entrada<> :new.hins_dt_entrada) THEN
            insert_audit('H_INSTITUTOS','U', CONCAT(CONCAT(:old.hins_id, ', '), :old.hins_dt_entrada),'HINS_DT_ENTRADA', :old.hins_dt_entrada, :new.hins_dt_entrada, FC_USER_BD(), 'APP', systimestamp);
        END IF;
   END IF;
END;
/

CREATE OR REPLACE TRIGGER tg_horg_audit
AFTER UPDATE OR DELETE ON H_ORGAOS
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('H_ORGAOS', 'D', CONCAT(CONCAT(:old.horg_id, ', '), :old.horg_dt_entrada), null, null, null,FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.horg_nome<> :new.horg_nome) THEN
            insert_audit('H_ORGAOS','U', CONCAT(CONCAT(:old.horg_id, ', '), :old.horg_dt_entrada),'HORG_NOME', :old.horg_nome, :new.horg_nome, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.horg_num_reg<> :new.horg_num_reg) THEN
            insert_audit('H_ORGAOS','U', CONCAT(CONCAT(:old.horg_id, ', '), :old.horg_dt_entrada),'HORG_NUM_REG', :old.horg_num_reg, :new.horg_num_reg, FC_USER_BD(), 'APP', systimestamp);
        END IF;
	IF(:old.horg_dt_entrada<> :new.horg_dt_entrada) THEN
            insert_audit('H_ORGAOS','U', CONCAT(CONCAT(:old.horg_id, ', '), :old.horg_dt_entrada),'HORG_DT_ENTRADA', :old.horg_dt_entrada, :new.horg_dt_entrada, FC_USER_BD(), 'APP', systimestamp);
        END IF;
   END IF;
END;
/

CREATE TRIGGER tg_hpar_audit
AFTER UPDATE OR DELETE ON H_PARTIDOS
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('H_PARTIDOS', 'D', CONCAT(CONCAT(:old.hpar_id, ', '), :old.hpar_dt_entrada), null, null, null,FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.hpar_sigla<> :new.hpar_sigla) THEN
            insert_audit('H_PARTIDOS','U',CONCAT(CONCAT(:old.hpar_id, ', '), :old.hpar_dt_entrada),'HPAR_SIGLA', :old.hpar_sigla, :new.hpar_sigla, FC_USER_BD(), 'APP', systimestamp);
        END IF;
	IF(:old.hpar_dt_entrada<> :new.hpar_dt_entrada) THEN
            insert_audit('H_PARTIDOS','U',CONCAT(CONCAT(:old.hpar_id, ', '), :old.hpar_dt_entrada),'HPAR_DT_ENTRADA', :old.hpar_dt_entrada, :new.hpar_dt_entrada, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    END IF;
END;
/

CREATE TRIGGER tg_hper_audit
AFTER UPDATE OR DELETE ON H_PERCENTUAIS
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('H_PERCENTUAIS', 'D', CONCAT(CONCAT(:old.hper_can_id, CONCAT(', ', :old.hper_cen_id)), CONCAT(', ', :old.hper_dt_entrada)), null, null, null,FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.hper_can_id<> :new.hper_can_id) THEN
            insert_audit('H_PERCENTUAIS','U', CONCAT(CONCAT(:old.hper_can_id, CONCAT(', ', :old.hper_cen_id)), CONCAT(', ', :old.hper_dt_entrada)),'HPER_CAN_ID', :old.hper_can_id, :new.hper_can_id, FC_USER_BD(), 'APP', systimestamp);
        END IF;
	IF(:old.hper_cen_id<> :new.hper_cen_id) THEN
            insert_audit('H_PERCENTUAIS','U', CONCAT(CONCAT(:old.hper_can_id, CONCAT(', ', :old.hper_cen_id)), CONCAT(', ', :old.hper_dt_entrada)),'HPER_CEN_ID', :old.hper_cen_id, :new.hper_cen_id, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.hper_numero<> :new.hper_numero) THEN
            insert_audit('H_PERCENTUAIS','U', CONCAT(CONCAT(:old.hper_can_id, CONCAT(', ', :old.hper_cen_id)), CONCAT(', ', :old.hper_dt_entrada)),'HPER_NUMERO', :old.hper_numero, :new.hper_numero, FC_USER_BD(), 'APP', systimestamp);
        END IF;
	IF(:old.hper_dt_entrada<> :new.hper_dt_entrada) THEN
            insert_audit('H_PERCENTUAIS','U', CONCAT(CONCAT(:old.hper_can_id, CONCAT(', ', :old.hper_cen_id)), CONCAT(', ', :old.hper_dt_entrada)),'HPER_DT_ENTRADA', :old.hper_dt_entrada, :new.hper_dt_entrada, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    END IF;
END;
/

CREATE TRIGGER tg_hpes_audit
AFTER UPDATE OR DELETE ON H_PESQUISAS
FOR EACH ROW
BEGIN 
    IF DELETING THEN
        insert_audit('H_PESQUISAS', 'D', CONCAT(CONCAT(:old.hpes_id, ', '), :old.hpes_dt_entrada), null, null, null,FC_USER_BD(), 'APP', systimestamp);
    END IF;
    IF UPDATING THEN
        IF(:old.hpes_ano<> :new.hpes_ano) THEN
            insert_audit('H_PESQUISAS','U', CONCAT(CONCAT(:old.hpes_id, ', '), :old.hpes_dt_entrada),'HPES_ANO', :old.hpes_ano, :new.hpes_ano, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.hpes_cargo<> :new.hpes_cargo) THEN
            insert_audit('H_PESQUISAS','U', CONCAT(CONCAT(:old.hpes_id, ', '), :old.hpes_dt_entrada),'HPES_CARGO', :old.hpes_cargo, :new.hpes_cargo, FC_USER_BD(), 'APP', systimestamp);
        END IF;
	IF(:old.hpes_nome_municipio<> :new.hpes_nome_municipio) THEN
            insert_audit('H_PESQUISAS','U', CONCAT(CONCAT(:old.hpes_id, ', '), :old.hpes_dt_entrada),'HPES_NOME_MUNICIPIO', :old.hpes_nome_municipio, :new.hpes_nome_municipio, FC_USER_BD(), 'APP', systimestamp);
        END IF;
	IF(:old.hpes_data<> :new.hpes_data) THEN
            insert_audit('H_PESQUISAS','U', CONCAT(CONCAT(:old.hpes_id, ', '), :old.hpes_dt_entrada),'HPES_DATA', :old.hpes_data, :new.hpes_data, FC_USER_BD(), 'APP', systimestamp);
        END IF;
        IF(:old.hpes_qnt_entrevistas<> :new.hpes_qnt_entrevistas) THEN
            insert_audit('H_PESQUISAS','U', CONCAT(CONCAT(:old.hpes_id, ', '), :old.hpes_dt_entrada),'HPES_QNT_ENTREVISTAS', :old.hpes_qnt_entrevistas, :new.hpes_qnt_entrevistas, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    IF(:old.hpes_margem_mais<> :new.hpes_margem_mais) THEN
            insert_audit('H_PESQUISAS','U', CONCAT(CONCAT(:old.hpes_id, ', '), :old.hpes_dt_entrada),'HPES_MARGEM_MAIS', :old.hpes_margem_mais, :new.hpes_margem_mais, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    IF(:old.hpes_margem_menos<> :new.hpes_margem_menos) THEN
            insert_audit('H_PESQUISAS','U', CONCAT(CONCAT(:old.hpes_id, ', '), :old.hpes_dt_entrada),'HPES_MARGEM_MENOS', :old.hpes_margem_menos, :new.hpes_margem_menos, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    IF(:old.hpes_ins_id<> :new.hpes_ins_id) THEN
            insert_audit('H_PESQUISAS','U', CONCAT(CONCAT(:old.hpes_id, ', '), :old.hpes_dt_entrada),'HPES_INS_ID', :old.hpes_ins_id, :new.hpes_ins_id, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    IF(:old.hpes_org_id<> :new.hpes_org_id) THEN
            insert_audit('H_PESQUISAS','U', CONCAT(CONCAT(:old.hpes_id, ', '), :old.hpes_dt_entrada),'HPES_ORG_ID', :old.hpes_org_id, :new.hpes_org_id, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    IF(:old.hpes_est_id<> :new.hpes_est_id) THEN
            insert_audit('H_PESQUISAS','U', CONCAT(CONCAT(:old.hpes_id, ', '), :old.hpes_dt_entrada),'HPES_EST_ID', :old.hpes_est_id, :new.hpes_est_id, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    IF(:old.hpes_dt_entrada<> :new.hpes_dt_entrada) THEN
            insert_audit('H_PESQUISAS','U', CONCAT(CONCAT(:old.hpes_id, ', '), :old.hpes_dt_entrada),'HPES_DT_ENTRADA', :old.hpes_dt_entrada, :new.hpes_dt_entrada, FC_USER_BD(), 'APP', systimestamp);
        END IF;
    END IF;
END;
/
