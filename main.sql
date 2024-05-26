CREATE TABLE dispositivo (
    codD INT NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    CONSTRAINT pk_dispositivo PRIMARY KEY (codD)
);

CREATE TABLE usuario (
	codU int NOT NULL,
    nome VARCHAR(30) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    fone VARCHAR(15),
    CONSTRAINT pk_usuario PRIMARY KEY (codU)
);

CREATE TABLE biblioteca (
	codB INT NOT NULL,
    CONSTRAINT pk_biblioteca PRIMARY KEY (codB)
);

CREATE TABLE historico (
	codH INT NOT NULL,
	CONSTRAINT pk_historico PRIMARY KEY (codh)
);

CREATE TABLE playlist (
	codP INT NOT NULL,
    nome VARCHAR(30) NOT NULL,
    criador VARCHAR(30) NOT NULL,
    dataCriacao DATE NOT NULL,
    CONSTRAINT pk_playlist PRIMARY KEY (codP)
);

CREATE TABLE musica (
	codM INT NOT NULL,
    duracao INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    CONSTRAINT pk_musica PRIMARY KEY (codM)
);

CREATE TABLE genero (
	codG INT NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    CONSTRAINT pk_genero PRIMARY KEY (codG)
);

CREATE TABLE album (
	codA INT NOT NULL,
    nome VARCHAR(30) NOT NULL,
    CONSTRAINT pk_album PRIMARY KEY (codA)
);

CREATE TABLE artista (
	codART INT NOT NULL,
    nome VARCHAR(30) NOT NULL,
    ouvintes INT NOT NULL,
    seguidores INT NOT NULL,
    CONSTRAINT pk_artista PRIMARY KEY (codART)
);

CREATE TABLE logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    action VARCHAR(50) NOT NULL,
    table_name VARCHAR(50) NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details VARCHAR(255)
);

ALTER TABLE dispositivo
ADD COLUMN codU INT,
ADD CONSTRAINT fk_usuario_codU FOREIGN KEY (codU) REFERENCES usuario(codU) ON DELETE CASCADE;

ALTER TABLE biblioteca
ADD COLUMN codh INT,
ADD COLUMN codu INT,
ADD CONSTRAINT fk_historico_codh FOREIGN KEY (codh) REFERENCES historico(codh) ON DELETE CASCADE,
ADD CONSTRAINT fk_usuario_biblioteca_codu FOREIGN KEY (codu) REFERENCES usuario(codU) ON DELETE CASCADE;

ALTER TABLE playlist
ADD COLUMN codB INT,
ADD CONSTRAINT fk_playlist_codB FOREIGN KEY (codB) REFERENCES biblioteca(codB) ON DELETE CASCADE;

ALTER TABLE musica	
ADD COLUMN codG INT,
ADD COLUMN codA INT,
ADD CONSTRAINT fk_genero_codG FOREIGN KEY (codG) REFERENCES genero(codG),
ADD CONSTRAINT fk_album_codA FOREIGN KEY (codA) REFERENCES album(codA);

CREATE TABLE playlist_musica(
	codP INT,
    codM INT,
    PRIMARY KEY (codP, codM),
    FOREIGN KEY (codP) REFERENCES playlist(codP) ON DELETE CASCADE,
    FOREIGN KEY (codM) REFERENCES musica(codM)
);

CREATE TABLE musica_artista (
	codM INT,
    codART INT,
    PRIMARY KEY (codM, codART),
    FOREIGN KEY (codM) REFERENCES musica(codM),
    FOREIGN KEY (codART) REFERENCES artista(codART)
);


-- TRIGGERS

DELIMITER //

CREATE TRIGGER Tgr_Dispositivo_Insert 
AFTER INSERT ON dispositivo
FOR EACH ROW 
BEGIN
    INSERT INTO logs (action, table_name, timestamp) VALUES ('INSERT', 'dispositivo', NOW());
END//

CREATE TRIGGER Tgr_Usuario_Insert 
AFTER INSERT ON usuario
FOR EACH ROW 
BEGIN
    INSERT INTO logs (action, table_name, timestamp) VALUES ('INSERT', 'usuario', NOW());
END//

CREATE TRIGGER Tgr_Biblioteca_Insert 
AFTER INSERT ON biblioteca
FOR EACH ROW 
BEGIN
    INSERT INTO logs (action, table_name, timestamp) VALUES ('INSERT', 'biblioteca', NOW());
END//

CREATE TRIGGER Tgr_Historico_Insert 
AFTER INSERT ON historico
FOR EACH ROW 
BEGIN
    INSERT INTO logs (action, table_name, timestamp) VALUES ('INSERT', 'historico', NOW());
END//

