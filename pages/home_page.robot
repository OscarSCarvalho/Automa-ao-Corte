*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${MENU_NAV}         css:nav
${TITULO_PAGINA}    css:h1
${BTN_SAIR}         id:btn-logout

*** Keywords ***
Verificar Pagina Home Carregada
    Wait Until Element Is Visible    ${MENU_NAV}
    Page Should Contain Element      ${TITULO_PAGINA}

Verificar Titulo
    [Arguments]    ${titulo_esperado}
    Element Should Contain    ${TITULO_PAGINA}    ${titulo_esperado}

Sair Da Aplicacao
    Click Element    ${BTN_SAIR}
