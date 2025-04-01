CREATE TABLE hospital (
    id_hospital SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    cnpj VARCHAR(14) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    UNIQUE (cnpj)
);
CREATE TABLE medico (
    id_medico SERIAL PRIMARY KEY,
    especialidade VARCHAR(100),
    crm INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    UNIQUE (crm)
);
CREATE TABLE Paciente (
    id_paciente SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    telefone VARCHAR(11),
    data_nascimento DATE NOT NULL,
    endereco VARCHAR(255),
    UNIQUE (cpf)
);
CREATE TABLE Recepcionista (
    id_recepcionista SERIAL PRIMARY KEY,    
    cpf VARCHAR(14) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    UNIQUE (cpf)
);
CREATE TABLE Cadastro (
    id_cadastro SERIAL PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_recepcionista INT NOT NULL,
    UNIQUE (id_recepcionista, id_paciente),
    FOREIGN KEY (id_recepcionista) REFERENCES Recepcionista(id_recepcionista),
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente)
);
CREATE TABLE Enfermeiros (
   id_enfermeiro SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    coren INT NOT NULL,
    UNIQUE (coren)
);
CREATE TABLE Consulta (
    id_consulta SERIAL PRIMARY KEY,    
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    data DATE NOT NULL,
    diagnostico VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES Medico(id_medico)
);
CREATE TABLE Triagem (
    id_triagem SERIAL PRIMARY KEY,
    sintomas VARCHAR(255) NOT NULL,
    id_consulta INT NOT NULL,
    id_enfermeiro INT NOT NULL,
    data DATE NOT NULL,
    classificacao_risco VARCHAR(100) NOT NULL,
    UNIQUE (id_consulta, id_enfermeiro),
    FOREIGN KEY (id_enfermeiro) REFERENCES Enfermeiros(id_enfermeiro)
);
CREATE TABLE Exame (
    id_exame SERIAL PRIMARY KEY,
    resultado VARCHAR(255) NOT NULL,
    id_consulta INT NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    data DATE NOT NULL,
    FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta)
);
CREATE TABLE Receita (
    id_receita SERIAL PRIMARY KEY,
    prescricao VARCHAR(255) NOT NULL,
    data DATE NOT NULL,
    medicamento VARCHAR(255),
    id_consulta INT NOT NULL,
    FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta)
);
CREATE TABLE Internacao (
    id_internacao SERIAL PRIMARY KEY,
    data_alta DATE,
    data_entrada DATE NOT NULL,
    id_consulta INT NOT NULL,
    UNIQUE (id_internacao, id_consulta),
    FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta)
);
CREATE TABLE Leitos (
    id_leito SERIAL PRIMARY KEY,
    numero_leito INT NOT NULL,
    status VARCHAR(100) NOT NULL,
    id_internacao INT,
    UNIQUE (numero_leito, id_internacao),
    FOREIGN KEY (id_internacao) REFERENCES Internacao(id_internacao)
);
CREATE TABLE Alta (
    id_alta SERIAL PRIMARY KEY,
    data DATE,
    condicao VARCHAR(255),
    id_consulta INT,
    FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta)
);
INSERT INTO hospital (id_hospital, nome, telefone, cnpj, endereco)
VALUES
(1, 'Hospital São Lucas', '2422316657', '31153067000190', 'Rua das Flores, 123 - Petropolis'),
(2, 'Hospital Santa Maria', '2422338007', '29138344000143', 'Avenida Independência, 456 - Petropolis');

INSERT INTO medico (id_medico, especialidade, crm, nome)
VALUES
(1, 'Cardiologista', 28459, 'Dr. Paulo Almeida'),
(2, 'Neurologista', 52973, 'Dra. Ana Ribeiro'),
(3, 'Ortopedista', 37841, 'Dr. Carlos Menezes'),
(4, 'Dermatologista', 64128, 'Dra. Mariana Costa');

INSERT INTO Paciente (id_paciente, nome, cpf, telefone, data_nascimento, endereco)
VALUES
(1, 'João Silva', '15782734721', '24981234567', '1980-01-06', 'Rua da Harmonia, 45 - Petropolis'),
(2, 'Maria Santos', '23456789712', '24997654321', '1990-02-15', 'Avenida Primavera, 120 - Petropolis'),
(3, 'Carlos Souza', '34567890723', '24992345678', '1985-05-10', 'Travessa São Pedro, 87 - Petropolis'),
(4, 'Ana Costa', '45678901734', '24999876543', '1992-08-20', 'Praça do Sol, 33 - Petropolis');

INSERT INTO Recepcionista (id_recepcionista, cpf, nome)
VALUES
(1, '15789734721', 'Joana Almeida'),
(2, '20647757783', 'Ricardo Lima'),
(3, '34767877745', 'Patrícia Silva'),
(4, '89012345778', 'Fernando Souza');

INSERT INTO Cadastro (id_paciente, id_recepcionista)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

INSERT INTO Enfermeiros (id_enfermeiro, nome, coren)
VALUES
(1, 'Luiza Teixeira', 374926),
(2, 'Marco Lima', 271543),
(3, 'Clara Mendes', 593782),
(4, 'João Prado', 487310);

INSERT INTO Consulta (id_consulta, id_paciente, id_medico, data, diagnostico)
VALUES
(1, 1, 1, '2025-03-10', 'Hipertensão controlada'),
(2, 2, 2, '2025-03-11', 'Cefaleia crônica'),
(3, 3, 3, '2025-03-12', 'Fratura de úmero'),
(4, 4, 4, '2025-03-13', 'Dermatite de contato');

INSERT INTO Triagem (sintomas, id_consulta, id_enfermeiro, data, classificacao_risco)
VALUES
('Dor no peito', 1, 1, '2025-03-10', 'Alta'),
('Dor de cabeça', 2, 2, '2025-03-11', 'Moderada'),
('Braço inchado', 3, 3, '2025-03-12', 'Moderada'),
('Coceira intensa', 4, 4, '2025-03-13', 'Baixa');

INSERT INTO Exame (resultado, id_consulta, tipo, data)
VALUES
('Normal', 1, 'Eletrocardiograma', '2025-03-10'),
('Anormalidade leve', 2, 'Ressonância Magnética', '2025-03-11'),
('Fratura identificada', 3, 'Raio-X', '2025-03-12'),
('Lesão superficial', 4, 'Biópsia', '2025-03-13');

INSERT INTO Receita (prescricao, data, medicamento, id_consulta)
VALUES
('Tomar Losartana 50mg 1x ao dia', '2025-03-10', 'Losartana', 1),
('Tomar Analgésico 2x ao dia', '2025-03-11', 'Paracetamol', 2),
('Imobilizar braço por 4 semanas', '2025-03-12', NULL, 3),
('Aplicar pomada tópica 2x ao dia', '2025-03-13', 'Hidrocortisona', 4);

INSERT INTO Internacao (id_internacao, data_alta, data_entrada, id_consulta)
VALUES
(1, NULL, '2025-03-12', 3),
(2, '2025-03-15', '2025-03-13', 4); 

INSERT INTO Leitos (numero_leito, status, id_internacao)
VALUES
(101, 'Livre', NULL),
(102, 'Ocupado', 1), 
(103, 'Livre', NULL),
(104, 'Livre', NULL);

INSERT INTO Alta (data, condicao, id_consulta)
VALUES
('2025-03-15', 'Melhora total', 1),
('2025-03-17', 'Melhora parcial', 2),
(NULL, NULL, 3), 
('2025-03-15', 'Tratamento concluído', 4); 
