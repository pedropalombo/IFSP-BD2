INSERT INTO pedroAP.missao
    VALUES(pedroAP.missao_id_sqc.NEXTVAL, 9, 25, 'Ritual Bones', 10, 'The Docks', 'Gryffindor');
    
INSERT INTO pedroAP.aventureiro
    VALUES('Astro Josna', 'Witch', 11, 'Energy', 's', 'ClassicA1s');
    
SELECT COUNT(*)
    FROM pedroAP.guilda;
    
SELECT titulo, lvl
    FROM pedroAP.aventureiro
    ORDER BY lvl;
