---------------------------------------------
--Criação da tabela não normalizada
CREATE TABLE TABELAO(
    id_pesquisa VARCHAR2(100),
    ano VARCHAR2(100),
    sigla_uf VARCHAR2(100),
    nome_municipio VARCHAR2(100),
    cargo VARCHAR2(100),
    pes_data VARCHAR2(100),
    data_referencia VARCHAR2(100),
    instituto VARCHAR2(100),
    contratante VARCHAR2(100),
    orgao_registro VARCHAR2(100),
    numero_registro VARCHAR2(100), 
    quantidade_entrevistas VARCHAR2(100),
    margem_mais VARCHAR2(100),
    margem_menos VARCHAR2(100),
    tipo VARCHAR2(100),
    turno VARCHAR2(100),
    tipo_voto VARCHAR2(100),
    id_cenario VARCHAR2(100), 
    descricao_cenario VARCHAR2(100),
    id_candidato_poder360 VARCHAR2(100),
    nome_candidato VARCHAR2(100),
    sigla_partido VARCHAR2(100),
    condicao VARCHAR2(100),
    percentual VARCHAR2(100)
);

--TABELAS DE METADADOS
INSERT INTO ABORDAGENS VALUES(null, 'estimulada');
INSERT INTO ABORDAGENS VALUES(null, 'espontânea');
INSERT INTO ABORDAGENS VALUES(null, 'rejeição');

insert into ESTADOS (est_sigla, est_nome)VALUES ( 'AC', 'ACRE');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'AL', 'ALAGOAS');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'AP', 'AMAPÁ');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'AM', 'AMAZONAS');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'BA', 'BAHIA');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'CE', 'CEARÁ');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'ES', 'ESPIRITO SANTO');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'GO', 'GOIÁS');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'MA', 'MARANHÃO');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'MT', 'MATO GROSSO');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'MS', 'MATO GROSSO DO SUL');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'MG', 'MINAS GERAIS');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'PA', 'PARÁ');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'PB', 'PARAÍBA');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'PR', 'PARANÁ');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'PE', 'PERNAMBUCO');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'PI', 'PIAUÍ');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'RJ', 'RIO DE JANEIRO');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'RN', 'RIO GRANDE DO NORTE');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'RS', 'RIO GRANDE DO SUL');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'RO', 'RONDÔNIA');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'RR', 'RORAIMA');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'SC', 'SANTA CATARINA');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'SP', 'SAO PAULO');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'SE', 'SERGIPE');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'TO', 'TOCANTINS');
insert into ESTADOS (est_sigla, est_nome)VALUES ( 'DF', 'DISTRITO FEDERAL');

--ATUALIZAÇÃO DA FK DOS METADADOS
UPDATE TABELAO
SET tipo = (SELECT ABO_ID FROM ABORDAGENS WHERE ABO_NOME = TABELAO.TIPO);

UPDATE TABELAO
SET SIGLA_UF = (SELECT EST_ID FROM ESTADOS WHERE EST_SIGLA = TABELAO.SIGLA_UF);

UPDATE TABELAO
SET INSTITUTO = (SELECT INS_ID FROM INSTITUTOS WHERE INS_NOME = TABELAO.INSTITUTO);

UPDATE TABELAO
SET ORGAO_REGISTRO = (SELECT ORG_ID FROM ORGAOS WHERE ORG_NOME = TABELAO.ORGAO_REGISTRO);

UPDATE TABELAO
SET SIGLA_PARTIDO = (SELECT PAR_ID FROM PARTIDOS WHERE PAR_SIGLA = TABELAO.SIGLA_PARTIDO);

----------------------------------------------------------
--INSERÇÃO DAS TABELAS SEM FK

INSERT INTO ORGAOS (SELECT DISTINCT 0, ORGAO_REGISTRO, NUMERO_REGISTRO FROM TABELAO);
INSERT INTO INSTITUTOS (SELECT DISTINCT 0, INSTITUTO FROM TABELAO);
INSERT INTO CANDIDATOS (SELECT DISTINCT ID_CANDIDATO_PODER360, NOME_CANDIDATO, CONDICAO FROM TABELAO);
INSERT INTO PARTIDOS (SELECT DISTINCT 0, SIGLA_PARTIDO FROM TABELAO);

----------------------------------------------------------
--CARGA NAS TABELAS COM FK
INSERT INTO PESQUISAS (
    SELECT DISTINCT
        TO_NUMBER(ID_PESQUISA),
        TO_NUMBER(ANO),
        CARGO,
        NOME_MUNICIPIO,
        TO_DATE(PES_DATA, 'YYYY-MM-DD'),
        QUANTIDADE_ENTREVISTAS,
        TO_NUMBER(MARGEM_MAIS, '999.99'),
        TO_NUMBER(MARGEM_MENOS, '999.99'),
        INSTITUTO,
        ORGAO_REGISTRO,
        SIGLA_UF
    FROM
        TABELAO
);

INSERT INTO CENARIOS (
    SELECT DISTINCT
        TO_NUMBER(ID_CENARIO),
        DESCRICAO_CENARIO,
        TO_NUMBER(TURNO),
        TIPO_VOTO,
        TO_NUMBER(ID_PESQUISA),
        TO_NUMBER(TIPO)
    FROM
        TABELAO
);

DESCRIBE CENARIOS;

SELECT DISTINCT TIPO FROM TABELAO;

INSERT INTO PERCENTUAIS (
    SELECT DISTINCT
        TO_NUMBER(ID_CANDIDATO_PODER360),
        TO_NUMBER(ID_CENARIO),
        TO_NUMBER(PERCENTUAL, '999.99')
    FROM
        TABELAO
);

INSERT INTO FILIACOES (
    SELECT distinct
        TO_NUMBER(SIGLA_PARTIDO),
        TO_NUMBER(ID_CANDIDATO_PODER360),
        TO_NUMBER(ID_PESQUISA)
    FROM
        TABELAO
);


select * from PESQUISAS;
select * from ORGAOS;
select * from INSTITUTOS;
select * from CENARIOS;
select * from CANDIDATOS;
select * from ABORDAGENS;
select * from PERCENTUAIS;
select * from PARTIDOS;
select * from FILIACOES;
SELECT * FROM ESTADOS;
SELECT * FROM TABELAO;
