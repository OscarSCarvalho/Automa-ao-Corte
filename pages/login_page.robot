*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${INPUT_USUARIO}    id:username
${INPUT_SENHA}      id:password
${BTN_ENTRAR}       id:btn-login
${MSG_ERRO}         css:.error-message

*** Keywords ***
Preencher Login
    [Arguments]    ${usuario}    ${senha}
    Wait Until Element Is Visible    ${INPUT_USUARIO}
    Input Text    ${INPUT_USUARIO}    ${usuario}
    Input Text    ${INPUT_SENHA}      ${senha}

Submeter Login
    Click Element    ${BTN_ENTRAR}

Fazer Login
    [Arguments]    ${usuario}=${USUARIO}    ${senha}=${SENHA}
    Preencher Login    ${usuario}    ${senha}
    Submeter Login

Verificar Mensagem De Erro
    [Arguments]    ${mensagem_esperada}
    Wait Until Element Is Visible    ${MSG_ERRO}
    Element Should Contain    ${MSG_ERRO}    ${mensagem_esperada}
