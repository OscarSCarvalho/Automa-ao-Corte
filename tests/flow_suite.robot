*** Settings ***
Documentation    Testes da tela de Fluxo - Atendimento no Balcão
Resource         ../keywords/keywords.robot
Suite Setup      Abrir Browser
Suite Teardown   Fechar Browser
Test Setup       Ir Para Tela Fluxo Balcao

*** Test Cases ***
Verificar Titulo Como Deseja Continuar
    [Tags]    smoke    balcao
    Verificar Titulo Fluxo

Verificar Dois Cards De Atendimento Visiveis
    [Tags]    smoke    balcao
    Verificar Dois Cards De Atendimento

Verificar Textos Dos Cards De Atendimento
    [Tags]    smoke    balcao
    Verificar Texto Cards De Atendimento

Clicar Escolher Corte No Balcao Exibe Tela De Impressao
    [Tags]    fluxo    balcao
    Clicar Escolher Corte No Balcao
    Verificar Tela De Impressao

Clicar Atendimento Preferencial Exibe Tela De Impressao
    [Tags]    fluxo    balcao
    Clicar Atendimento Preferencial
    Verificar Tela De Impressao

Clicar Botao Voltar No Fluxo Retorna Tela Pickup
    [Tags]    regressao    balcao    navegacao
    Voltar Para Pickup Do Fluxo
    Page Should Contain Element    ${PICKUP_HEADING}
