-- Gerado por Oracle SQL Developer Data Modeler 4.1.3.901
--   em:        2022-04-05 23:21:31 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g




CREATE TABLE ABORDAGENS
  (
    abo_id   INTEGER,
    abo_nome VARCHAR2 (20)
  ) ;
COMMENT ON TABLE ABORDAGENS
IS
  'Tabela responsavel pelo armazenamento de dados das abordagens' ;
  COMMENT ON COLUMN ABORDAGENS.abo_id
IS
  'Chave primaria de abordagem' ;
  COMMENT ON COLUMN ABORDAGENS.abo_nome
IS
  'Nome do tipo da abordagem de pesquisa ex: espontanea, rejeiçao.' ;
ALTER TABLE ABORDAGENS ADD CONSTRAINT PK_ABO PRIMARY KEY ( abo_id ) ;
ALTER TABLE ABORDAGENS ADD CONSTRAINT CK_ABO_01 CHECK (abo_nome IS NOT NULL);


CREATE TABLE CANDIDATOS
  (
    can_id       INTEGER,
    can_nome     VARCHAR2 (255) ,
    can_condicao CHAR (1)
  ) ;
COMMENT ON TABLE CANDIDATOS
IS
  'Tabela responsavel pelo armazenamento de dados dos candidatos' ;
  COMMENT ON COLUMN CANDIDATOS.can_id
IS
  'Chave primaria do candidato' ;
  COMMENT ON COLUMN CANDIDATOS.can_nome
IS
  'Nome do candidato' ;
  COMMENT ON COLUMN CANDIDATOS.can_condicao
IS
  'Determina se e uma condicao (ex: Votos brancos, nao sabem etc...)' ;
ALTER TABLE CANDIDATOS ADD CONSTRAINT PK_CAN PRIMARY KEY ( can_id ) ;
ALTER TABLE CANDIDATOS ADD CONSTRAINT CK_CAN_01 CHECK (can_condicao IS NOT NULL);

CREATE TABLE CENARIOS
  (
    cen_id        INTEGER ,
    cen_descricao VARCHAR2 (30) ,
    cen_turno     INTEGER ,
    cen_voto_tipo VARCHAR2 (20) ,
    cen_pes_id    INTEGER ,
    cen_abo_id    INTEGER
  ) ;
COMMENT ON TABLE CENARIOS
IS
  'Tabela responsavel pelo armazenamento de dados dos cenarios' ;
  COMMENT ON COLUMN CENARIOS.cen_id
IS
  'Chave primaria do cenario' ;
  COMMENT ON COLUMN CENARIOS.cen_descricao
IS
  'Descricao do cenario pesquisado' ;
  COMMENT ON COLUMN CENARIOS.cen_turno
IS
  'Turno do cenario pesquisado' ;
  COMMENT ON COLUMN CENARIOS.cen_voto_tipo
IS
  'Tipo do voto usado no cenario ex: Votos totais, Votos validos.' ;
  COMMENT ON COLUMN CENARIOS.cen_pes_id
IS
  'Chave estrangeira de pesquisas' ;
  COMMENT ON COLUMN CENARIOS.cen_abo_id
IS
  'Chave estrageira de abordagens' ;
ALTER TABLE CENARIOS ADD CONSTRAINT PK_CEN PRIMARY KEY ( cen_id ) ;
ALTER TABLE CENARIOS ADD CONSTRAINT CK_CEN_01 CHECK (cen_pes_id IS NOT NULL);
ALTER TABLE CENARIOS ADD CONSTRAINT CK_CEN_02 CHECK (cen_abo_id IS NOT NULL);

CREATE TABLE ESTADOS
  (
    est_id    INTEGER ,
    est_sigla CHAR (2) ,
    est_nome  VARCHAR2 (20)
  ) ;
COMMENT ON TABLE ESTADOS
IS
  'Tabela responsavel pelo armazenamento de dados dos estados' ;
  COMMENT ON COLUMN ESTADOS.est_id
IS
  'Chave primária do estado.' ;
  COMMENT ON COLUMN ESTADOS.est_sigla
IS
  'Sigla da unidade federativa.' ;
  COMMENT ON COLUMN ESTADOS.est_nome
IS
  'Nome da unidade federativa' ;
