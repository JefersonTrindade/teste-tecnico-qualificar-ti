-- Modelo dimensional em estrela — tabela de fato
-- Grao: 1 linha por atendimento (id_atendimento)

CREATE TABLE fato_atendimento (
    id_atendimento    INTEGER PRIMARY KEY,
    id_beneficiario   INTEGER NOT NULL,
    id_operadora      INTEGER NOT NULL,
    id_especialidade  INTEGER NOT NULL,
    data              DATE    NOT NULL,
    valor             DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (id_beneficiario)  REFERENCES dim_beneficiario  (id_beneficiario),
    FOREIGN KEY (id_operadora)     REFERENCES dim_operadora     (id_operadora),
    FOREIGN KEY (id_especialidade) REFERENCES dim_especialidade (id_especialidade),
    FOREIGN KEY (data)             REFERENCES dim_tempo         (data)
);
