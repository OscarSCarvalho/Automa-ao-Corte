*** Settings ***
Documentation    Testes da tela de Seleção de Retirada (Pickup)
Resource         ../keywords/keywords.robot
Suite Setup      Abrir Browser
Suite Teardown   Fechar Browser
Test Setup       Ir Para Tela Pickup

*** Test Cases ***
Verificar Botao Voltar Presente Na Tela Pickup
    [Tags]    smoke    pickup    navegacao
    Verificar Botao Voltar Na Tela Pickup

Verificar Heading Como Deseja Retirar
    [Tags]    smoke    pickup
    Verificar Tela Selecao Retirada

Verificar Ambas Opcoes De Retirada Visiveis
    [Tags]    smoke    pickup
    Verificar Opcoes De Retirada Visiveis

Verificar Textos Dos Cards De Retirada
    [Tags]    smoke    pickup
    Verificar Textos Cards De Retirada

Clicar Botao Voltar Na Tela Pickup Retorna Home
    [Tags]    regressao    pickup    navegacao
    Voltar Para Home
    Page Should Contain Element    ${BTN_CTA}

Clicar Aguardar No Balcao Navega Para Tela De Fluxo
    [Tags]    fluxo    pickup    balcao
    Clicar Aguardar No Balcao
    Verificar Tela Fluxo Balcao