ALTER TABLE ESTADOS ADD CONSTRAINT PK_EST PRIMARY KEY ( est_id ) ;
ALTER TABLE ESTADOS ADD CONSTRAINT CK_EST_01 CHECK (est_sigla IS NOT NULL);
ALTER TABLE ESTADOS ADD CONSTRAINT CK_EST_02 CHECK (est_nome IS NOT NULL);

CREATE TABLE FILIACOES
  (
    fil_par_id INTEGER ,
    fil_can_id INTEGER ,
    fil_pes_id INTEGER
  ) ;
COMMENT ON TABLE FILIACOES
IS
  'Tabela responsavel pelo armazenamento de dados das filiacoes' ;
  COMMENT ON COLUMN FILIACOES.fil_par_id
IS
  'Chave primaria estrangeira que faz referencia a tabela partidos' ;
  COMMENT ON COLUMN FILIACOES.fil_can_id
IS
  'Chave primaria estrangeira que faz referencia a tabela candidatos' ;
  COMMENT ON COLUMN FILIACOES.fil_pes_id
IS
  'Chave primaria estrangeira que faz referencia a tabela pesquisas' ;
ALTER TABLE FILIACOES ADD CONSTRAINT PK_FIL PRIMARY KEY ( fil_par_id, fil_can_id, fil_pes_id ) ;


CREATE TABLE H_ABORDAGENS
  (
    habo_id         INTEGER ,
    habo_nome       VARCHAR2 (20) ,
    habo_dt_entrada DATE
  ) ;
COMMENT ON TABLE H_ABORDAGENS
IS
  'Tabela responsavel pelo armazenamento de dados das abordagens' ;
  COMMENT ON COLUMN H_ABORDAGENS.habo_id
IS
  'Chave primaria de abordagem' ;
  COMMENT ON COLUMN H_ABORDAGENS.habo_nome
IS
  'Nome do tipo da abordagem de pesquisa ex: espontanea, rejeiçao.' ;
ALTER TABLE H_ABORDAGENS ADD CONSTRAINT PK_HABO PRIMARY KEY ( habo_id, habo_dt_entrada ) ;
ALTER TABLE H_ABORDAGENS ADD CONSTRAINT CK_HABO_01 CHECK (habo_nome IS NOT NULL);


CREATE TABLE H_CANDIDATOS
  (
    hcan_id       INTEGER ,
    hcan_nome     VARCHAR2 (255) ,
    hcan_condicao CHAR (1),
    hcan_dt_entrada DATE
  ) ;
COMMENT ON TABLE H_CANDIDATOS
IS
  'Tabela responsavel pelo armazenamento de dados dos candidatos' ;
  COMMENT ON COLUMN H_CANDIDATOS.hcan_id
IS
  'Chave primaria do candidato' ;
  COMMENT ON COLUMN H_CANDIDATOS.hcan_nome
IS
  'Nome do candidato' ;
  COMMENT ON COLUMN H_CANDIDATOS.hcan_condicao
IS
  'Determina se e uma condicao (ex: Votos brancos, nao sabem etc...)' ;
ALTER TABLE H_CANDIDATOS ADD CONSTRAINT PK_HCAN PRIMARY KEY ( hcan_id, hcan_dt_entrada ) ;
ALTER TABLE H_CANDIDATOS ADD CONSTRAINT CK_HCAN_01 CHECK (hcan_condicao IS NOT NULL);


CREATE TABLE H_CENARIOS
  (
    hcen_id         INTEGER ,
    hcen_descricao  VARCHAR2 (30) ,
    hcen_turno      INTEGER ,
    hcen_voto_tipo  VARCHAR2 (20) ,
    hcen_pes_id     INTEGER ,
    hcen_abo_id     INTEGER ,
    hcen_dt_entrada DATE
  ) ;
COMMENT ON TABLE H_CENARIOS
IS
  'Tabela responsavel pelo armazenamento de dados dos cenarios' ;
  COMMENT ON COLUMN H_CENARIOS.hcen_id
IS
  'Chave primaria do cenario' ;
  COMMENT ON COLUMN H_CENARIOS.hcen_descricao
IS
  'Descricao do cenario pesquisado' ;
  COMMENT ON COLUMN H_CENARIOS.hcen_turno
IS
  'Turno do cenario pesquisado' ;
  COMMENT ON COLUMN H_CENARIOS.hcen_voto_tipo
IS
  'Tipo do voto usado no cenario ex: Votos totais, Votos validos.' ;
  COMMENT ON COLUMN H_CENARIOS.hcen_pes_id
