--Grupo 5 - Projeto BD - Veterinaria

-- Criação da tabela Atendente
CREATE TABLE Atendente (
    id_atendente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(15) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE
);

-- Criação da tabela Paciente
CREATE TABLE Paciente (
    id_paciente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    dt_nascimento DATE NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(15) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Criação da tabela Dentista
CREATE TABLE Dentista (
    id_dentista SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    cro VARCHAR(10) NOT NULL UNIQUE,
    espec VARCHAR(100) NOT NULL
);

-- Criação da tabela Consulta
CREATE TABLE Consulta (
    id_consulta SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    horario TIME NOT NULL,
    status VARCHAR(20) CHECK (status IN ('agendada', 'confirmada', 'cancelada', 'concluída')) NOT NULL,
    prescricao VARCHAR(100),
    desc_atendimento VARCHAR(100),
    id_paciente INT NOT NULL REFERENCES Paciente(id_paciente),
    id_dentista INT NOT NULL REFERENCES Dentista(id_dentista)
);

-- Criação da tabela Procedimento
CREATE TABLE Procedimento (
    id_procedimento SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100),
    duracao_media TIME NOT NULL
);

-- Criação da tabela Horario_Atendimento
CREATE TABLE Horario_Atendimento (
    id_h_atendimento SERIAL PRIMARY KEY,
    id_dentista INT NOT NULL REFERENCES Dentista(id_dentista),
    data DATE NOT NULL,
    horario TIME NOT NULL,
    status VARCHAR(20) CHECK (status IN ('disponível', 'reservado')) NOT NULL
);

-- Criação da tabela intermediária Consulta_Procedimento
CREATE TABLE Consulta_Procedimento (
    id_consulta_procedimento SERIAL PRIMARY KEY,
    id_consulta INT NOT NULL REFERENCES Consulta(id_consulta),
    id_procedimento INT NOT NULL REFERENCES Procedimento(id_procedimento)
);

