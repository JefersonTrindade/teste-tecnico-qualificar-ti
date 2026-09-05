# Teste Técnico — Analista de BI Pleno

## 1. Visão geral

Cenário de análise de utilização de planos de saúde. A partir de três arquivos brutos
(`Beneficiarios.csv`, `Atendimentos.csv`, `Operadoras.csv`), contendo inconsistências
intencionais, o projeto:

1. Diagnostica e trata os problemas de qualidade de dados (notebook Python).
2. Modela um esquema dimensional em estrela para análise de atendimentos.
3. Carrega os dados tratados em SQLite e responde 4 perguntas de negócio em SQL.
4. Apresenta os principais indicadores em um dashboard Power BI.

## 2. Ferramentas e tecnologias

- **Python** (pandas, numpy) — leitura, diagnóstico, tratamento e exportação dos dados (ETL).
- **Jupyter Notebook** — documentação executável do processo de tratamento.
- **SQLite** — carga do modelo dimensional e consultas analíticas em SQL padrão ANSI.
- **Power BI (formato .pbip)** — dashboard final, versionado como texto/TMDL.
- **Mermaid** — diagrama do modelo dimensional (renderiza nativamente no GitHub).
- **Git** — versionamento com commits incrementais por etapa.

## 3. Estrutura do repositório

```
.
├── dados/
│   ├── brutos/          # planilhas originais recebidas (Beneficiarios, Atendimentos, Operadoras)
│   └── tratados/         # saída do ETL: dim_*.csv e fato_atendimento.csv
├── notebooks/
│   └── tratamento_dados.ipynb   # diagnóstico + tratamento + exportação (ETL)
├── sql/                  # scripts SQL (SQLite): DDL, carga e consultas de validação
├── modelagem/            # diagrama do modelo dimensional (Mermaid) e convenções
├── power_bi/             # dashboard Power BI (.pbip) e diretrizes visuais
└── README.md
```

A estrutura sugerida no enunciado (`dados/`, `notebooks/`, `scripts/`, `sql/`, `dashboard/`,
`README.md`, `.gitignore`) foi adaptada em dois pontos: `power_bi/` no lugar de `dashboard/`
(nome mais específico à ferramenta usada) e sem uma pasta `scripts/` separada, já que todo o
código de tratamento está centralizado no notebook (não há scripts `.py` avulsos).

## 4. Como executar

1. Abrir o Jupyter Lab (`jupyter lab` em um ambiente com pandas/numpy) e
   rodar `notebooks/tratamento_dados.ipynb` de ponta a ponta — gera os arquivos tratados em
   `dados/tratados/`.
2. Criar um banco SQLite e rodar, em ordem, os scripts de `sql/`:
   `01_ddl_dimensoes.sql` → `02_ddl_fatos.sql` → `03_carga.sql` → `04_consultas_validacao.sql`.
   (Validado com o CLI `sqlite3`; qualquer cliente que suporte `.import` de CSV serve.)
3. Abrir `power_bi/*.pbip` no Power BI Desktop — os dados são importados diretamente de
   `dados/tratados/`.

## 5. Modelo dimensional

Esquema em estrela, grão da fato = 1 atendimento. Diagrama completo e justificativa das
decisões (desnormalização de `id_operadora` na fato, dimensão tempo enxuta, registros
sentinela para FKs órfãs) em [`modelagem/modelo_dimensional.md`](modelagem/modelo_dimensional.md).

## 6. Principais decisões e premissas adotadas

- **Diagnóstico antes do tratamento:** cada regra de limpeza aplicada no notebook é precedida
  de uma célula de diagnóstico que quantifica o problema — nenhuma decisão foi tomada "no
  escuro".
- **Não imputar valores ausentes/inválidos** (idade, valor de atendimento): optei por manter
  como "Não Informado"/excluir da métrica em vez de preencher com média/mediana, para não
  introduzir viés artificial nos indicadores do dashboard.
- **Reconciliação de `id_operadora` via nome:** o campo `operadora` carrega um código numérico
  embutido no final do nome (ex. `"Ideal Saúde 112"` → id `112`), que permitiu recuperar
  registros com `id_operadora` corrompido (`ABC`, negativos) em vez de descartá-los.
- **Registros sentinela (`id = -1`)** em `dim_beneficiario` e `dim_operadora` absorvem chaves
  estrangeiras inválidas ou órfãs, preservando o valor financeiro dos atendimentos nas métricas
  agregadas sem forçar integridade artificial.
- **Linhas descartadas da fato** apenas quando a medida central (`valor`) ou a dimensão tempo
  (`data_atendimento`) são irrecuperáveis — um atendimento sem valor ou sem data confiável não
  contribui para nenhum dos indicadores pedidos.
- **`.pbip` em vez de `.pbix`:** permite versionar o dashboard como texto (TMDL/JSON) no Git,
  atendendo ao requisito de rastreabilidade do histórico de desenvolvimento.
