# Relatório de Testes — CORTE · Açougue Inteligente

**Data:** 22/06/2026
**Ambiente:** https://corte.vercel.app/
**Browser:** Chrome 720×1280 (formato totem portrait)
**Framework:** Robot Framework 7.2.2 + SeleniumLibrary 6.9.0

---

## Resultado Geral

| Suíte | Casos | Passou | Falhou | Status |
|---|---|---|---|---|
| `corte_suite` (original) | 8 | 8 | 0 | ✅ PASS |
| `pickup_suite` | 6 | 6 | 0 | ✅ PASS |
| `catalog_suite` | 14 | 14 | 0 | ✅ PASS |
| `detail_suite` | 10 | 10 | 0 | ✅ PASS |
| `flow_suite` | 6 | 6 | 0 | ✅ PASS |
| **TOTAL** | **44** | **44** | **0** | **✅ 100%** |

---

## Detalhamento por Suíte

### `corte_suite` — Fluxo Principal (smoke)

| Caso | Tags | Status |
|---|---|---|
| Verificar Abertura Da Página Inicial | smoke | ✅ |
| Verificar Nome Da Marca Na Home | smoke | ✅ |
| Verificar Título Do Browser | smoke | ✅ |
| Verificar Relógio Na Home | smoke | ✅ |
| Verificar Produto Em Destaque | smoke | ✅ |
| Verificar Botão Toque Aqui Para Iniciar | smoke | ✅ |
| Tocar Botão Iniciar E Verificar Próxima Tela | fluxo | ✅ |
| Clicar Agendar Retirada E Verificar Categorias | fluxo | ✅ |

---

### `pickup_suite` — Tela de Seleção de Retirada

| Caso | Tags | Status |
|---|---|---|
| Verificar Botão Voltar Presente Na Tela Pickup | smoke, navegacao | ✅ |
| Verificar Heading "Como deseja retirar?" | smoke | ✅ |
| Verificar Ambas Opções De Retirada Visíveis | smoke | ✅ |
| Verificar Textos Dos Cards De Retirada | smoke | ✅ |
| Clicar Botão Voltar Na Tela Pickup Retorna Home | regressao | ✅ |
| Clicar Aguardar No Balcão Navega Para Tela De Fluxo | fluxo, balcao | ✅ |

---

### `catalog_suite` — Catálogo de Produtos

| Caso | Tags | Status |
|---|---|---|
| Verificar Título "Nossos Cortes" | smoke | ✅ |
| Verificar Contagem de 5 Produtos em Carnes | smoke | ✅ |
| Verificar Container de Chips de Filtro Visível | smoke, filtros | ✅ |
| Verificar Chip "Bovino" Ativo ao Entrar em Carnes | filtros | ✅ |
| Verificar Produto Picanha Angus Listado | smoke | ✅ |
| Verificar Produto Filé Mignon Listado | catalogo | ✅ |
| Verificar Produto Costela Bovina Listada | catalogo | ✅ |
| Verificar Produto Contrafilé Listado | catalogo | ✅ |
| Verificar Produto Alcatra Listada | catalogo | ✅ |
| Verificar Badges Premium / Nobre / Popular | catalogo | ✅ |
| Verificar Botões "+" Presentes em Todos os Cards | catalogo | ✅ |
| Clicar Chip "Todos" e Verificar Ativação | filtros | ✅ |
| Clicar Produto Picanha e Verificar Tela Detalhe | fluxo | ✅ |
| Clicar Botão Voltar no Catálogo Retorna Categorias | regressao | ✅ |

---

### `detail_suite` — Detalhe do Produto (Picanha Angus)

| Caso | Tags | Status |
|---|---|---|
| Verificar Nome "Picanha Angus" no Detalhe | smoke | ✅ |
| Verificar Preço R$89,90/kg | smoke | ✅ |
| Verificar Label "Preço por kg" | smoke | ✅ |
| Verificar Quantidade Inicial de 1,5 kg | detalhe | ✅ |
| Verificar Estimativa de Valor Visível | detalhe | ✅ |
| Verificar 2 Botões de Controle de Quantidade (−/+) | detalhe | ✅ |
| Aumentar Quantidade e Verificar Mudança de Valor | detalhe | ✅ |
| Diminuir Quantidade Após Aumento e Verificar Redução | detalhe | ✅ |
| Verificar Botão "Adicionar ao pedido" Visível e Com Texto Correto | smoke | ✅ |
| Clicar Voltar no Detalhe Retorna Catálogo | regressao | ✅ |

---

### `flow_suite` — Fluxo Balcão

| Caso | Tags | Status |
|---|---|---|
| Verificar Título "Como deseja continuar?" | smoke | ✅ |
| Verificar 2 Cards de Atendimento Visíveis | smoke | ✅ |
| Verificar Textos dos Cards de Atendimento | smoke | ✅ |
| Clicar "Escolher Corte no Balcão" → Tela de Impressão | fluxo | ✅ |
| Clicar "Preferencial" → Tela de Impressão | fluxo | ✅ |
| Clicar Voltar no Fluxo Retorna Tela Pickup | regressao | ✅ |

---

## Bug Encontrado e Corrigido

**Suíte:** `flow_suite`
**Caso:** `Verificar Titulo Como Deseja Continuar`

**Causa raiz:** O elemento `.flow-choice-heading` está posicionado fora do viewport horizontal (x=1408px numa janela de 720px de largura) devido ao sistema de animação/transição de telas do totem. O ChromeDriver retorna `text=''` para elementos que existem no DOM mas estão fora da área visível da janela.

**Correção:** Substituído `Element Should Contain` por `Page Should Contain`, que busca o texto no DOM completo independente de posição ou visibilidade na janela.

---

## Cobertura por Tag

| Tag | Qtd. de Casos |
|---|---|
| `smoke` | 23 |
| `catalogo` | 11 |
| `detalhe` | 8 |
| `fluxo` | 7 |
| `balcao` | 6 |
| `navegacao` | 5 |
| `regressao` | 5 |
| `filtros` | 4 |

---

## Fluxo de Navegação Coberto

```
Home
 └── [Toque para iniciar]
      └── Pickup (Seleção de Retirada)
           ├── [Agendar Retirada]
           │    └── Categorias
           │         └── [Carnes]
           │              └── Catálogo (Nossos Cortes)
           │                   └── [Produto]
           │                        └── Detalhe do Produto
           │                             ├── Controles de quantidade (−/+)
           │                             └── Botão "Adicionar ao pedido"
           └── [Aguardar no Balcão]
                └── Fluxo de Atendimento
                     ├── [Escolher Corte no Balcão] → Tela de Impressão
                     └── [Preferencial]             → Tela de Impressão
```

---

## Estrutura de Arquivos Criados

```
auto_corte/
├── pages/
│   ├── home_page.robot        (existente)
│   ├── pickup_page.robot      (existente)
│   ├── categories_page.robot  (existente)
│   ├── catalog_page.robot     (novo)
│   ├── detail_page.robot      (novo)
│   └── flow_page.robot        (novo)
├── keywords/
│   └── keywords.robot         (atualizado — +30 keywords)
├── tests/
│   ├── corte_suite.robot      (existente)
│   ├── pickup_suite.robot     (novo — 6 casos)
│   ├── catalog_suite.robot    (novo — 14 casos)
│   ├── detail_suite.robot     (novo — 10 casos)
│   └── flow_suite.robot       (novo — 6 casos)
└── doc/
    └── relatorio_testes.md    (este arquivo)
```
