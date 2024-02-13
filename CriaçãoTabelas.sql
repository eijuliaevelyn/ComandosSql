CREATE DATABASE ControleDeCaminhoes
GO
USE ControleDeCaminhoes

-- Criação da tabela Caminhão.
CREATE TABLE Caminhao(
    Id INT PRIMARY KEY IDENTITY,
    Modelo VARCHAR (100) NOT NULL,
    AnoFabricacao SMALLINT NOT NULL,
    CapacidadeCarga SMALLINT NOT NULL,
    Placa CHAR (7) NOT NULL,
    DocumentoVeiculo CHAR (17) NOT NULL
);

-- Criação da tabela Motorista.
CREATE TABLE Motorista(
    Id INT PRIMARY KEY IDENTITY,
    NomeCompleto VARCHAR (160) NOT NULL,
    DataNascimento DATE NOT NULL,
    Idade TINYINT NULL,
    CPF BIGINT NOT NULL,
    Telefone BIGINT NOT NULL,
    NumeroHabilitacao CHAR (9) NOT NULL
);

-- Criação da tabela UF.
CREATE TABLE UF(
    Id TINYINT PRIMARY KEY IDENTITY,
    Sigla VARCHAR (5) NOT NULL
)

-- Criação da tabela Cidade.
CREATE TABLE Cidade(
    Id SMALLINT PRIMARY KEY IDENTITY,
    IdUF TINYINT NOT NULL,
    Nome VARCHAR (90) NOT NULL,
    CidadeUF VARCHAR (95) NOT NULL,
    FOREIGN KEY (IdUF) REFERENCES UF (Id)
);

-- Criação da tabela Rota.
CREATE TABLE Rota(
    Id INT PRIMARY KEY IDENTITY,
    IdCidadeOrigem SMALLINT NOT NULL,
    IdCidadeDestino SMALLINT NOT NULL,
    DistanciaKM SMALLINT NOT NULL,
    TempoEstimado SMALLINT NOT NULL,
    CondicoesEstrada VARCHAR (15) NOT NULL,
    ValorPedagio MONEY NOT NULL,
    ValorGasolina MONEY NOT NULL,
    ValorGastoTotal MONEY NOT NULL,
    FOREIGN KEY (IdCidadeOrigem) REFERENCES Cidade (Id),
    FOREIGN KEY (IdCidadeDestino) REFERENCES Cidade (Id)
);

-- Criação da tabela Carga.
CREATE TABLE Carga(
    Id SMALLINT PRIMARY KEY IDENTITY,
    TipoCarga VARCHAR (40) NOT NULL,
    NomeCarga VARCHAR (80) NOT NULL
);

-- Criação da tabela Entrega.
CREATE TABLE Entrega(
    Id INT PRIMARY KEY IDENTITY,
    IdCarga SMALLINT NOT NULL,
    IdCaminhao INT NOT NULL,
    IdMotorista INT NOT NULL,
    IdRota INT NOT NULL, 
    PesoCarga SMALLINT NOT NULL,
    DataEntrega SMALLDATETIME NULL,
    HoraPartida TIME NOT NULL,
    HoraChegada TIME NOT NULL,
    Entregue BIT NOT NULL,
    FOREIGN KEY (IdCarga) REFERENCES Carga (Id),
    FOREIGN KEY (IdCaminhao) REFERENCES Caminhao (Id),
    FOREIGN KEY (IdMotorista) REFERENCES Motorista (Id),
    FOREIGN KEY (IdRota) REFERENCES Rota (Id) 
);