CREATE TRIGGER Tgr_Playlist_Insert 
AFTER INSERT ON playlist
FOR EACH ROW 
BEGIN
    INSERT INTO logs (action, table_name, timestamp) VALUES ('INSERT', 'playlist', NOW());
END//

CREATE TRIGGER Tgr_Musica_Insert 
AFTER INSERT ON musica
FOR EACH ROW 
BEGIN
    INSERT INTO logs (action, table_name, timestamp) VALUES ('INSERT', 'musica', NOW());
END//

CREATE TRIGGER Tgr_Genero_Insert 
AFTER INSERT ON genero
FOR EACH ROW 
BEGIN
    INSERT INTO logs (action, table_name, timestamp) VALUES ('INSERT', 'genero', NOW());
END//

CREATE TRIGGER Tgr_Album_Insert 
AFTER INSERT ON album
FOR EACH ROW 
BEGIN
    INSERT INTO logs (action, table_name, timestamp) VALUES ('INSERT', 'album', NOW());
END//

CREATE TRIGGER Tgr_Artista_Insert 
AFTER INSERT ON artista
FOR EACH ROW 
BEGIN
    INSERT INTO logs (action, table_name, timestamp) VALUES ('INSERT', 'artista', NOW());
END//

CREATE TRIGGER Tgr_Playlist_Musica_Insert 
AFTER INSERT ON playlist_musica
FOR EACH ROW 
BEGIN
    INSERT INTO logs (action, table_name, timestamp) VALUES ('INSERT', 'playlist_musica', NOW());
END//

CREATE TRIGGER Tgr_Musica_Artista_Insert 
AFTER INSERT ON musica_artista
FOR EACH ROW 
BEGIN
    INSERT INTO logs (action, table_name, timestamp) VALUES ('INSERT', 'musica_artista', NOW());
END//

DELIMITER ;

/*consultas: */
INSERT INTO usuario (codU, nome, cpf, fone)
VALUES (1, 'gabriel', '12345678901', '123456789');

INSERT INTO biblioteca (codB, codu)
VALUES (1, 1);

 INSERT INTO dispositivo (codD, tipo, codU) VALUES (1, 'Smartphone', 1);
 INSERT INTO dispositivo (codD, tipo, codU) VALUES (2, 'Notebook', 1);
 
INSERT INTO genero(codG, tipo) VALUES (1, 'Rock');
INSERT INTO genero(codG, tipo) VALUES (2, 'MPB');
INSERT INTO genero(codG, tipo) VALUES (3, 'Pop');

INSERT INTO playlist (codP, nome, criador, dataCriacao, codB)
VALUES (1, 'Minha Playlist', 'Victor', '2024-05-16', 1);
INSERT INTO playlist (codP, nome, criador, dataCriacao, codB)
VALUES (2, 'Nossa Playlist', 'Duda', '2024-05-16', 1);

INSERT INTO musica(codM, nome, duracao) VALUES (1, 'Thriller', 210);
INSERT INTO musica(codM, nome, duracao) VALUES (2, 'Garota de Ipanema', 180);
INSERT INTO musica(codM, nome, duracao) VALUES (3, 'Dont Cry', 300);
INSERT INTO musica(codM, nome, duracao) VALUES (4, 'Bohemian Rhapsody ', 200);
INSERT INTO musica(codM, nome, duracao) VALUES (5, 'Your Song', 330);
INSERT INTO musica(codM, nome, duracao) VALUES (6, 'Naquela Mesa', 180);
INSERT INTO musica(codM, nome, duracao) VALUES (7, 'Paradise City', 280);

INSERT INTO album(codA, nome) VALUES(1, 'Thriller');
INSERT INTO album(codA, nome) VALUES(2, 'Elton John');
INSERT INTO album(codA, nome) VALUES(3, 'A Night at the Opera');
INSERT INTO album(codA, nome) VALUES(4, 'Appetite for Destruction');

UPDATE musica SET codA = 1 WHERE codM = 1;
UPDATE musica SET codA = 2 WHERE codM = 5;
UPDATE musica SET codA = 3 WHERE codM = 4;
UPDATE musica SET codA = 4 WHERE codM = 7;

UPDATE musica SET codG = 3 WHERE codM = 1;
UPDATE musica SET codG = 2 WHERE codM = 2;
UPDATE musica SET codG = 1 WHERE codM = 3;
UPDATE musica SET codG = 1 WHERE codM = 4;
UPDATE musica SET codG = 1 WHERE codM = 5;
UPDATE musica SET codG = 2 WHERE codM = 6;
UPDATE musica SET codG = 1 WHERE codM = 7;

