-- || Pedro A P || --
--DROP USER pedroAP;
CREATE USER pedroAP
    IDENTIFIED BY pedroAP;

--DROP ROLE supervisor;
CREATE ROLE supervisor;
GRANT ALL PRIVILEGES, DBA
    TO supervisor;
    
--DROP ROLE dev;
CREATE ROLE dev;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE TABLESPACE, CREATE MATERIALIZED VIEW
    TO dev;

GRANT supervisor
    TO pedroAP;
    
ALTER USER pedroAP
    QUOTA UNLIMITED
    ON SYSTEM;
-- || \ || --

-- || Invader || --
CREATE USER invader
    IDENTIFIED BY invader;
    
GRANT outsider
    TO invader;

CREATE ROLE outsider;

--/ login \--
GRANT CREATE SESSION
    TO outsider;

-- / SELECT on all tables \-- 
GRANT SELECT
    ON pedroAP.guilda
    TO outsider;
GRANT SELECT
    ON pedroAP.taverneiro
    TO outsider;
GRANT SELECT
    ON pedroAP.time
    TO outsider;
GRANT SELECT
    ON pedroAP.aventureiro
    TO outsider;
GRANT SELECT
    ON pedroAP.missao
    TO outsider;

--/ CRUD \--
GRANT INSERT, UPDATE, DELETE
    ON pedroAP.missao
    TO outsider;
GRANT INSERT, UPDATE, DELETE
    ON pedroAP.aventureiro
    TO outsider;
    
--/ views \--
GRANT SELECT
    ON pedroAP.v_aventureiro_elite
    TO outsider;
GRANT SELECT
    ON pedroAP.v_aventureiro_lider
    TO outsider;
GRANT SELECT
    ON pedroAP.v_missao_bloodshed
    TO outsider;
GRANT SELECT
    ON pedroAP.v_missao_recompensas
    TO outsider;
GRANT SELECT
    ON pedroAP.aventureiros_nos_times
    TO outsider;
    
--/ sequence \--
GRANT SELECT
    ON pedroAP.missao_id_sqc
    TO outsider;

--/ revoking delete \--
REVOKE DELETE
    ON pedroAP.missao
    FROM outsider;
REVOKE DELETE
    ON pedroAP.aventureiro
    FROM outsider;