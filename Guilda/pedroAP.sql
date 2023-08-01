-- || Create Tables || --
CREATE TABLE guilda (
  nome VARCHAR2(20) PRIMARY KEY NOT NULL,
  taverneiro_mestre VARCHAR2(20)
);

CREATE TABLE taverneiro (
  titulo VARCHAR2(20) PRIMARY KEY NOT NULL,
  idade NUMBER(3,0),
  data_entrada DATE
);

CREATE TABLE time (
  nome VARCHAR2(20) PRIMARY KEY NOT NULL,
  foco VARCHAR2(20),
  guilda_nome VARCHAR2(20)
);

CREATE TABLE aventureiro (
  titulo VARCHAR2(20) PRIMARY KEY NOT NULL,
  classe VARCHAR2(15),
  lvl NUMBER(4,1) NOT NULL,
  arma_principal VARCHAR2(20),
  lider_status CHAR(1) NOT NULL,
  time_nome VARCHAR2(20)
);

CREATE TABLE registra_classe_aventureiro (
    titulo_aventureiro VARCHAR2(20),
    classe_antiga VARCHAR2(15),
    classe_nova VARCHAR2(15),
    data_alt DATE
);

CREATE TABLE missao (
  id NUMBER(5,0) PRIMARY KEY NOT NULL,
  level_necessario NUMBER(3,0),
  recompensa_qtd NUMBER(5,0) NOT NULL,
  recompensa_nome VARCHAR2(15) NOT NULL,
  monstros_qtd NUMBER(6,0),
  localidade VARCHAR2(25) NOT NULL,
  time_responsavel VARCHAR2(25)
);
-- || \ || --

-- || Create Sequences || --
CREATE SEQUENCE missao_id_sqc
    INCREMENT BY 1
    START WITH 100
    MAXVALUE 9999
    CYCLE
    NOCACHE;
-- || \ || --

    
-- || Create View || --
CREATE OR REPLACE VIEW v_aventureiro_elite AS
    SELECT titulo, classe, lvl, lider_status, time_nome
        FROM aventureiro
        WHERE lvl = 50;

CREATE OR REPLACE VIEW v_aventureiro_lider AS
    SELECT titulo, lvl
        FROM aventureiro
            WHERE lider_status = 's';
        
CREATE OR REPLACE VIEW v_missao_bloodshed AS
    SELECT id, level_necessario, monstros_qtd, recompensa_nome, localidade
        FROM missao
        WHERE monstros_qtd > 10;
        
CREATE OR REPLACE VIEW v_missao_recompensas AS
    SELECT id, recompensa_nome, localidade
        FROM missao;

--/ Materialized \--
CREATE MATERIALIZED VIEW aventureiros_nos_times
     BUILD IMMEDIATE
     REFRESH COMPLETE
     ON DEMAND
     AS SELECT titulo, lvl, time_nome
          FROM aventureiro
          ORDER BY time_nome, lvl;


-- || Alter Tables || --
ALTER TABLE guilda
    ADD CONSTRAINT guild_taverneiro_fk
    FOREIGN KEY (taverneiro_mestre)
    REFERENCES taverneiro(titulo);
    
ALTER TABLE time
    ADD CONSTRAINT time_guilda_fk
    FOREIGN KEY (guilda_nome)
    REFERENCES guilda(nome);
    
ALTER TABLE aventureiro
    ADD CONSTRAINT aventureiro_time_fk
    FOREIGN KEY (time_nome)
    REFERENCES time(nome);

ALTER TABLE registra_classe_aventureiro
    ADD CONSTRAINT r_c_aventureiro_pk
    PRIMARY KEY(titulo_aventureiro, data_alt);
    
ALTER TABLE registra_classe_aventureiro
    ADD CONSTRAINT r_c_aventureiro_titulo_fk
    FOREIGN KEY(titulo_aventureiro)
    REFERENCES aventureiro(titulo);
    
ALTER TABLE missao
    ADD CONSTRAINT missao_time_fk
    FOREIGN KEY (time_responsavel)
    REFERENCES time(nome);
-- || / || --
    
-- || Inserts || --

--/ Taverneiros \--
INSERT INTO taverneiro
    VALUES('Rubeus Hagrid', 75, TO_DATE('31-10-1940','DD-MM-YYYY'));

INSERT INTO taverneiro
    VALUES('Harth Stonebrew', 83, TO_DATE('11-03-2014','DD-MM-YYYY'));
    
INSERT INTO taverneiro
    VALUES('Kimlya Darnassus', 30, TO_DATE('29-07-592','DD-MM-YYYY'));
    