IS
  'Chave estrangeira de pesquisas' ;
  COMMENT ON COLUMN H_CENARIOS.hcen_abo_id
IS
  'Chave estrageira de abordagens' ;
ALTER TABLE H_CENARIOS ADD CONSTRAINT PK_HCEN PRIMARY KEY ( hcen_id, hcen_dt_entrada );
ALTER TABLE H_CENARIOS ADD CONSTRAINT CK_HCEN_01 CHECK (hcen_pes_id IS NOT NULL);
ALTER TABLE H_CENARIOS ADD CONSTRAINT CK_HCEN_02 CHECK (hcen_abo_id IS NOT NULL);


CREATE TABLE H_ESTADOS
  (
    hest_id         INTEGER  ,
    hest_sigla      CHAR (2)  ,
    hest_nome       VARCHAR2 (20)  ,
    hest_dt_entrada DATE 
  ) ;
COMMENT ON TABLE H_ESTADOS
IS
  'Tabela responsavel pelo armazenamento de dados dos estados' ;
  COMMENT ON COLUMN H_ESTADOS.hest_id
IS
  'Chave primária do estado.' ;
  COMMENT ON COLUMN H_ESTADOS.hest_sigla
IS
  'Sigla da unidade federativa.' ;
  COMMENT ON COLUMN H_ESTADOS.hest_nome
IS
  'Nome da unidade federativa' ;
ALTER TABLE H_ESTADOS ADD CONSTRAINT PK_HEST PRIMARY KEY ( hest_id, hest_dt_entrada ) ;
ALTER TABLE H_ESTADOS ADD CONSTRAINT CK_HEST_01 CHECK (hest_sigla IS NOT NULL);
ALTER TABLE H_ESTADOS ADD CONSTRAINT CK_HEST_02 CHECK (hest_nome IS NOT NULL);


CREATE TABLE H_FILIACOES
  (
    hfil_par_id     INTEGER ,
    hfil_can_id     INTEGER ,
    hfil_pes_id     INTEGER ,
    hfil_dt_entrada DATE
  ) ;
COMMENT ON TABLE H_FILIACOES
IS
  'Tabela responsavel pelo armazenamento de dados das filiacoes' ;
  COMMENT ON COLUMN H_FILIACOES.hfil_par_id
IS
  'Chave primaria estrangeira que faz referencia a tabela partidos' ;
  COMMENT ON COLUMN H_FILIACOES.hfil_can_id
IS
  'Chave primaria estrangeira que faz referencia a tabela candidatos' ;
  COMMENT ON COLUMN H_FILIACOES.hfil_pes_id
IS
  'Chave primaria estrangeira que faz referencia a tabela pesquisas' ;
ALTER TABLE H_FILIACOES ADD CONSTRAINT PK_HFIL PRIMARY KEY ( hfil_par_id, hfil_can_id, hfil_pes_id, hfil_dt_entrada ) ;


CREATE TABLE H_INSTITUTOS
  (
    hins_id         INTEGER ,
    hins_nome       VARCHAR2 (255) ,
    hins_dt_entrada DATE
  ) ;
COMMENT ON TABLE H_INSTITUTOS
IS
  'Tabela responsavel pelo armazenamento de dados dos  institutos' ;
  COMMENT ON COLUMN H_INSTITUTOS.hins_id
IS
  'Chave primária do instituto.' ;
  COMMENT ON COLUMN H_INSTITUTOS.hins_nome
IS
  'Nome do instituto' ;
ALTER TABLE H_INSTITUTOS ADD CONSTRAINT PK_HINS PRIMARY KEY ( hins_id, hins_dt_entrada ) ;
ALTER TABLE H_INSTITUTOS ADD CONSTRAINT CK_HINS_01 CHECK (hins_nome IS NOT NULL);



CREATE TABLE H_ORGAOS
  (
    horg_id         INTEGER ,
    horg_nome       VARCHAR2 (20) ,
    horg_num_reg    VARCHAR2 (30) ,
    horg_dt_entrada DATE
  ) ;
COMMENT ON TABLE H_ORGAOS
IS
  'Tabela responsavel pelo armazenamento de dados dos orgaos
' ;
  COMMENT ON COLUMN H_ORGAOS.horg_id
IS
  'Chave primária do órgão de registro.' ;
  COMMENT ON COLUMN H_ORGAOS.horg_nome
