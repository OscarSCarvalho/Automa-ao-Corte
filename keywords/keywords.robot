*** Settings ***
Resource   ../variables/variables.robot
Resource   ../pages/home_page.robot
Resource   ../pages/pickup_page.robot
Resource   ../pages/categories_page.robot
Resource   ../pages/catalog_page.robot
Resource   ../pages/detail_page.robot
Resource   ../pages/flow_page.robot
Library    SeleniumLibrary    timeout=${PAGE_TIMEOUT}    implicit_wait=${IMPLICIT_WAIT}

*** Keywords ***
# --- Browser ---
Abrir Browser
    Open Browser         ${BASE_URL}    ${BROWSER}
    Set Window Size      ${TOTEM_WIDTH}    ${TOTEM_HEIGHT}
    Set Window Position  100    50
    Set Selenium Speed   ${SELENIUM_SPEED}
    Wait Until Page Contains Element    tag:body

Fechar Browser
    Close All Browsers

Navegar Para
    [Arguments]    ${caminho}
    Go To    ${BASE_URL}${caminho}
    Wait Until Page Contains Element    tag:body

# --- Navigation Helpers ---
Ir Para Tela Pickup
    Go To    ${BASE_URL}
    Tocar Botao Iniciar

Clicar Aguardar No Balcao
    Wait Until Page Contains Element    ${BTN_BALCAO}    timeout=10
    Click Element    ${BTN_BALCAO}
    Wait Until Page Contains Element    ${FLOW_SCREEN}    timeout=10

Navegar Para Catalogo De Carnes
    Ir Para Tela Pickup
    Clicar Agendar Retirada
    Clicar Categoria Carnes

Navegar Para Detalhe De Produto
    [Arguments]    ${nome_produto}
    Navegar Para Catalogo De Carnes
    Clicar Produto No Catalogo    ${nome_produto}

Ir Para Tela Fluxo Balcao
    Ir Para Tela Pickup
    Clicar Aguardar No Balcao

# --- Home Page ---
Verificar Pagina Home Carregada
    Wait Until Element Is Visible    ${TOTEM_ROOT}    timeout=15
    Wait Until Element Is Visible    ${BRAND_NAME}

Verificar Nome Da Marca
    [Arguments]    ${nome_esperado}
    Element Should Contain    ${BRAND_NAME}    ${nome_esperado}

Verificar Titulo Do Browser
    [Arguments]    ${titulo_esperado}
    Title Should Be    ${titulo_esperado}

Verificar Relogio Visivel
    Page Should Contain Element    ${HOME_CLOCK}

Verificar Produto Em Destaque Visivel
    Page Should Contain Element    ${HOME_HERO_TITLE}
    Page Should Contain Element    ${HOME_HERO_PRICE}

Clicar Na Tela Principal
    Wait Until Element Is Visible    ${HOME_SCREEN}
    Click Element                    ${HOME_SCREEN}

Verificar Botao Toque Para Iniciar
    Page Should Contain Element    ${BTN_CTA}
    Page Should Contain            ${BTN_CTA_TEXT}

Tocar Botao Iniciar
    Wait Until Page Contains Element    ${BTN_CTA}    timeout=15
    Execute Javascript               document.querySelector('.home-cta-btn').scrollIntoView({block: 'center'})
    Click Element                    ${BTN_CTA}
    Execute Javascript               window.scrollTo(0, 0)
    Wait Until Page Contains Element    ${PICKUP_HEADING}    timeout=10

# --- Pickup Page ---
Verificar Tela Selecao Retirada
    Wait Until Page Contains Element    ${PICKUP_HEADING}    timeout=10
    Page Should Contain                 Como deseja retirar?

Verificar Opcoes De Retirada Visiveis
    Page Should Contain Element    ${BTN_AGENDAR}
    Page Should Contain Element    ${BTN_BALCAO}

Verificar Botao Voltar Na Tela Pickup
    Page Should Contain Element    ${BTN_VOLTAR}

Verificar Textos Cards De Retirada
    Element Should Contain    ${BTN_AGENDAR}    Agendar retirada
    Element Should Contain    ${BTN_BALCAO}     Aguardar no balcão

Clicar Agendar Retirada
    Wait Until Page Contains Element    ${BTN_AGENDAR}    timeout=10
    Execute Javascript                  document.querySelector('.pickup-card--scheduled').click()
    Wait Until Page Contains Element    ${CAT_GRID}    timeout=10

Voltar Para Home
    Execute Javascript               document.querySelector('.back-btn').click()
    Wait Until Page Contains Element    ${BTN_CTA}

Voltar Para Tela Pickup
    Execute Javascript    document.querySelector('.back-btn').click()
    Wait Until Page Contains Element    ${PICKUP_HEADING}    timeout=10

# --- Categories Page ---
Verificar Tela Categorias
    Wait Until Page Contains Element    ${CAT_HEADING}    timeout=10
    Page Should Contain                 O que você procura?

Verificar Todas Categorias Visiveis
    Page Should Contain    Carnes
    Page Should Contain    Frangos
    Page Should Contain    Suíno
    Page Should Contain    Linguiças
    Page Should Contain    Peixes e Frutos do Mar
    Page Should Contain    Frios

Clicar Categoria Carnes
    Wait Until Page Contains Element    ${CAT_CARNES}    timeout=10
    Execute Javascript                  Array.from(document.querySelectorAll('.cat-name')).find(el => el.textContent.trim() === 'Carnes').parentElement.click()
    Wait Until Page Contains Element    css:.product-card    timeout=10

