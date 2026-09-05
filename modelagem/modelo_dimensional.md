# Diagrama do Modelo Dimensional

Esquema em **estrela**, com a dimensão de operadora desnormalizada diretamente na fato (ver
justificativa abaixo).

Granularidade da tabela fato: **1 linha por atendimento** (`id_atendimento`).

```mermaid
erDiagram
    FATO_ATENDIMENTO {
        int id_atendimento PK
        int id_beneficiario FK
        int id_operadora FK
        int id_especialidade FK
        date data FK
        float valor
    }
    DIM_BENEFICIARIO {
        int id_beneficiario PK
        string sexo
        float idade
        string faixa_etaria
        string uf
        int id_operadora FK
    }
    DIM_OPERADORA {
        int id_operadora PK
        string operadora
    }
    DIM_ESPECIALIDADE {
        int id_especialidade PK
        string especialidade
    }
    DIM_TEMPO {
        date data PK
        int ano
        int trimestre
        int mes
        string nome_mes
        int dia
        string dia_semana
    }

    DIM_BENEFICIARIO ||--o{ FATO_ATENDIMENTO : realiza
    DIM_OPERADORA ||--o{ FATO_ATENDIMENTO : cobre
    DIM_OPERADORA ||--o{ DIM_BENEFICIARIO : contrata
    DIM_ESPECIALIDADE ||--o{ FATO_ATENDIMENTO : classifica
    DIM_TEMPO ||--o{ FATO_ATENDIMENTO : ocorre_em
```

## Decisões de modelagem

- **Grão da fato:** um atendimento individual — permite qualquer agregação pedida (por
  especialidade, operadora, UF, mês, beneficiário) sem perda de detalhe.
- **`id_operadora` desnormalizado na fato:** no dado de origem, a operadora é um atributo do
  *beneficiário* (`Beneficiarios.csv`), não do atendimento. Um star schema puro ligaria
  `fato_atendimento → dim_beneficiario → dim_operadora` (snowflake). Optei por copiar
  `id_operadora` para dentro da fato durante o ETL para que "Gastos por operadora" (indicador
  pedido no dashboard) seja um filtro/agrupamento direto na fato, sem *forçar* o Power BI a
  atravessar a dimensão de beneficiário — mais simples de modelar e mais performático, ao custo
  de uma pequena redundância (o `id_operadora` também permanece em `dim_beneficiario`, para
  quem quiser navegar beneficiário → operadora).
- **`dim_tempo`:** contém apenas as datas efetivamente presentes em `fato_atendimento` (dimensão
  "enxuta", não um calendário completo desde 1900) — atende ao filtro de período e à visualização
  de evolução mensal pedidos no dashboard.
- **Registros sentinela (`-1`)** em `dim_beneficiario` e `dim_operadora` absorvem as FKs
  inválidas/órfãs encontradas no tratamento (ver notebook), preservando a integridade
  referencial sem descartar o valor financeiro dos atendimentos correspondentes.
- **`faixa_etaria`** foi adicionada a `dim_beneficiario` como atributo derivado, para permitir
  segmentação etária no dashboard mesmo com ~5% de idades ausentes/inválidas (agrupadas em
  "Não Informada").