IS
  'Nome do órgão' ;
  COMMENT ON COLUMN H_ORGAOS.horg_num_reg
IS
  'Número de registro do órgão' ;
ALTER TABLE H_ORGAOS ADD CONSTRAINT PK_HORG PRIMARY KEY ( horg_id, horg_dt_entrada ) ;
ALTER TABLE H_ORGAOS ADD CONSTRAINT CK_HORG_01 CHECK (horg_num_reg IS NOT NULL);


CREATE TABLE H_PARTIDOS
  (
    hpar_id         INTEGER ,
    hpar_sigla      VARCHAR2 (10) ,
    hpar_dt_entrada DATE
  ) ;
COMMENT ON TABLE H_PARTIDOS
IS
  'Tabela responsavel pelo armazenamento de dados dos  partidos' ;
  COMMENT ON COLUMN H_PARTIDOS.hpar_id
IS
  'Chave primaria do partido' ;
  COMMENT ON COLUMN H_PARTIDOS.hpar_sigla
IS
  'Sigla do partido' ;
ALTER TABLE H_PARTIDOS ADD CONSTRAINT PK_HPAR PRIMARY KEY ( hpar_id, hpar_dt_entrada ) ;
ALTER TABLE H_PARTIDOS ADD CONSTRAINT CK_HPAR_01 CHECK (hpar_sigla IS NOT NULL);


CREATE TABLE H_PERCENTUAIS
  (
    hper_can_id     INTEGER ,
    hper_cen_id     INTEGER ,
    hper_numero     NUMBER (5,2) ,
    hper_dt_entrada DATE
  ) ;
COMMENT ON TABLE H_PERCENTUAIS
IS
  'Tabela responsavel pelo armazenamento de dados dos percentuais' ;
  COMMENT ON COLUMN H_PERCENTUAIS.hper_can_id
IS
  'Chave primaria estrageira de percentuais que faz referencia a tabela candidatos' ;
  COMMENT ON COLUMN H_PERCENTUAIS.hper_cen_id
IS
  'Chave primaria estrageira de percentuais que faz referencia a tabela cenarios' ;
  COMMENT ON COLUMN H_PERCENTUAIS.hper_numero
IS
  'Percentual de votos do candidato' ;
ALTER TABLE H_PERCENTUAIS ADD CONSTRAINT PK_HPER PRIMARY KEY ( hper_can_id, hper_cen_id, hper_dt_entrada ) ;
ALTER TABLE H_PERCENTUAIS ADD CONSTRAINT CK_HPER_01 CHECK (hper_numero IS NOT NULL);


CREATE TABLE H_PESQUISAS
  (
    hpes_id              INTEGER ,
    hpes_ano             INTEGER ,
    hpes_cargo           VARCHAR2 (20) ,
    hpes_nome_municipio  VARCHAR2 (255) ,
    hpes_data            DATE ,
    hpes_qnt_entrevistas INTEGER ,
    hpes_margem_mais     NUMBER (4,2) ,
    hpes_margem_menos    NUMBER (4,2) ,
    hpes_ins_id          INTEGER ,
    hpes_org_id          INTEGER ,
    hpes_est_id          INTEGER ,
    hpes_dt_entrada      DATE
  ) ;
COMMENT ON TABLE H_PESQUISAS
IS
  'Tabela responsavel pelo armazenamento de dados das pesquisas ' ;
  COMMENT ON COLUMN H_PESQUISAS.hpes_id
IS
  'Chave primária da pesquisa.' ;
  COMMENT ON COLUMN H_PESQUISAS.hpes_ano
IS
  'Ano em que a pesquisa foi realizada.' ;
  COMMENT ON COLUMN H_PESQUISAS.hpes_cargo
IS
  'Para qual cargo os candidatos da pesquisa estao concorrendo.' ;
  COMMENT ON COLUMN H_PESQUISAS.hpes_nome_municipio
IS
  'Município em que a pesquisa foi realizada ' ;
  COMMENT ON COLUMN H_PESQUISAS.hpes_data
IS
  'Data da pesquisa' ;
  COMMENT ON COLUMN H_PESQUISAS.hpes_qnt_entrevistas
IS
  'Quantidade de pessoas entrevistadas.' ;
  COMMENT ON COLUMN H_PESQUISAS.hpes_margem_mais
IS
  'Margem a mais da pesquisa' ;
  COMMENT ON COLUMN H_PESQUISAS.hpes_margem_menos
