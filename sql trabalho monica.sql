 -- -----------------------------------------------------
 -- Criando as tabelas
  -- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS CLIENTE (
  CPF VARCHAR(11) NOT NULL,
  ID INT NOT NULL,
  RG VARCHAR(9),
  Nome VARCHAR(85),
  Data_nascimento DATE,
  Email VARCHAR(45),
  Cidade_residencia VARCHAR(100),
  UF VARCHAR(2),
  PRIMARY KEY (CPF));
  
  ALTER TABLE cliente
ADD COLUMN ID INT NOT NULL,

CREATE TABLE IF NOT EXISTS PAGAMENTO (
  Id_pagamento INT NOT NULL,
  Metodo VARCHAR(45),
  Parcelas INT,
  Valor INT,
  Operadora_cartao VARCHAR(30),
  Data_pagamento DATE,
  PRIMARY KEY (Id_pagamento));

CREATE TABLE IF NOT EXISTS RESERVA (
  Codigo_reserva INT NOT NULL,
  Status VARCHAR(45),
  Data_expiracao DATE,
  CLIENTE_CPF VARCHAR(11) NOT NULL,
  Id_pagamento INT NOT NULL,
  DATA_RESERVA DATE,
  PRIMARY KEY (Codigo_reserva),
  INDEX fk_RESERVA_CLIENTE_idx (CLIENTE_CPF ASC) VISIBLE,
  INDEX fk_RESERVA_PAGAMENTO1_idx (Id_pagamento ASC) VISIBLE,
  CONSTRAINT fk_RESERVA_CLIENTE
    FOREIGN KEY (CLIENTE_CPF)
    REFERENCES CLIENTE (CPF)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_RESERVA_PAGAMENTO1
    FOREIGN KEY (Id_pagamento)
    REFERENCES PAGAMENTO (Id_pagamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS VOO (
  Id_voo INT NOT NULL,
  Origem VARCHAR(45),
  Destino VARCHAR(45),
  PRIMARY KEY (Id_voo));

CREATE TABLE IF NOT EXISTS AERONAVE (
  Id_aeronave INT NOT NULL,
  Modelo VARCHAR(45),
  PRIMARY KEY (Id_aeronave));

CREATE TABLE IF NOT EXISTS TRECHO (
  Id_trecho INT NOT NULL,
  Classe VARCHAR(20),
  Data_hora DATETIME,
  Codigo_reserva INT,
  VOO_Id_voo INT,
  AERONAVE_Id_aeronave INT,
  PRIMARY KEY (Id_trecho),
  INDEX fk_TRECHO_RESERVA1_idx (Codigo_reserva ASC) VISIBLE,
  INDEX fk_TRECHO_VOO1_idx (VOO_Id_voo ASC) VISIBLE,
  INDEX fk_TRECHO_AERONAVE1_idx (AERONAVE_Id_aeronave ASC) VISIBLE,
  CONSTRAINT fk_TRECHO_RESERVA1
    FOREIGN KEY (Codigo_reserva)
    REFERENCES RESERVA (Codigo_reserva)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_TRECHO_VOO1
    FOREIGN KEY (VOO_Id_voo)
    REFERENCES VOO (Id_voo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_TRECHO_AERONAVE1
    FOREIGN KEY (AERONAVE_Id_aeronave)
    REFERENCES AERONAVE (Id_aeronave)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    ------------------------------------------------------------------------------------
    -- Fazendo os insets nas tabelas
    ------------------------------------------------------------------------------------
    
    INSERT INTO CLIENTE(CPF, RG, NOME, DATA_NASCIMENTO, EMAIL, CIDADE_RESIDENCIA, UF) VALUES
    (12345678912, 862459789, 'Pedro Schabaraum', '2003-09-29', 'pedronhogameplay@gmail.com', 'São Carlos', 'SC'),
    (32165498713, 456123987, 'Patrick Lemes', '2004-12-10', 'patrickzinho@hotmail.com', 'Chapecó', 'SC'),
    (74125896379, 794613825, 'Orivalndo', '1945-10-17', 'orivaldoluz@outlook.com', 'Caíbi', 'SC'),
    (24136198505, 123456789, 'Ygor Kappaun', '2004-06-17', 'ygorzindugrau@hotmail.com', 'Saudades', 'SC');
    
    INSERT INTO VOO(ID_VOO, ORiGEM, DESTINO) VALUES
    (001, 'Chapecó', 'São paulo'),
    (002, 'Chapecó', 'Rio De Janeiro'),
    (003, 'Bahia', 'Chapecó'),
    (004, 'Argentina', 'Chapecó');
    
    INSERT INTO AERONAVE(ID_AERONAVE, MODELO) VALUES
    (001, 'MGSYR472'),
    (002, 'LSURHA572'),
    (003, 'JFHRP100'),
    (004, 'AAAAA123');
    
    INSERT INTO PAGAMENTO(ID_PAGAMENTO, METODO, PARCELAS, VALOR, OPERADORA_CARTAO, DATA_PAGAMENTO) VALUES
    (001, 'PIX', 1, 2500, 'ELO', '2024-05-29'),
    (002, 'Cartão', 3, 3000, 'VISA', '2024-06-25'),
    (003, 'Cartão', 6, 12000, 'MASTERCARD', '2024-05-19'),
    (004, 'PIX', 1, 4000, 'ELO', '2024-06-24'),
    (005, 'Cartão', 2, 1750);
    
    INSERT INTO RESERVA(CODIGO_RESERVA, STATUS, DATA_EXPIRACAO, CLIENTE_CPF, ID_PAGAMENTO, DATA_RESERVA) VALUES
    (001, 'PAGA', '2024-07-22', 12345678912, 002, '2024-06-22'),
    (002, 'PAGA', '2024-07-04', 24136198505, 004, '2024-06-01'),
    (003, 'PAGA', '2024-06-29', 74125896379, 001, '2024-05-05'),
    (004, 'PAGA', '2024-06-10', 32165498713, 003, '2024-06-25'),
    (005, 'PENDENTE', '2024-06-01', 24136198505, 005, '2024-06-28');
    
    INSERT INTO TRECHO(ID_TRECHO, CLASSE, DATA_HORA, CODIGO_RESERVA, VOO_ID_VOO, AERONAVE_ID_AERONAVE) VALUES
    (001, 'Primeira', '2024-07-24 09:00:00', 003, 001, 004),
    (002, 'Segunda', '2024-07-20 10:35:45', 001, 002, 001),
    (003, 'Primeira', '2024-06-10 12:30:00', 004, 004, 003),
    (004, 'Primeira', '2024-07-01 03:40:00', 002, 003, 002);
    
     -- -----------------------------------------------------
     -- Selects
	 -- ----------------------------------------------------
      
      -- 1
      SELECT T.DATA_HORA, T.CLASSE, V.ORIGEM, V.DESTINO FROM TRECHO T, VOO V
      WHERE t.VOO_Id_voo = v.Id_voo
      AND t.Data_hora BETWEEN '2024-06-01' AND '2024-07-01'
      
      -- 2
       SELECT A.* FROM VOO A, RESERVA B, CLIENTE C, TRECHO D
       WHERE A.ID_VOO = D.VOO_ID_VOO
       AND D.CODIGO_RESERVA = B.CODIGO_RESERVA
       AND B.CLIENTE_CPF = C.CPF
       AND NOME LIKE 'YGOR%';
       
       -- 3
       SELECT B.NOME, B.EMAIL, C.ORIGEM, C.DESTINO FROM RESERVA A, CLIENTE B, VOO C, TRECHO D
       WHERE A.CLIENTE_CPF = B.CPF
       AND D.VOO_ID_VOO = C.ID_VOO
       AND D.CODIGO_RESERVA = A.CODIGO_RESERVA
       AND DATA_RESERVA = CURDATE()
       
       -- 4
       SELECT SUM(VALOR) AS SOMA_DOS_PAGAMENTO FROM PAGAMENTO
       WHERE OPERADORA_CARTAO = 'ELO'
       AND DATA_PAGAMENTO LIKE '2024-07%';
       
       -- 5
       CREATE TABLE IF NOT EXISTS reservas_nao_efetivadas (
       id_reserva INT PRIMARY KEY,
       status VARCHAR(45),
       data_expiracao DATE,
       cliente_cpf VARCHAR(11),
       id_pagamento INT
       );
       
       DELIMITER //
		CREATE PROCEDURE mover_reservas_nao_efetivadas()
		BEGIN

			INSERT INTO reservas_nao_efetivadas (id_reserva, status, data_expiracao, cliente_cpf, id_pagamento)
			SELECT Codigo_reserva, Status, Data_expiracao, CLIENTE_CPF, Id_pagamento
			FROM RESERVA
			WHERE Status != 'PAGA';
    
			DELETE FROM RESERVA
			WHERE Status != 'PAGA';
		END //
		DELIMITER ;
    
		CALL mover_reservas_nao_efetivadas();
        
        -- 6
		DELIMITER //
		CREATE FUNCTION calcular_idade(p_cpf VARCHAR(11))
		RETURNS INT
		DETERMINISTIC
		BEGIN
		DECLARE idade INT;
    
		SELECT TIMESTAMPDIFF(YEAR, Data_nascimento, CURDATE()) INTO idade
		FROM CLIENTE
		WHERE CPF = p_cpf;

		RETURN idade;
		END //
		DELIMITER ;

		SELECT calcular_idade('12345678912') AS idade;
        
        -- 7
        SELECT * FROM CLIENTE
        WHERE DATA_NASCIMENTO LIKE '%06-17%';
        
        -- 8
        SELECT t1.Id_trecho, t1.Classe, t1.Data_hora, t1.Codigo_reserva, t1.VOO_Id_voo, t1.AERONAVE_Id_aeronave FROM TRECHO t1
		JOIN TRECHO t2 ON t1.Codigo_reserva = t2.Codigo_reserva
        WHERE t1.VOO_Id_voo = 1
        AND t2.VOO_Id_voo = 2;
        
        -- 9
        SELECT A.NOME, A.EMAIL FROM CLIENTE A, TRECHO B, RESERVA C
        WHERE B.CODIGO_RESERVA = C.CODIGO_RESERVA
        AND C.CLIENTE_CPF = A.CPF
        AND B.DATA_HORA LIKE '2023%';
        
        -- 10
		DELIMITER //
		CREATE FUNCTION contar_reservas(p_cpf VARCHAR(11), p_data_inicio DATE, p_data_fim DATE)
		RETURNS INT
		DETERMINISTIC
		BEGIN
			DECLARE total_reservas INT;

			SELECT COUNT(*) INTO total_reservas
			FROM RESERVA r
			INNER JOIN CLIENTE c ON r.CLIENTE_CPF = c.CPF
			WHERE c.CPF = p_cpf
			AND r.Data_expiracao BETWEEN p_data_inicio AND p_data_fim;

			RETURN total_reservas;
		END //
		DELIMITER ;

		-- Chamando ela:
		SELECT CONTAR_RESERVAS('12345678901', '2024-01-01', '2024-06-30') AS total_reservas;