Clicar Categoria
    [Arguments]    ${nome_categoria}
    Wait Until Page Contains Element    ${CAT_GRID}    timeout=10
    Execute Javascript
    ...    Array.from(document.querySelectorAll('.cat-name')).find(el => el.textContent.trim() === '${nome_categoria}').parentElement.click()
    Wait Until Page Contains Element    ${CATALOG_SCREEN}    timeout=10

Voltar Para Categorias
    Execute Javascript    document.querySelector('.back-btn').click()
    Wait Until Page Contains Element    ${CAT_GRID}    timeout=10

# --- Catalog Page ---
Verificar Catalogo Carregado
    Wait Until Page Contains Element    ${CATALOG_SCREEN}    timeout=15
    Wait Until Page Contains Element    ${PRODUCT_CARD}    timeout=10

Verificar Heading Do Catalogo
    [Arguments]    ${texto_esperado}
    Element Should Contain    ${CATALOG_HEADING}    ${texto_esperado}

Verificar Contagem De Produtos
    [Arguments]    ${qtd_esperada}
    ${texto}=    Get Text    ${CATALOG_COUNT}
    Should Contain    ${texto}    ${qtd_esperada}

Verificar Chip Ativo
    [Arguments]    ${nome_chip}
    Page Should Contain Element
    ...    xpath://div[contains(@class,'chip') and contains(@class,'on') and contains(.,'${nome_chip}')]

Clicar Chip
    [Arguments]    ${nome_chip}
    Execute Javascript
    ...    Array.from(document.querySelectorAll('.chip')).find(el => el.textContent.includes('${nome_chip}')).click()
    Sleep    0.8s

Verificar Produto No Catalogo
    [Arguments]    ${nome_produto}
    Page Should Contain Element
    ...    xpath://div[contains(@class,'product-card-name') and contains(.,'${nome_produto}')]

Clicar Produto No Catalogo
    [Arguments]    ${nome_produto}
    Execute Javascript
    ...    Array.from(document.querySelectorAll('.product-card-name')).find(el => el.textContent.includes('${nome_produto}')).closest('.product-card').click()
    Wait Until Page Contains Element    ${DETAIL_SCREEN}    timeout=10

Verificar Botoes Adicionar Nos Cards
    ${btns}=     Get WebElements    ${PRODUCT_CARD_ADD}
    ${cards}=    Get WebElements    ${PRODUCT_CARD}
    ${num_btns}=     Get Length    ${btns}
    ${num_cards}=    Get Length    ${cards}
    Should Be Equal As Numbers    ${num_btns}    ${num_cards}

Voltar Para Categorias Pelo Botao
    Execute Javascript    document.querySelector('.back-btn').click()
    Wait Until Page Contains Element    ${CAT_GRID}    timeout=10

# --- Detail Page ---
Verificar Detalhe Carregado
    Wait Until Page Contains Element    ${DETAIL_SCREEN}    timeout=15

Verificar Preco Por Kg
    [Arguments]    ${preco_esperado}
    Element Should Contain    ${DETAIL_PRICE}    ${preco_esperado}

Verificar Label Do Preco
    Element Should Contain    ${DETAIL_PRICE_LABEL}    Preço por kg

Verificar Quantidade Padrao
    ${qty}=    Get Text    ${DETAIL_QTY_VAL}
    Should Contain    ${qty}    1,5

Aumentar Quantidade
    ${btns}=    Get WebElements    ${DETAIL_QTY_BTN}
    Click Element    ${btns}[1]
    Sleep    0.5s

Diminuir Quantidade
    ${btns}=    Get WebElements    ${DETAIL_QTY_BTN}
    Click Element    ${btns}[0]
    Sleep    0.5s

Obter Quantidade Atual
    ${qty}=    Get Text    ${DETAIL_QTY_VAL}
    RETURN    ${qty}

Verificar Estimativa Visivel
    Element Should Contain    ${DETAIL_CHECKOUT}    Estimativa

Verificar Botao Adicionar Ao Pedido
    Page Should Contain Element    ${DETAIL_CTA}
    Element Should Contain    ${DETAIL_CTA}    Adicionar ao pedido

Voltar Para Catalogo Pelo Botao
    Execute Javascript    document.querySelector('.back-btn').click()
    Wait Until Page Contains Element    ${CATALOG_SCREEN}    timeout=10

# --- Flow Page (Balcão) ---
Verificar Tela Fluxo Balcao
    Wait Until Page Contains Element    ${FLOW_SCREEN}    timeout=10

Verificar Titulo Fluxo
    Page Should Contain    Como deseja continuar?

Verificar Dois Cards De Atendimento
    Page Should Contain Element    ${BTN_COUNTER}
    Page Should Contain Element    ${BTN_PREFERENTIAL}

Verificar Texto Cards De Atendimento
    Element Should Contain    ${BTN_COUNTER}        balcão
    Element Should Contain    ${BTN_PREFERENTIAL}   Preferencial

Clicar Escolher Corte No Balcao
    Click Element    ${BTN_COUNTER}
    Wait Until Page Contains Element    ${PRINT_MSG}    timeout=10

Clicar Atendimento Preferencial
    Click Element    ${BTN_PREFERENTIAL}
    Wait Until Page Contains Element    ${PRINT_MSG}    timeout=10

Verificar Tela De Impressao
    Page Should Contain Element    ${PRINT_MSG}

Voltar Para Pickup Do Fluxo
    Execute Javascript    document.querySelector('.back-btn').click()
    Wait Until Page Contains Element    ${PICKUP_HEADING}    timeout=10