IS
  'Margem a menos da pesquisa' ;
  COMMENT ON COLUMN H_PESQUISAS.hpes_ins_id
IS
  'Chave estrangeira do instituto que realizou a pesquisa ' ;
  COMMENT ON COLUMN H_PESQUISAS.hpes_org_id
IS
  'Chave estrangeira do órgão registro' ;
  COMMENT ON COLUMN H_PESQUISAS.hpes_est_id
IS
  'Chave estrangeira do estado em que foi realizado a pesquisa ' ;
  COMMENT ON COLUMN H_PESQUISAS.hpes_dt_entrada
IS
  'Chave primaria composta pela data de entrada do dado.
' ;
ALTER TABLE H_PESQUISAS ADD CONSTRAINT PK_HPES PRIMARY KEY ( hpes_id, hpes_dt_entrada ) ;
ALTER TABLE H_PESQUISAS ADD CONSTRAINT CK_HPES_01 CHECK (hpes_data IS NOT NULL);
ALTER TABLE H_PESQUISAS ADD CONSTRAINT CK_HPES_02 CHECK (hpes_ins_id IS NOT NULL);
ALTER TABLE H_PESQUISAS ADD CONSTRAINT CK_HPES_03 CHECK (hpes_ins_id IS NOT NULL);

CREATE TABLE INSTITUTOS
  (
    ins_id   INTEGER ,
    ins_nome VARCHAR2 (255)
  ) ;
COMMENT ON TABLE INSTITUTOS
IS
  'Tabela responsavel pelo armazenamento de dados dos  institutos' ;
  COMMENT ON COLUMN INSTITUTOS.ins_id
IS
  'Chave primária do instituto.' ;
  COMMENT ON COLUMN INSTITUTOS.ins_nome
IS
  'Nome do instituto' ;
ALTER TABLE INSTITUTOS ADD CONSTRAINT PK_INS PRIMARY KEY ( ins_id ) ;
ALTER TABLE INSTITUTOS ADD CONSTRAINT CK_INS_01 CHECK (ins_nome IS NOT NULL);

CREATE TABLE ORGAOS
  (
    org_id      INTEGER NOT NULL ,
    org_nome    VARCHAR2 (20) ,
    org_num_reg VARCHAR2 (30) 
  ) ;
COMMENT ON TABLE ORGAOS
IS
  'Tabela responsavel pelo armazenamento de dados dos orgaos
' ;
  COMMENT ON COLUMN ORGAOS.org_id
IS
  'Chave primária do órgão de registro.' ;
  COMMENT ON COLUMN ORGAOS.org_nome
IS
  'Nome do órgão' ;
  COMMENT ON COLUMN ORGAOS.org_num_reg
IS
  'Número de registro do órgão' ;
ALTER TABLE ORGAOS ADD CONSTRAINT PK_ORG PRIMARY KEY ( org_id ) ;


CREATE TABLE PARTIDOS
  (
    par_id    INTEGER ,
    par_sigla VARCHAR2 (10)
  ) ;
COMMENT ON TABLE PARTIDOS
IS
  'Tabela responsavel pelo armazenamento de dados dos  partidos' ;
  COMMENT ON COLUMN PARTIDOS.par_id
IS
  'Chave primaria do partido' ;
  COMMENT ON COLUMN PARTIDOS.par_sigla
IS
  'Sigla do partido' ;
ALTER TABLE PARTIDOS ADD CONSTRAINT PK_PAR PRIMARY KEY ( par_id ) ;
ALTER TABLE PARTIDOS ADD CONSTRAINT CK_PAR_01 CHECK (par_sigla IS NOT NULL);

CREATE TABLE PERCENTUAIS
  (
    per_can_id INTEGER ,
    per_cen_id INTEGER ,
    per_numero NUMBER (5,2)
  ) ;
COMMENT ON TABLE PERCENTUAIS
IS
  'Tabela responsavel pelo armazenamento de dados dos percentuais' ;
  COMMENT ON COLUMN PERCENTUAIS.per_can_id
IS
  'Chave primaria estrageira de percentuais que faz referencia a tabela candidatos' ;
  COMMENT ON COLUMN PERCENTUAIS.per_cen_id
IS
  'Chave primaria estrageira de percentuais que faz referencia a tabela cenarios' ;
  COMMENT ON COLUMN PERCENTUAIS.per_numero
