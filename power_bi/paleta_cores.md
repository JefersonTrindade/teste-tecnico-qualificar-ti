# Paleta de Cores — Identidade Visual ANS / gov.br

Cores extraídas diretamente dos ativos oficiais do site https://www.gov.br/ans/pt-br (variáveis CSS do Design System gov.br e pixels do brasão exibido no cabeçalho), para uso nas visualizações do dashboard Power BI.

## Cores principais

| Uso sugerido | Cor | Hex | Origem |
|---|---|---|---|
| Primária | 🔵 Azul | `#1351B4` | Variável `--color-primary-default` do Design System gov.br |
| Primária (alternativa) | 🔵 Azul (logo) | `#2864AE` | Amostrado do brasão "gov.br" exibido no site |
| Destaque / institucional | 🟢 Verde | `#00A300` | `theme-color` da página da ANS |
| Destaque (alternativa) | 🟢 Verde (logo) | `#46AD44` | Amostrado do brasão "gov.br" |
| Alerta / atenção | 🟡 Amarelo | `#FABD10` | Amostrado do brasão "gov.br" |

## Cores de apoio (neutras e semânticas)

| Uso sugerido | Hex | Origem |
|---|---|---|
| Fundo claro | `#F8F8F8` | `--color-secondary-02` |
| Bordas/divisores | `#CCCCCC` | `--color-secondary-04` |
| Texto secundário | `#555555` | `--color-secondary-07` |
| Texto principal | `#333333` | `--color-secondary-08` |
| Sucesso/positivo | `#168821` | `--color-success` |
| Alerta | `#FFCD07` | `--color-warning` |
| Erro/negativo | `#E60000` | `--color-danger` |
| Informativo | `#155BCB` | `--color-info` |

## Recomendação de uso no dashboard
- 1 cor primária (azul `#1351B4`) para a maior parte dos elementos (barras, KPIs neutros).
- 1 cor de destaque (verde `#00A300`) para chamar atenção a métricas-chave ou variações positivas.
- Cores semânticas (`#168821` sucesso / `#E60000` erro) apenas para indicar variação positiva/negativa, não como paleta categórica geral.
- Neutros (`#F8F8F8`, `#CCCCCC`, `#333333`) para fundo, grades e texto — evitar cores saturadas competindo com os dados.
