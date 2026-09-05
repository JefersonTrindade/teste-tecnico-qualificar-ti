-- Modelo dimensional em estrela — tabelas de dimensao
-- Motor: SQLite (ver sql/README.md). Sintaxe compativel com SQL ANSI.

CREATE TABLE dim_operadora (
    id_operadora INTEGER PRIMARY KEY,
    operadora    VARCHAR(100) NOT NULL
);

CREATE TABLE dim_beneficiario (
    id_beneficiario INTEGER PRIMARY KEY,
    sexo            VARCHAR(20)  NOT NULL,
    idade           DECIMAL(5,1),
    faixa_etaria    VARCHAR(20)  NOT NULL,
    uf              VARCHAR(2)   NOT NULL,
    id_operadora    INTEGER      NOT NULL,
    FOREIGN KEY (id_operadora) REFERENCES dim_operadora (id_operadora)
);

CREATE TABLE dim_especialidade (
    id_especialidade INTEGER PRIMARY KEY,
    especialidade    VARCHAR(60) NOT NULL
);

CREATE TABLE dim_tempo (
    data        DATE PRIMARY KEY,
    ano         INTEGER NOT NULL,
    trimestre   INTEGER NOT NULL,
    mes         INTEGER NOT NULL,
    nome_mes    VARCHAR(20) NOT NULL,
    dia         INTEGER NOT NULL,
    dia_semana  VARCHAR(20) NOT NULL
);