IS
  'Percentual de votos do candidato' ;
ALTER TABLE PERCENTUAIS ADD CONSTRAINT PK_PER PRIMARY KEY ( per_can_id, per_cen_id ) ;
ALTER TABLE PERCENTUAIS ADD CONSTRAINT CK_PER_01 CHECK (per_numero IS NOT NULL);

CREATE TABLE PESQUISAS
  (
    pes_id              INTEGER ,
    pes_ano             INTEGER ,
    pes_cargo           VARCHAR2 (20) ,
    pes_nome_municipio  VARCHAR2 (255) ,
    pes_data            DATE ,
    pes_qnt_entrevistas INTEGER ,
    pes_margem_mais     NUMBER (4,2) ,
    pes_margem_menos    NUMBER (4,2) ,
    pes_ins_id          INTEGER ,
    pes_org_id          INTEGER ,
    pes_est_id          INTEGER
  ) ;
COMMENT ON TABLE PESQUISAS
IS
  'Tabela responsavel pelo armazenamento de dados das pesquisas ' ;
  COMMENT ON COLUMN PESQUISAS.pes_id
IS
  'Chave primária da pesquisa.' ;
  COMMENT ON COLUMN PESQUISAS.pes_ano
IS
  'Ano em que a pesquisa foi realizada.' ;
  COMMENT ON COLUMN PESQUISAS.pes_cargo
IS
  'Para qual cargo os candidatos da pesquisa estao concorrendo.' ;
  COMMENT ON COLUMN PESQUISAS.pes_nome_municipio
IS
  'Município em que a pesquisa foi realizada ' ;
  COMMENT ON COLUMN PESQUISAS.pes_data
IS
  'Data da pesquisa' ;
  COMMENT ON COLUMN PESQUISAS.pes_qnt_entrevistas
IS
  'Quantidade de pessoas entrevistadas.' ;
  COMMENT ON COLUMN PESQUISAS.pes_margem_mais
IS
  'Margem a mais da pesquisa' ;
  COMMENT ON COLUMN PESQUISAS.pes_margem_menos
IS
  'Margem a menos da pesquisa' ;
  COMMENT ON COLUMN PESQUISAS.pes_ins_id
IS
  'Chave estrangeira do instituto que realizou a pesquisa ' ;
  COMMENT ON COLUMN PESQUISAS.pes_org_id
IS
  'Chave estrangeira do órgão registro' ;
  COMMENT ON COLUMN PESQUISAS.pes_est_id
IS
  'Chave estrangeira do estado em que foi realizado a pesquisa ' ;
ALTER TABLE PESQUISAS ADD CONSTRAINT PK_PES PRIMARY KEY ( pes_id ) ;
ALTER TABLE PESQUISAS ADD CONSTRAINT CK_PES_01 CHECK (pes_data IS NOT NULL);
ALTER TABLE PESQUISAS ADD CONSTRAINT CK_PES_02 CHECK (pes_ins_id IS NOT NULL);

ALTER TABLE CENARIOS ADD CONSTRAINT FK_CEN_ABO FOREIGN KEY ( cen_abo_id ) REFERENCES ABORDAGENS ( abo_id ) ;

ALTER TABLE CENARIOS ADD CONSTRAINT FK_CEN_PES FOREIGN KEY ( cen_pes_id ) REFERENCES PESQUISAS ( pes_id ) ON
DELETE CASCADE ;

ALTER TABLE FILIACOES ADD CONSTRAINT FK_FIL_CAN FOREIGN KEY ( fil_can_id ) REFERENCES CANDIDATOS ( can_id ) ;

ALTER TABLE FILIACOES ADD CONSTRAINT FK_FIL_PAR FOREIGN KEY ( fil_par_id ) REFERENCES PARTIDOS ( par_id ) ;

ALTER TABLE FILIACOES ADD CONSTRAINT FK_FIL_PES FOREIGN KEY ( fil_pes_id ) REFERENCES PESQUISAS ( pes_id ) ON
DELETE CASCADE ;

ALTER TABLE PERCENTUAIS ADD CONSTRAINT FK_PER_CAN FOREIGN KEY ( per_can_id ) REFERENCES CANDIDATOS ( can_id ) ;

ALTER TABLE PERCENTUAIS ADD CONSTRAINT FK_PER_CEN FOREIGN KEY ( per_cen_id ) REFERENCES CENARIOS ( cen_id ) ON
DELETE CASCADE ;