- **Conversão de tipo com localidade explícita no Power Query:** a detecção automática de tipo
  do Power BI interpretou o `.` decimal de `valor` (`fato_atendimento`) e `idade`
  (`dim_beneficiario`) como separador de milhar, inflando ambos os campos em ~100x. Corrigido
  fixando a conversão para número decimal com localidade `en-US` diretamente a partir do texto
  de origem — nunca convertendo para inteiro antes.

## 7. Observações relevantes sobre o tratamento dos dados

Resumo dos principais achados (detalhamento completo, com contagens exatas, no notebook):

- **Beneficiarios.csv:** 112 linhas 100% duplicadas; 200 `id_beneficiario` duplicados; `sexo`
  com grafias inconsistentes e nulos; `idade` com valores não numéricos (`"dez"`), negativos ou
  acima de 110 anos; `uf` com nome por extenso (`MINAS GERAIS`) ou inválida (`XX`, `RIO`);
  `id_operadora` nulo, negativo ou não numérico.
- **Atendimentos.csv:** ~1.800 linhas essencialmente vazias (sem beneficiário, data nem
  especialidade); ~967 linhas 100% duplicadas; 1.800 `id_atendimento` duplicados; `valor` com
  formatos monetários BR (`"R$ 250,00"`), lixo (`"erro"`, `"1.2.3"`) e negativos; datas fora do
  intervalo plausível (`1900` a `2032`) ou não parseáveis; `especialidade` com variações de
  caixa, espaçamento **e acentuação** (`"Clinica Medica"` vs. `"Clínica Médica"`).
  Adicionalmente, ~602 `id_beneficiario` não numéricos e ~3.100 numéricos porém órfãos
  (problema de integridade referencial entre arquivos, não apenas de formatação).
- **Operadoras.csv:** `id_operadora` não numérico, negativo ou nulo em poucos registros —
  majoritariamente reconciliável via código embutido no nome; 11 registros com nome nulo mas id
  válido; 35 `id_operadora` duplicados.
- **Integridade entre arquivos:** além dos casos acima, alguns `id_operadora` em
  `Beneficiarios.csv` são numéricos e positivos mas não existem em `Operadoras.csv` — tratado
  como órfão real de integridade (não redutível a um problema de formatação) e direcionado ao
  sentinela.
- **Concentração no sentinela "Não Identificada" (dashboard):** no visual "Gastos por
  operadora", o bucket `id_operadora = -1` aparece com valor bem maior que qualquer operadora
  legítima isolada. Isso não é uma operadora real — é a soma de duas fontes de erro distintas
  caindo na mesma chave: (1) atendimentos cujo `id_beneficiario` era inválido/órfão no arquivo de
  origem (~3.700 registros, redirecionados ao beneficiário sentinela, que por definição tem
  `id_operadora = -1`) e (2) atendimentos de beneficiários válidos cujo `id_operadora` de origem
  era inválido ou não existia em `Operadoras.csv`. Optei por preservar esses valores nas métricas
  agregadas (em vez de descartar) porque afetam o total financeiro real, ao custo de misturar as
  duas causas quando o dado é quebrado por operadora.

## 8. Itens não implementados / abordagem proposta

- **Cards em SVG/HTML:** a diretriz inicial (`power_bi/README.md`) previa cards/ícones em
  SVG/HTML em vez de visuais nativos. Por restrição de tempo, os 4 cards de KPI foram
  implementados como visual **Cartão** nativo, formatado (cor, fundo, borda) em vez de SVG —
  abordagem mais rápida e ainda alinhada à paleta de cores definida. Os gráficos seguiram a
  diretriz original (sempre nativos).
- **Tabelas de calendário automáticas do Power BI:** a opção "Data/Hora automática" do Power BI
  Desktop recria tabelas de calendário ocultas (`LocalDateTable_*`, `DateTableTemplate_*`)
  redundantes com `dim_tempo` sempre que o arquivo é reaberto. Foram removidas manualmente uma
  vez, mas voltaram ao reabrir o Desktop. Não afetam a funcionalidade (ficam ocultas e os
  relacionamentos corretos com `dim_tempo` continuam ativos), mas o ideal seria desabilitar essa
  opção em Arquivo → Opções e Configurações → Opções → Carregamento de Dados (Arquivo Atual)
  antes de reabrir o projeto.
- **Tema de cores customizado do relatório:** as cores da identidade ANS
  (`power_bi/paleta_cores.md`) foram aplicadas diretamente em cada visual (cards e gráficos), em
  vez de um arquivo de tema (`.json`) registrado em `StaticResources/RegisteredResources/` — mais
  rápido de implementar com segurança dentro do prazo, ao custo de precisar repetir a cor em cada
  visual em vez de centralizá-la.

## 9. Entregáveis

- [x] Notebook Python (diagnóstico + tratamento + exportação)
- [x] Código-fonte da solução
- [x] Arquivos resultantes do ETL (`dados/tratados/`)
- [x] Diagrama do modelo dimensional
- [x] Scripts SQL
- [x] Arquivo/dashboard do Power BI
- [x] README.md
- [x] Repositório Git com histórico de desenvolvimento