INSERT INTO taverneiro
    VALUES('Bacarux Feratus', 212, TO_DATE('01-02-2222','DD-MM-YYYY'));
    
INSERT INTO taverneiro
    VALUES('Ictos Anthonivs', 34, TO_DATE('01-02-2017','DD-MM-YYYY'));
    
    
--/ Guildas \--
INSERT INTO guilda
    VALUES('Paragon', 'Harth Stonebrew');
    
INSERT INTO guilda
    VALUES('Astranaar', 'Kimlya Darnassus');

INSERT INTO guilda
    VALUES('The Marauders', 'Rubeus Hagrid');
    
INSERT INTO guilda
    VALUES('A1s', 'Bacarux Feratus');
    
INSERT INTO guilda
    VALUES('The Flying Dutchman', 'Ictos Anthonivs');

    
--/ Times \--
INSERT INTO time
        VALUES('Ravenclaw', 'Magic nd Knowledge', 'The Marauders');
    
INSERT INTO time
    VALUES('Gryffindor', 'Magic nd Honour', 'The Marauders');
    

INSERT INTO time
    VALUES('Balance', 'Equilibrium', 'Paragon');

INSERT INTO time
    VALUES('Horde', 'Chaos', 'Astranaar');
    
INSERT INTO time
    VALUES('Alliance', 'Protection', 'Paragon');
    

INSERT INTO time
    VALUES('ClassicA1s', 'Nonsense', 'A1s');

/*INSERT INTO time
    VALUES('MalasiadA1s', 'Survival', null, 'A1s');
    

INSERT INTO time
    VALUES('Jaesmgae', 'Violence', null, 'The Flying Dutchman');
    
INSERT INTO time
    VALUES('Gurlpwr', 'Kindness', null, 'The Flying Dutchman');
*/  

--/ Aventureirxs \--
--desc aventureiro;
--delete from aventureiro where titulo LIKE 'Vereesa Windrunner';
INSERT INTO aventureiro
    VALUES('Rowena Ravenclaw', 'Mage', 110, 'Wand', 's', 'Ravenclaw');
    
INSERT INTO aventureiro
    VALUES('Luna Lovegood', 'Witch', 24, 'Eyes', 'n', 'Ravenclaw');

INSERT INTO aventureiro
    VALUES('Myrtle Warren', 'Apparition', 12, 'Mind', 'n', 'Ravenclaw');
    
/*INSERT INTO time (numero_aventureiros)
    VALUES((SELECT COUNT(*)
        FROM time
            WHERE nome = 'Ravenclaw'));
*/
    
INSERT INTO aventureiro
    VALUES('Godric Gryffindor', 'Wizard', 115, 'Sword', 's', 'Gryffindor');

INSERT INTO aventureiro
    VALUES('Minerva McGonagall', 'Witch', 85, 'Wand', 'n', 'Gryffindor');
    
INSERT INTO aventureiro
    VALUES('Neville Longbottom', 'Wizard', 31, 'Wand', 'n', 'Gryffindor');
    

INSERT INTO aventureiro
    VALUES('Muradin Bronzebeard', 'Warrior', 40, 'Hammer', 'y', 'Balance');
    
INSERT INTO aventureiro
    VALUES('Sylvanas Windrunner', 'Ranger', 45, 'Bow nd Arrow', 'n', 'Balance');
    
INSERT INTO aventureiro
    VALUES('Gul''dan', 'Warlock', 45, 'Staff', 'n', 'Balance'); 
    
    
INSERT INTO aventureiro
    VALUES('Thrall', 'Warrior', 53, 'Hammer', 's', 'Horde');

INSERT INTO aventureiro
    VALUES('Vol''jin', 'Shaman', 42, 'Double-edged Dagger', 'n', 'Horde');
    
INSERT INTO aventureiro
    VALUES('ETC', 'Bards', 90, 'Instruments', 'n', 'Horde');
    
    
INSERT INTO aventureiro
    VALUES('Malfurion Stormrage', 'Druid', 50, 'Claws', 's', 'Alliance');

INSERT INTO aventureiro
    VALUES('Brann Bronzebeard', 'Hunter', 37, 'Flintlock Rifle', 'n', 'Alliance');

INSERT INTO aventureiro
    VALUES('Jaina Proudmoore', 'Mage', 30, 'Staff of Antonidas', 'n', 'Alliance');
    
