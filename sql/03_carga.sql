-- Carga dos dados tratados (saida do notebook de ETL) para o banco SQLite.
--
-- Os comandos ".mode"/".import" sao especificos do CLI do SQLite (nao fazem parte do
-- padrao ANSI, que nao normatiza carga de arquivo) — e a forma padrao de popular um
-- banco SQLite a partir de CSV. Caminhos relativos a raiz do repositorio.
--
-- Executar em ordem: dimensoes antes da fato (respeita as FKs).

.mode csv

.import --skip 1 dados/tratados/dim_operadora.csv dim_operadora
.import --skip 1 dados/tratados/dim_beneficiario.csv dim_beneficiario
.import --skip 1 dados/tratados/dim_especialidade.csv dim_especialidade
.import --skip 1 dados/tratados/dim_tempo.csv dim_tempo
.import --skip 1 dados/tratados/fato_atendimento.csv fato_atendimento
