create sequence seq_stg nocache;

create trigger tg_bI_stg
before insert on STAGE
for each row
begin
    :new.stg_id := seq_stg.nextval;
end;

CREATE or replace PROCEDURE PR_STG IS
    BEGIN
        INSERT INTO STAGE (
        SELECT
            0,
            can_id AS stg_can_id,
            can_nome AS stg_can_nome,
            can_condicao AS stg_can_condicao,
            fil_par_id AS stg_par_id,
            par_sigla AS stg_par_nome,
            fil_pes_id AS stg_pes_id,
            pes_cargo AS stg_pes_cargo,
            pes_data AS stg_pes_data,
            pes_ano AS stg_pes_ano,
            pes_nome_municipio AS stg_pes_municipio,
            est_nome AS stg_est_nome,
            est_id AS stg_est_id,
            ins_nome AS stg_ins_nome
        FROM
            CANDIDATOS INNER JOIN FILIACOES ON can_id = fil_can_id 
                       INNER JOIN PARTIDOS ON par_id = fil_par_id
                       INNER JOIN PESQUISAS ON pes_id = fil_pes_id
                       INNER JOIN ESTADOS ON est_id = pes_est_id
                       INNER JOIN INSTITUTOS ON ins_id = pes_ins_id
        );
    END PR_STG;
/
    