--/ Missões \--
desc missao;
INSERT INTO missao (id, level_necessario, recompensa_qtd, recompensa_nome, monstros_qtd, localidade)
    VALUES(missao_id_sqc.NEXTVAL, 15, 10, 'Ancient Gem', 100, 'Valkyria''s Planices');

INSERT INTO missao
    VALUES(missao_id_sqc.NEXTVAL, 28, 1, 'Mobilius Rod', 23, 'Sanctum Patium', 'Ravenclaw');

INSERT INTO missao (id, level_necessario, recompensa_qtd, recompensa_nome, monstros_qtd, localidade)
    VALUES(missao_id_sqc.NEXTVAL, 3, 10, 'Mistery Meat', 10, 'Boar''s Hideout');

INSERT INTO missao (id, level_necessario, recompensa_qtd, recompensa_nome, monstros_qtd, localidade)
    VALUES(missao_id_sqc.NEXTVAL, 35, 1, 'King''s Artifact', 1, 'Hellog Hull');

INSERT INTO missao
    VALUES(missao_id_sqc.NEXTVAL, 13, 1000, 'Felafel Gold', 0, 'Stormwind Capital', 'Horde');



-- || Functions || --

-- = \ \ = --
SET SERVEROUTPUT ON;
SET VERIFY OFF;
-- = \ \ = --

--select * from aventureiro;
--select * from missao;

-- gets average level of the adventures from the selected team
CREATE OR REPLACE FUNCTION media_lvl_time (
    p_nome_time aventureiro.time_nome%TYPE
) RETURN VARCHAR2 IS
    v_lvl_medio NUMBER;

BEGIN

    --checks if the selected team name exists on DB, to then return the average level of the adventurers in it 
    SELECT AVG(av.lvl) INTO v_lvl_medio
        FROM aventureiro av
            JOIN time t
                ON t.nome = av.time_nome
        WHERE av.time_nome = p_nome_time;
        
    RETURN ROUND(v_lvl_medio,1);
        
END media_lvl_time;

SELECT media_lvl_time('Ravenclaw') AS "Level Medio"
    FROM dual;
-- \\ --


--select * from guilda;

--gets the sum amount of teams on asked guild
CREATE OR REPLACE FUNCTION times_na_guilda (
    p_nome_guilda guilda.nome%TYPE
) RETURN VARCHAR2 IS
    times NUMBER;
    
BEGIN 
    
    SELECT COUNT(*) INTO times
        FROM time
        WHERE time.guilda_nome = INITCAP(p_nome_guilda);
        
    RETURN ('Total de times na guilda ' || INITCAP(p_nome_guilda) || ': ' || times);

EXCEPTION
        -- |-> when no "obj" is found, NO_DATA_FOUND is triggered
        WHEN NO_DATA_FOUND
            THEN RETURN 'Guilda não encontrada.';
            
        WHEN OTHERS
            THEN RETURN ('Erro no input: ' || sqlerrm);
            
END times_na_guilda;

SELECT times_na_guilda('Paragon')
    FROM dual;
-- \\ --
    

-- || Procedures || --
--desc aventureiro;
--changes the class of a given adventurer
CREATE OR REPLACE PROCEDURE muda_classe_aventureiro (
    p_nome_aventureiro IN aventureiro.titulo%TYPE,
    p_nova_classe IN aventureiro.classe%TYPE)
    
    IS aventureiro_exists NUMBER;

BEGIN
    --first checks if adventurer exists on bd
    SELECT COUNT(*) INTO aventureiro_exists
        FROM aventureiro
        WHERE aventureiro.titulo = INITCAP(p_nome_aventureiro)
            OR
            aventureiro.titulo = UPPER(p_nome_aventureiro);
        
    --if so, changes their class
    IF aventureiro_exists > 0
        THEN
            UPDATE aventureiro SET
                classe = INITCAP(p_nova_classe)
                WHERE titulo = INITCAP(p_nome_aventureiro)
                    OR
                    aventureiro.titulo = UPPER(p_nome_aventureiro);
                
            DBMS_OUTPUT.PUT_LINE('Classe de '|| INITCAP(p_nome_aventureiro) || ' foi atualizada com sucesso!');
            COMMIT;
    
    --if not, then a msg is shown to the user
    ELSE
        DBMS_OUTPUT.PUT_LINE('Aventureirx não encontradx.');
    END IF;
    
EXCEPTION
    WHEN OTHERS
        THEN
            DBMS_OUTPUT.PUT_LINE('Erro de entrada: ' || sqlerrm);
            ROLLBACK;

END muda_classe_aventureiro;

--select * from aventureiro;
desc aventureiro;
EXEC muda_classe_aventureiro('ETC', 'bardo');
-- \\ --