INSERT INTO artista(codART, nome, ouvintes, seguidores) VALUES (1, 'Elton John', 500000, 100000);
INSERT INTO artista(codART, nome, ouvintes, seguidores) VALUES (2, 'Queen', 800000, 150000);
INSERT INTO artista(codART, nome, ouvintes, seguidores) VALUES (3, 'Tom Jobin', 70000, 80000);
INSERT INTO artista(codART, nome, ouvintes, seguidores) VALUES (4, 'Michael Jackson', 190000, 220000);
INSERT INTO artista(codART, nome, ouvintes, seguidores) VALUES (5, 'Nelson Gonçalves', 6000, 1000);
INSERT INTO artista(codART, nome, ouvintes, seguidores) VALUES (6, 'Guns N roses', 190000, 220000);

INSERT INTO musica_artista(codM, codART) VALUES(1,4);
INSERT INTO musica_artista(codM, codART) VALUES(2,3);
INSERT INTO musica_artista(codM, codART) VALUES(3,6);
INSERT INTO musica_artista(codM, codART) VALUES(4,2);
INSERT INTO musica_artista(codM, codART) VALUES(5,1);
INSERT INTO musica_artista(codM, codART) VALUES(6,5);
INSERT INTO musica_artista(codM, codART) VALUES(7,6);

INSERT INTO playlist_musica (codP, codM) VALUES (1, 1);
INSERT INTO playlist_musica (codP, codM) VALUES (1, 2);
INSERT INTO playlist_musica (codP, codM) VALUES (1, 3);
INSERT INTO playlist_musica (codP, codM) VALUES (2, 4);
INSERT INTO playlist_musica (codP, codM) VALUES (2, 5);
INSERT INTO playlist_musica (codP, codM) VALUES (2, 6);
INSERT INTO playlist_musica (codP, codM) VALUES (1, 7);

CREATE VIEW MusicaArtista AS
SELECT m.codM, m.nome, m.duracao, g.tipo
FROM musica m 
JOIN musica_artista ma ON m.codM = ma.codM
JOIN artista a ON ma.codART = a.codART
JOIN genero g ON g.codG = m.codG;

CREATE VIEW UsuarioDispositivo AS
SELECT u.codU, u.nome, d.codD, d.tipo
FROM dispositivo d
JOIN usuario u ON u.codU = d.codU;

CREATE VIEW MusicaGenero AS
SELECT m.codM, m.nome, m.duracao, g.tipo
FROM musica m
JOIN genero g ON g.codG = m.codG;

CREATE VIEW PlaylistUsuario AS
SELECT p.codP, p.nome, p.criador, p.dataCriacao
FROM usuario u
JOIN biblioteca b ON b.codu = u.codU
JOIN playlist p ON b.codB = p.codB;

CREATE VIEW MusicaPlaylist AS
SELECT m.codM, m.nome AS nomeMusica, m.duracao, g.tipo, a.nome AS nomeArtista
FROM playlist p
JOIN playlist_musica pm ON p.codP = pm.codP
JOIN musica m ON pm.codM = m.codM
JOIN musica_artista ma ON m.codM = ma.codM
JOIN artista a ON ma.codART = a.codART
JOIN genero g ON m.codG = g.codG;

DELIMITER $$

CREATE PROCEDURE adiciona_musica_playlist (
    IN codM INT,
    IN codP INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO logs (action, table_name, details)
        VALUES ('ERROR', 'playlist_musica', 'Falha ao adicionar música à playlist');
    END;

    INSERT INTO playlist_musica (codP, codM)
    VALUES (codP, codM);
END $$

CREATE PROCEDURE adiciona_musica_artista(
    IN codART INT,
    IN codM INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO logs (action, table_name, details)
        VALUES ('ERROR', 'musica_artista', CONCAT('Falha ao relacionar musica ', codM, ' com o artista ', codART));
    END;
    
    INSERT INTO musica_artista (codM, codART)
    VALUES (codM, codART);
END $$

CREATE PROCEDURE adiciona_dispositivo_usuario(
    IN codD INT,
    IN codU INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO logs (action, table_name, details)
        VALUES ('ERROR', 'dispositivo', CONCAT('Falha ao relacionar dispositivo ', codD, ' com o usuario ', codU));
    END;

    UPDATE dispositivo
    SET codU = codU
    WHERE codD = codD;
END $$

CREATE PROCEDURE adiciona_musica_album(
    IN codM INT,
    IN codA INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO logs (action, table_name, details)
        VALUES ('ERROR', 'musica', CONCAT('Falha ao relacionar musica ', codM, ' com o album ', codA));
    END;
    UPDATE musica
    SET codA = codA
    WHERE codM = codM;
END $$

DELIMITER ;