*** Settings ***
Resource   ../variables/variables.robot
Resource   ../pages/home_page.robot
Resource   ../pages/pickup_page.robot
Resource   ../pages/categories_page.robot
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

Clicar Agendar Retirada
    Wait Until Page Contains Element    ${BTN_AGENDAR}    timeout=10
    Execute Javascript                  document.querySelector('.pickup-card--scheduled').click()
    Wait Until Page Contains Element    ${CAT_GRID}    timeout=10

Voltar Para Home
    Execute Javascript               document.querySelector('.back-btn').click()
    Wait Until Page Contains Element    ${BTN_CTA}

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
