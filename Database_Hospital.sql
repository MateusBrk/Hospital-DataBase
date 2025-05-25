CREATE DATABASE HospitalDB;
USE HospitalDB;

CREATE TABLE Especialidades (
    id_especialidade INT PRIMARY KEY AUTO_INCREMENT,
    tipo_especialidade VARCHAR(100)
);

CREATE TABLE Medicos (
    crm VARCHAR(10) PRIMARY KEY,
    nome_medico VARCHAR(100),
    cpf_medico CHAR(11),
    tipo_medico VARCHAR(50),
    email_medico VARCHAR(100),
    telefone_medico VARCHAR(15)
);

CREATE TABLE Medico_Especialidade (
    id_medico_especialidade INT PRIMARY KEY AUTO_INCREMENT,
    especialidade_id INT,
    medico_crm VARCHAR(10),
    FOREIGN KEY (especialidade_id) REFERENCES Especialidades(id_especialidade),
    FOREIGN KEY (medico_crm) REFERENCES Medicos(crm)
);

CREATE TABLE Convenio (
    id_convenio INT PRIMARY KEY AUTO_INCREMENT,
    nome_convenio VARCHAR(100),
    cnpj CHAR(14),
    tempo_carencia INT
);

CREATE TABLE Pacientes (
    cpf CHAR(11) PRIMARY KEY,
    rg VARCHAR(20),
    nome VARCHAR(100),
    data_de_nascimento DATE,
    telefone VARCHAR(15),
    email VARCHAR(100),
    convenio_id INT,
    FOREIGN KEY (convenio_id) REFERENCES Convenio(id_convenio)
);

CREATE TABLE Endereco (
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    rua VARCHAR(100),
    numero VARCHAR(10),
    complemento VARCHAR(50),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    estado CHAR(2),
    cep CHAR(8),
    medico_crm VARCHAR(10),
    medico_cpf CHAR(11),
    FOREIGN KEY (medico_crm) REFERENCES Medicos(crm),
    FOREIGN KEY (medico_cpf) REFERENCES Pacientes(cpf)
);

CREATE TABLE Consultas (
    id_consultas INT PRIMARY KEY AUTO_INCREMENT,
    data_e_hora DATETIME,
    valor_consulta DECIMAL(10,2),
    medico_crm VARCHAR(10),
    paciente_cpf CHAR(11),
    convenio_id INT,
    especialidade_id INT,
    FOREIGN KEY (medico_crm) REFERENCES Medicos(crm),
    FOREIGN KEY (paciente_cpf) REFERENCES Pacientes(cpf),
    FOREIGN KEY (convenio_id) REFERENCES Convenio(id_convenio),
    FOREIGN KEY (especialidade_id) REFERENCES Especialidades(id_especialidade)
);

CREATE TABLE RelatorioReceita (
    id_relatorio INT PRIMARY KEY AUTO_INCREMENT,
    descricao TEXT,
    medicamento VARCHAR(100),
    quantidade INT,
    instrucoes_de_uso TEXT,
    paciente_cpf CHAR(11),
    medico_crm VARCHAR(10),
    consulta_id INT,
    FOREIGN KEY (paciente_cpf) REFERENCES Pacientes(cpf),
    FOREIGN KEY (medico_crm) REFERENCES Medicos(crm),
    FOREIGN KEY (consulta_id) REFERENCES Consultas(id_consultas)
);

CREATE TABLE Internacao (
    id_internacao INT PRIMARY KEY AUTO_INCREMENT,
    data_entrada DATE,
    data_prev_alta DATE,
    data_alta DATE,
    procedimento TEXT,
    id_quarto INT,
    id_enfermeiro INT,
    FOREIGN KEY (id_quarto) REFERENCES Quarto(id_quarto),
    FOREIGN KEY (id_enfermeiro) REFERENCES Enfermeiro(id_enfermeiro)
);

CREATE TABLE Tipo_Quarto (
    id_tipo_quarto INT PRIMARY KEY AUTO_INCREMENT,
    descricao TEXT,
    valor_diaria DECIMAL(10,2)
);

CREATE TABLE Quarto (
    id_quarto INT PRIMARY KEY AUTO_INCREMENT,
    numero INT,
    id_tipo_quarto INT,
    FOREIGN KEY (id_tipo_quarto) REFERENCES Tipo_Quarto(id_tipo_quarto)
);

CREATE TABLE Enfermeiro (
    id_enfermeiro INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cpf CHAR(11),
    cre VARCHAR(15)
);
