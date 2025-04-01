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