ALTER TABLE PESQUISAS ADD CONSTRAINT FK_PES_EST FOREIGN KEY ( pes_est_id ) REFERENCES ESTADOS ( est_id ) ;

ALTER TABLE PESQUISAS ADD CONSTRAINT FK_PES_INS FOREIGN KEY ( pes_ins_id ) REFERENCES INSTITUTOS ( ins_id ) ;

ALTER TABLE PESQUISAS ADD CONSTRAINT FK_PES_ORG FOREIGN KEY ( pes_org_id ) REFERENCES ORGAOS ( org_id ) ;

CREATE TRIGGER tg_hist_pes
BEFORE UPDATE OR DELETE ON PESQUISAS
FOR EACH ROW
BEGIN
    insert into h_pesquisas values(:old.pes_id,:old.pes_ano,:old.pes_cargo,:old.pes_nome_municipio,:old.pes_data,:old.pes_qnt_entrevistas,:old.pes_margem_mais,:old.pes_margem_menos,:old.pes_ins_id,:old.pes_org_id,:old.pes_est_id,sysdate);
END;
/

CREATE TRIGGER tg_hist_ins
BEFORE UPDATE OR DELETE ON INSTITUTOS
FOR EACH ROW
BEGIN
    insert into h_institutos values(:old.ins_id,:old.ins_nome, sysdate);
END;
/

CREATE TRIGGER tg_hist_org
BEFORE UPDATE OR DELETE ON ORGAOS
FOR EACH ROW
BEGIN
    insert into h_orgaos values(:old.org_id,:old.org_nome,:old.org_num_reg, sysdate);
END;
/

CREATE TRIGGER tg_hist_est
BEFORE UPDATE OR DELETE ON ESTADOS
FOR EACH ROW
BEGIN
    insert into h_estados values(:old.est_id,:old.est_sigla,:old.est_nome, sysdate);
END;
/

CREATE TRIGGER tg_hist_cen
BEFORE UPDATE OR DELETE ON CENARIOS
FOR EACH ROW
BEGIN
    insert into h_cenarios values(:old.cen_id,:old.cen_descricao,:old.cen_turno,:old.cen_voto_tipo,:old.cen_pes_id,:old.cen_abo_id, sysdate);
END;
/

CREATE TRIGGER tg_hist_abo
BEFORE UPDATE OR DELETE ON ABORDAGENS
FOR EACH ROW
BEGIN
    insert into h_abordagens values(:old.abo_id,:old.abo_nome, sysdate);
END;
/


CREATE TRIGGER tg_hist_per
BEFORE UPDATE OR DELETE ON PERCENTUAIS
FOR EACH ROW
BEGIN
    insert into h_percentuais values(:old.per_can_id,:old.per_cen_id,:old.per_numero, sysdate);
END;
/

CREATE TRIGGER tg_hist_can
BEFORE UPDATE OR DELETE ON CANDIDATOS
FOR EACH ROW
BEGIN
    insert into h_candidatos values(:old.can_id,:old.can_nome,:old.can_condicao, sysdate);
END;
/

CREATE TRIGGER tg_hist_par
BEFORE UPDATE OR DELETE ON PARTIDOS
FOR EACH ROW
BEGIN
    insert into h_partidos values(:old.par_id,:old.par_sigla, sysdate);
END;
/

CREATE OR REPLACE PROCEDURE PR_HEST (P_EST_ID INTEGER, P_EST_SIGLA VARCHAR, P_EST_NOME VARCHAR)
IS
BEGIN
	INSERT INTO H_ESTADOS VALUES (P_EST_ID, P_EST_SIGLA, P_EST_NOME, SYSDATE);
END;
/

CREATE OR REPLACE PROCEDURE PR_HPAR (P_PAR_ID INTEGER, P_PAR_SIGLA VARCHAR)
IS
BEGIN
	INSERT INTO H_PARTIDOS VALUES (P_PAR_ID, P_PAR_SIGLA, SYSDATE);
END;
/

CREATE OR REPLACE PROCEDURE PR_HCAN (P_CAN_ID INTEGER, P_CAN_NOME VARCHAR, P_CAN_CONDICAO CHAR)
IS
BEGIN
	INSERT INTO H_CANDIDATOS VALUES (P_CAN_ID, P_CAN_NOME, P_CAN_CONDICAO, SYSDATE);
END;
/

