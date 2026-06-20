*** Settings ***
Library    SeleniumLibrary    timeout=30    implicit_wait=10
Library    OperatingSystem
Resource   variables.robot

*** Keywords ***
Abrir Browser
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window

Fechar Browser
    Close Browser

Navegar Para
    [Arguments]    ${caminho}
    Go To    ${BASE_URL}${caminho}

Abrir Mercado Livre
    Open Browser    ${MERCADO_LIVRE_URL}    ${BROWSER}
    Maximize Browser Window

Verificar Titulo Contem
    [Arguments]    ${texto}
    ${titulo}=    Get Title
    Should Contain    ${titulo}    ${texto}

Clicar campo pesquisa e pesquisar
    Wait Until Element Is Visible    ${CAMPO_PESQUISA}
    Click Element    ${CAMPO_PESQUISA}
    Input Text       ${CAMPO_PESQUISA}    ${INPUT_PESQUISA}
    sleep    3