-- Criação da tabela Alt_Paciente (alterações de Paciente)
CREATE TABLE Alt_Paciente (
    id_alt_paciente SERIAL PRIMARY KEY,
    id_atendente INT NOT NULL REFERENCES Atendente(id_atendente),
    id_paciente INT NOT NULL REFERENCES Paciente(id_paciente),
    motivo VARCHAR(100) NOT NULL,
    dt_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Criação da tabela Alt_Consulta (alterações de Consulta)
CREATE TABLE Alt_Consulta (
    id_alt_consulta SERIAL PRIMARY KEY,
    id_atendente INT NOT NULL REFERENCES Atendente(id_atendente),
    id_consulta INT NOT NULL REFERENCES Consulta(id_consulta),
    motivo VARCHAR(100) NOT NULL,
    dt_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Criação da tabela Alt_Dentista (alterações de Dentista)
CREATE TABLE Alt_Dentista (
    id_alt_dentista SERIAL PRIMARY KEY,
    id_atendente INT NOT NULL REFERENCES Atendente(id_atendente),
    id_dentista INT NOT NULL REFERENCES Dentista(id_dentista),
    motivo VARCHAR(100) NOT NULL,
    dt_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

INSERT INTO Atendente (nome, email, telefone, cpf) VALUES
('Ana Silva', 'ana.silva@email.com', '11999991111', '11122233344'),
('Bruno Oliveira', 'bruno.oliveira@email.com', '21988882222', '22233344455'),
('Carla Rodrigues', 'carla.rodrigues@email.com', '31977773333', '33344455566'),
('Daniel Santos', 'daniel.santos@email.com', '41966664444', '44455566677'),
('Elaine Costa', 'elaine.costa@email.com', '51955555555', '55566677788'),
('Fabio Pereira', 'fabio.pereira@email.com', '61944446666', '66677788899'),
('Gabriela Souza', 'gabriela.souza@email.com', '71933337777', '77788899900'),
('Henrique Gomes', 'henrique.gomes@email.com', '81922228888', '88899900011'),
('Isabela Lima', 'isabela.lima@email.com', '91911119999', '99900011122'),
('Julio Mendes', 'julio.mendes@email.com', '12900000000', '00011122233');

INSERT INTO Paciente (nome, dt_nascimento, cpf, telefone, endereco, email) VALUES
('Laura Almeida', '1990-05-15', '12345678901', '11987654321', 'Rua A, 100', 'laura.almeida@email.com'),
('Marcos Castro', '1985-12-01', '23456789012', '21976543210', 'Rua B, 200', 'marcos.castro@email.com'),
('Natalia Ribeiro', '2000-03-20', '34567890123', '31965432109', 'Rua C, 300', 'natalia.ribeiro@email.com'),
('Otavio Fernandes', '1978-09-10', '45678901234', '41954321098', 'Rua D, 400', 'otavio.fernandes@email.com'),
('Paula Barbosa', '1995-07-25', '56789012345', '51943210987', 'Rua E, 500', 'paula.barbosa@email.com'),
('Ricardo Cunha', '2002-11-30', '67890123456', '61932109876', 'Rua F, 600', 'ricardo.cunha@email.com'),
('Sara Dias', '1980-04-05', '78901234567', '71921098765', 'Rua G, 700', 'sara.dias@email.com'),
('Thiago Eduardo', '1998-08-15', '89012345678', '81910987654', 'Rua H, 800', 'thiago.eduardo@email.com'),
('Vanessa Ferreira', '2005-01-22', '90123456789', '91909876543', 'Rua I, 900', 'vanessa.ferreira@email.com'),
('Wilson Gomes', '1975-06-12', '01234567890', '12998765432', 'Rua J, 1000', 'wilson.gomes@email.com');

INSERT INTO Dentista (nome, cpf, cro, espec) VALUES
('Xavier Pereira', '10111213141', 'CRO12345', 'Clínico Geral'),
('Yasmin Souza', '11121314151', 'CRO67890', 'Ortodontista'),
('Zacarias Lima', '12131415161', 'CRO13579', 'Endodontista'),
('Amanda Mendes', '13141516171', 'CRO24680', 'Periodontista'),
('Bernardo Nunes', '14151617181', 'CRO12233', 'Implantodontista'),
('Cecilia Oliveira', '15161718191', 'CRO45566', 'Odontopediatra'),
('Diego Rodrigues', '16171819201', 'CRO78899', 'Protesista'),
('Eduarda Santos', '17181920211', 'CRO11223', 'Cirurgião Bucomaxilofacial'),
('Felipe Costa', '18192021221', 'CRO44556', 'Estomatologista'),
('Giovanna Pereira', '19202122231', 'CRO77889', 'Dentística');

INSERT INTO Consulta (data, horario, status, prescricao, desc_atendimento, id_paciente, id_dentista) VALUES
('2023-10-27', '10:00:00', 'agendada', 'N/A', 'Primeira consulta', 1, 1),
('2023-10-28', '14:30:00', 'confirmada', 'N/A', 'Limpeza', 2, 2),
('2023-10-29', '09:00:00', 'concluída', 'Analgésico', 'Extração', 3, 3),
('2023-10-30', '11:00:00', 'cancelada', 'N/A', 'N/A', 4, 4),
('2023-10-31', '15:00:00', 'agendada', 'N/A', 'Clareamento', 5, 5),
('2023-11-01', '10:30:00', 'confirmada', 'N/A', 'Aparelho', 6, 6),
('2023-11-02', '14:00:00', 'concluída', 'Antibiótico', 'Canal', 7, 7),
('2023-11-03', '09:30:00', 'cancelada', 'N/A', 'N/A', 8, 8),
('2023-11-04', '11:30:00', 'agendada', 'N/A', 'Implante', 9, 9),
('2023-11-05', '15:30:00', 'confirmada', 'N/A', 'Prótese', 10, 10);

INSERT INTO Procedimento (nome, descricao, duracao_media) VALUES
('Limpeza', 'Remoção de tártaro e placa', '01:00:00'),
('Extração', 'Remoção de dente', '01:30:00'),
('Clareamento', 'Clareamento dental', '02:00:00'),
('Aparelho', 'Colocação de aparelho ortodôntico', '02:30:00'),
('Canal', 'Tratamento de canal', '03:00:00'),
('Implante', 'Implante dentário', '03:30:00'),
('Prótese', 'Colocação de prótese dentária', '04:00:00'),
('Restauração', 'Restauração de cárie', '01:00:00'),
('Raspagem', 'Raspagem periodontal', '01:30:00'),
('Profilaxia', 'Prevenção de doenças bucais', '00:45:00');

INSERT INTO Horario_Atendimento (id_dentista, data, horario, status) VALUES
(1, '2023-10-27', '10:00:00', 'reservado'),
(2, '2023-10-28', '14:30:00', 'reservado'),
(3, '2023-10-29', '09:00:00', 'reservado'),
(4, '2023-10-30', '11:00:00', 'disponível'),
(5, '2023-10-31', '15:00:00', 'reservado'),
(6, '2023-11-01', '10:30:00', 'reservado'),
(7, '2023-11-02', '14:00:00', 'reservado'),
(8, '2023-11-03', '09:30:00', 'disponível'),
(9, '2023-11-04', '11:30:00', 'reservado'),
(10, '2023-11-05', '15:30:00', 'reservado');

INSERT INTO Consulta_Procedimento (id_consulta, id_procedimento) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO Alt_Paciente (id_atendente, id_paciente, motivo, dt_atualizacao) VALUES
(1, 1, 'Alteração de endereço', '2023-10-27 10:00:00'),
(2, 2, 'Alteração de telefone', '2023-10-28 14:30:00'),
(3, 3, 'Alteração de email', '2023-10-29 09:00:00'),
(4, 4, 'Alteração de nome', '2023-10-30 11:00:00'),
(5, 5, 'Alteração de data de nascimento', '2023-10-31 15:00:00'),
(6, 6, 'Alteração de endereço', '2023-11-01 10:30:00'),
(7, 7, 'Alteração de telefone', '2023-11-02 14:00:00'),
(8, 8, 'Alteração de email', '2023-11-03 09:30:00'),
(9, 9, 'Alteração de nome', '2023-11-04 11:30:00'),
(10, 10, 'Alteração de data de nascimento', '2023-11-05 15:30:00');

INSERT INTO Alt_Consulta (id_atendente, id_consulta, motivo, dt_atualizacao) VALUES
(1, 1, 'Remarcação', '2023-10-27 10:00:00'),
(2, 2, 'Cancelamento', '2023-10-28 14:30:00'),
(3, 3, 'Alteração de dentista', '2023-10-29 09:00:00'),
(4, 4, 'Alteração de horário', '2023-10-30 11:00:00'),
(5, 5, 'Alteração de prescrição', '2023-10-31 15:00:00'),
(6, 6, 'Remarcação', '2023-11-01 10:30:00'),
(7, 7, 'Cancelamento', '2023-11-02 14:00:00'),
(8, 8, 'Alteração de dentista', '2023-11-03 09:30:00'),
(9, 9, 'Alteração de horário', '2023-11-04 11:30:00'),
(10, 10, 'Alteração de prescrição', '2023-11-05 15:30:00');

INSERT INTO Alt_Dentista (id_atendente, id_dentista, motivo, dt_atualizacao) VALUES
(1, 1, 'Alteração de especialidade', '2023-10-27 10:00:00'),
(2, 2, 'Alteração de CRO', '2023-10-28 14:30:00'),
(3, 3, 'Alteração de nome', '2023-10-29 09:00:00'),
(4, 4, 'Alteração de especialidade', '2023-10-30 11:00:00'),
(5, 5, 'Alteração de CRO', '2023-10-31 15:00:00'),
(6, 6, 'Alteração de nome', '2023-11-01 10:30:00'),
(7, 7, 'Alteração de especialidade', '2023-11-02 14:00:00'),
(8, 8, 'Alteração de CRO', '2023-11-03 09:30:00'),
(9, 9, 'Alteração de nome', '2023-11-04 11:30:00'),
(10, 10, 'Alteração de especialidade', '2023-11-05 15:30:00');

-- Criação de índice para horários livres em Horario_Atendimento
CREATE INDEX idx_horario_disponivel
ON Horario_Atendimento (status, data, horario)
WHERE status = 'disponível';

-- Criação de índice para busca por CPF na tabela Paciente
CREATE INDEX idx_paciente_cpf
ON Paciente (cpf);

-- Atualizar telefone do paciente com base no CPF
UPDATE Paciente
SET telefone = '24999785674'
WHERE cpf = '12345678901';

-- Alterar o horário do atendimento
UPDATE Horario_Atendimento
SET status = 'reservado'
WHERE data = '2023-10-31' AND horario = '15:00:00';

---- Atualizar a especialidade de um dentista na tabela dentista
UPDATE Dentista
SET espec = 'Implantodontista'
WHERE id_dentista = 1;

--Comando para a exclusão de 3 registros com condições em alguma tabela.
DELETE FROM Atendente
WHERE nome = 'Nome do Atendente';

DELETE FROM Atendente
WHERE cpf = '12345678901';

DELETE FROM Atendente
WHERE email = 'email@exemplo.com';

-- Consulta para contar o número de consultas por especialidade
SELECT d.espec AS Especialidade, COUNT(c.id_consulta) AS Total_Consultas
FROM Dentista d
INNER JOIN Consulta c ON d.id_dentista = c.id_dentista
GROUP BY d.espec
ORDER BY Total_Consultas DESC;

-- Consulta para quantidade de consultas realizadas por cada dentista
SELECT d.nome AS Nome_Dentista, COUNT(c.id_consulta) AS Total_Consultas
FROM Dentista d
INNER JOIN Consulta c ON d.id_dentista = c.id_dentista
GROUP BY d.nome
ORDER BY Total_Consultas DESC;

-- Consulta para listar os pacientes com maior número de consultas
SELECT p.nome AS Nome_Paciente, COUNT(c.id_consulta) AS Total_Consultas
FROM Paciente p
INNER JOIN Consulta c ON p.id_paciente = c.id_paciente
GROUP BY p.nome
ORDER BY Total_Consultas DESC;

-- Criação da VIEW para lista de consultas ordenadas por data
CREATE VIEW vw_consultas_ordenadas AS
SELECT 
    c.id_consulta AS ID_Consulta,
    p.nome AS Nome_Paciente,
    d.nome AS Nome_Dentista,
    c.data AS Data_Consulta,
    STRING_AGG(pr.nome, ', ' ORDER BY pr.nome) AS Procedimentos_Realizados
FROM Consulta c
INNER JOIN Paciente p ON c.id_paciente = p.id_paciente
INNER JOIN Dentista d ON c.id_dentista = d.id_dentista
INNER JOIN Consulta_Procedimento cp ON c.id_consulta = cp.id_consulta
INNER JOIN Procedimento pr ON cp.id_procedimento = pr.id_procedimento
GROUP BY c.id_consulta, p.nome, d.nome, c.data
ORDER BY c.data DESC;

-- Consulta para calcular a média de consultas por dentista
SELECT 
    ROUND(AVG(consulta_por_dentista.total_consultas), 1) AS Media_Consultas_Por_Dentista
FROM (
    SELECT d.id_dentista, 
           COUNT(c.id_consulta) AS total_consultas
    FROM Dentista d
    LEFT JOIN Consulta c ON d.id_dentista = c.id_dentista
    GROUP BY d.id_dentista
    ) AS consulta_por_dentista;