# Scripts SQL

**Motor escolhido:** SQLite — dialeto simples, sem necessidade de instalar/configurar um servidor, e compatível com o testador online usado neste teste.

**Ferramenta de teste/validação:** [sqliteonline.com](https://sqliteonline.com/) — selecionar o motor **SQLite** na interface, colar os scripts (na ordem abaixo) e executar. Por ser um ambiente online volátil, cada sessão cria um banco novo em memória que não persiste após fechar a aba — por isso os resultados obtidos na validação estão documentados abaixo, como referência para quem for reproduzir.

Os 4 scripts foram validados de ponta a ponta localmente (Python + `sqlite3`, carregando os CSVs de `../dados/tratados/`) antes de serem commitados aqui — os resultados abaixo vêm dessa execução.

## Convenção de nomes
Scripts numerados na ordem de execução:
- `01_ddl_dimensoes.sql` — criação das tabelas de dimensão
- `02_ddl_fatos.sql` — criação da tabela de fato
- `03_carga.sql` — carga dos dados tratados via `.import` (CLI do SQLite)
- `04_consultas_validacao.sql` — validação de carga + as 4 consultas de negócio pedidas no teste
- `dashboard_planos_saude.db` — banco SQLite já criado e populado a partir dos scripts acima,
  incluído no repositório para permitir inspeção direta (extensão SQLite do VS Code, DB Browser
  for SQLite, `sqlite3` CLI etc.) sem precisar rodar a carga manualmente. Gerado a partir dos
  mesmos CSVs de `../dados/tratados/` — para reproduzir do zero, rode os 4 scripts na ordem acima
  contra um banco novo.

## Como reproduzir

1. Em [sqliteonline.com](https://sqliteonline.com/) (motor **SQLite**) ou no CLI `sqlite3` local, execute `01_ddl_dimensoes.sql` e depois `02_ddl_fatos.sql`.
2. Carregue os 5 CSVs de `../dados/tratados/` nas tabelas correspondentes — via `03_carga.sql` (CLI) ou pela função de importação de CSV da interface do site, se estiver usando a versão online.
3. Execute os blocos de `04_consultas_validacao.sql` e compare com os resultados de referência abaixo.

## Resultados de referência (reprodutíveis a partir de `dados/tratados/`)

### 0. Validação de carga

| tabela | linhas |
|---|---:|
| dim_operadora | 280 |
| dim_beneficiario | 9.801 |
| dim_especialidade | 26 |
| dim_tempo | 1.339 |
| fato_atendimento | 89.928 |

### 1. As 10 especialidades com maior valor total de atendimentos

| especialidade | valor_total | qtd_atendimentos |
|---|---:|---:|
| Cardiologia | 3.360.603,17 | 6.742 |
| Ortopedia | 3.075.051,75 | 7.383 |
| Clínica Médica | 3.000.687,51 | 10.497 |
| Cirurgia Geral | 2.559.661,76 | 2.450 |
| Oncologia | 2.267.778,36 | 1.754 |
| Neurologia | 1.943.516,71 | 3.286 |
| Cirurgia Vascular | 1.857.918,52 | 1.683 |
| Pediatria | 1.672.861,50 | 5.767 |
| Ginecologia | 1.631.274,86 | 5.657 |
| Gastroenterologia | 1.491.808,79 | 3.229 |

### 2. Valor médio dos atendimentos por operadora (top 10 de 280)

| operadora | valor_medio | qtd_atendimentos |
|---|---:|---:|
| Regional Saúde Brasil 184 | 455,59 | 352 |
| Prime Medical 285 | 453,26 | 261 |
| Uni Saúde Integrada 135 | 449,50 | 255 |
| Ideal Vida Plena 035 | 448,64 | 283 |
| Horizonte Serviços Médicos 229 | 444,53 | 258 |
| Horizonte Saúde Brasil 288 | 444,01 | 274 |
| Integra Vida Plena 099 | 443,71 | 277 |
| Brasil Assistência 284 - Unidade | 442,07 | 232 |
| Total Medical 211 | 441,95 | 240 |
| Nacional Care 024 | 441,02 | 316 |

A lista completa tem 280 operadoras — a query no script retorna todas, sem `LIMIT`.

### 3. Quantidade de atendimentos por UF

| uf | qtd_atendimentos | uf | qtd_atendimentos |
|---|---:|---|---:|
| SP | 13.175 | PB | 2.271 |
| RJ | 9.574 | RN | 2.183 |
| NI* | 8.011 | GO | 2.072 |
| MG | 7.362 | ES | 1.734 |
| RS | 4.972 | SE | 1.665 |
| BA | 4.880 | PI | 1.453 |
| PR | 4.196 | AL | 1.414 |
| SC | 3.578 | TO | 1.409 |
| PE | 3.183 | MA | 1.379 |
| DF | 3.081 | MT | 1.359 |
| PA | 2.768 | AM | 1.273 |
| CE | 2.735 | MS | 1.208 |
| — | — | AC | 863 |
| — | — | RO | 820 |
| — | — | AP | 688 |
| — | — | RR | 622 |

`NI*` = "Não Informado" — beneficiários cuja UF de origem era nula, inválida (`XX`) ou ambígua
(`RIO`), conforme tratamento documentado no notebook de ETL. Terceiro maior volume, então vale
destacar como achado de qualidade de dados, não como uma UF real.

### 4. Beneficiários com mais de 20 atendimentos

Apenas **6 beneficiários** no conjunto tratado ultrapassam 20 atendimentos:

| id_beneficiario | qtd_atendimentos |
|---:|---:|
| 7837 | 22 |
| 565 | 22 |
| 9467 | 21 |
| 8681 | 21 |
| 2753 | 21 |
| 375 | 21 |

O sentinela `id_beneficiario = -1` ("Beneficiário Não Identificado") é excluído explicitamente
da consulta (`WHERE f.id_beneficiario <> -1`), já que ele concentra milhares de atendimentos
órfãos que não representam um beneficiário real — incluí-lo apareceria como um falso "outlier"
de milhares de atendimentos.
