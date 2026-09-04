# Modelagem Dimensional

**Ferramenta escolhida:** diagrama em [Mermaid](https://mermaid.js.org/syntax/entityRelationshipDiagram.html) (`erDiagram`), escrito direto em markdown — renderiza nativamente na visualização do GitHub, sem precisar de ferramenta externa (draw.io, dbdiagram.io etc.) nem de exportar imagem.

O diagrama fica em [`modelo_dimensional.md`](modelo_dimensional.md).

## Convenções a seguir ao preencher
- Prefixo `dim_` para tabelas de dimensão, `fato_` (ou `fact_`) para tabelas de fato.
- Indicar a granularidade da(s) tabela(s) fato no texto acima do diagrama.
- Relacionamentos com cardinalidade (`||--o{`, `}o--||` etc.) refletindo chave primária/estrangeira.
- Justificar no `README.md` principal (seção 4 e 5) as escolhas de modelagem (star vs. snowflake, SCD se houver, grão dos fatos).