--changes the team assign to the chosen mission
CREATE OR REPLACE PROCEDURE muda_time_da_missao(
    id_missao IN missao.id%TYPE,
    time_selecionado IN missao.time_responsavel%TYPE
    
) IS missao_can_update NUMBER;
    
    BEGIN
    
        --checks if mission exists
        SELECT COUNT(*) INTO missao_can_update
            FROM missao
            WHERE id = id_missao;
        
        --... and the team too
        SELECT COUNT(*) INTO missao_can_update
            FROM time
            WHERE nome = INITCAP(time_selecionado);
            
        --if so, it updates the team responsible for the mission
        IF missao_can_update > 0
            THEN
                UPDATE missao SET
                    time_responsavel = INITCAP(time_selecionado);
                COMMIT;
            
                DBMS_OUTPUT.PUT_LINE('A missão ' || id_missao || ' agora pertence ao time '|| INITCAP(time_selecionado));
        
        --otherwise, pops a msg for the user saying it was a bad input
        ELSE
            DBMS_OUTPUT.PUT_LINE('Valores inválidos.');
        
        END IF;
        
EXCEPTION
    WHEN OTHERS
        THEN
            DBMS_OUTPUT.PUT_LINE('Erro de entrada: ' || sqlerrm);
            ROLLBACK;

END muda_time_da_missao;

EXEC muda_time_da_missao(150, 'Alliance');
-- \\ --

-- || Triggers || --

--trigger for when the user adds/changes anything on the mission board
ALTER TABLE missao ADD ultima_mudanca DATE;

CREATE OR REPLACE TRIGGER registra_alteracao_missao
    BEFORE 
        INSERT OR UPDATE 
            ON missao
    FOR EACH ROW
    
    BEGIN
        :new.ultima_mudanca := sysdate;

END registra_alteracao;

INSERT INTO missao
    VALUES(missao_id_sqc.NEXTVAL, 5, 30, 'Food Condiments', 10, 'Forbidden Forest', null, null);
-- \\ --

--in case there's an alteration on an adventurer's class, it triggers
CREATE OR REPLACE TRIGGER registra_alteracao_classe
    BEFORE
        UPDATE
            OF classe
            ON aventureiro
                FOR EACH ROW
                    WHEN (new.classe <> old.classe)
    
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Classe antiga: ' || :old.classe);
        DBMS_OUTPUT.PUT_LINE('Nova classe: ' || :new.classe);
        
        INSERT INTO REGISTRA_CLASSE_AVENTUREIRO
            VALUES(:old.titulo, :old.classe, :new.classe, sysdate);

END registra_alteracao_classe;

EXEC muda_classe_aventureiro('Myrtle Warren', 'Ghost');
SELECT * FROM REGISTRA_CLASSE_AVENTUREIRO;
-- \\ --

-- || Indexes || --
--teams responsible for the missions
CREATE INDEX missao_time_idx
    ON missao(time_responsavel);

--adventurers' class
CREATE INDEX aventureiro_classe_idx
    ON aventureiro(classe);

--guild's innkeepers
CREATE INDEX guilda_taverneiro_idx
    ON guilda(taverneiro_mestre);
-- \\ --

-- || Selects || --
SELECT * 
    FROM guilda;
    
SELECT *
    FROM taverneiro;
    
SELECT *
    FROM time;
    
SELECT *
    FROM aventureiro;

SELECT *
    FROM missao;
    
SELECT a.titulo as "Aventureirx", a.lvl as "Lvl Avent.", a.time_nome as "Time", m.localidade as "Local", m.level_necessario as "Lvl Req."
    FROM aventureiro a
        JOIN time t
            ON a.time_nome = t.nome
        JOIN missao m
            ON a.time_nome = m.time_responsavel
        WHERE m.time_responsavel IS NOT NULL;
     
SELECT COUNT(*) as "Aventureirxs", t.nome as "Time"
    FROM aventureiro a
        JOIN time t
            ON a.time_nome = t.nome
    GROUP BY time_nome;
    
SELECT SUM(recompensa_qtd) as "Recompensas Disponiveis"
    FROM missao
        WHERE time_responsavel IS NULL;
        
SELECT t.nome as "Time", ROUND(AVG(lvl), 2) as "Level Geral"
    FROM time t
        JOIN aventureiro a
            ON t.nome = a.time_nome
        GROUP BY t.nome;
        

        
-- || Drops ||
/*drop table aventureiro;
drop table missao;
drop table time;
drop table guilda;
drop table taverneiro;*/