CREATE OR REPLACE PROCEDURE PR_HINS (P_INS_ID INTEGER, P_INS_NOME VARCHAR)
IS
BEGIN
	INSERT INTO H_INSTITUTOS VALUES (P_INS_ID, P_INS_NOME, SYSDATE);
END;
/

CREATE OR REPLACE PROCEDURE PR_HORG (P_ORG_ID INTEGER, P_ORG_NOME VARCHAR, P_ORG_NUM_REG VARCHAR)
IS
BEGIN
	INSERT INTO H_ORGAOS VALUES (P_ORG_ID, P_ORG_NOME, P_ORG_NUM_REG, SYSDATE);
END;
/

CREATE OR REPLACE PROCEDURE PR_HABO (P_ABO_ID INTEGER, P_ABO_NOME VARCHAR)
IS
BEGIN
	INSERT INTO H_ABORDAGENS VALUES(P_ABO_ID, P_ABO_NOME, SYSDATE);
END;
/

CREATE OR REPLACE PROCEDURE PR_HCEN (P_CEN_ID INTEGER, P_CEN_DESCRICAO VARCHAR, P_CEN_TURNO INTEGER, P_CEN_VOTO_TIPO VARCHAR, P_CEN_PES_ID INTEGER, P_CEN_ABO_ID INTEGER)
IS
BEGIN
	INSERT INTO H_CENARIOS VALUES (P_CEN_ID, P_CEN_DESCRICAO, P_CEN_TURNO, P_CEN_VOTO_TIPO, P_CEN_PES_ID, P_CEN_ABO_ID, SYSDATE);
END;
/

CREATE OR REPLACE PROCEDURE PR_HFIL (P_FIL_PAR_ID INTEGER, P_FIL_CAN_ID INTEGER, P_FIL_PES_ID INTEGER)
IS
BEGIN
	INSERT INTO H_FILIACOES VALUES (P_FIL_PAR_ID, P_FIL_CAN_ID, P_FIL_PES_ID, SYSDATE);
END;
/

CREATE OR REPLACE PROCEDURE PR_HPER (P_PER_CAN_ID INTEGER, P_PER_CEN_ID INTEGER, P_PER_NUMERO NUMBER)
IS
BEGIN
	INSERT INTO H_PERCENTUAIS VALUES (P_PER_CAN_ID, P_PER_CEN_ID, P_PER_NUMERO, SYSDATE);
END;
/

CREATE OR REPLACE PROCEDURE PR_HPES (P_PES_ID INTEGER, P_PES_ANO INTEGER, P_PES_CARGO VARCHAR, P_PES_MUNICIPIO VARCHAR, P_PES_DATA DATE, P_PES_ENTREVISTAS INTEGER, P_PES_MARGEM_MAIS NUMBER, P_PES_MARGEM_MENOS NUMBER, P_PES_INS_ID INTEGER, P_PES_ORG_ID INTEGER, P_PES_EST_ID INTEGER)  
IS
BEGIN  
    INSERT INTO H_PESQUISAS VALUES (P_PES_ID, P_PES_ANO, P_PES_CARGO, P_PES_MUNICIPIO, P_PES_DATA, P_PES_ENTREVISTAS, P_PES_MARGEM_MAIS, P_PES_MARGEM_MENOS, P_PES_INS_ID, P_PES_ORG_ID, P_PES_EST_ID, SYSDATE);  
END;
/

--TABELA ABORDAGENS
create sequence seq_abo nocache;

create trigger tg_bI_abo
before insert on ABORDAGENS
for each row
begin
    :new.abo_id := seq_abo.nextval;
end;

--TABELA ESTADOS
create sequence seq_est nocache;

create trigger tg_bI_est
before insert on ESTADOS
for each row
begin
  :new.est_id := seq_est.nextval;
end;

--TABELA INSTITUTOS
create sequence seq_ins nocache;

create trigger tg_bI_ins
before insert on INSTITUTOS
for each row
begin
  :new.ins_id := seq_ins.nextval;
end;

--TABELA ORGAOS
create sequence seq_org nocache;

create trigger tg_bI_org
before insert on ORGAOS
for each row
begin
  :new.org_id := seq_org.nextval;
end;

--TABELA PARTIDOS
create sequence seq_par nocache;

create trigger tg_bI_par
before insert on PARTIDOS
for each row
begin
  :new.par_id := seq_par.nextval;
end;
