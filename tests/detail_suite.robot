*** Settings ***
Documentation    Testes da tela de Detalhe do Produto
Resource         ../keywords/keywords.robot
Suite Setup      Abrir Browser
Suite Teardown   Fechar Browser
Test Setup       Navegar Para Detalhe De Produto    Picanha Angus

*** Test Cases ***
Verificar Nome Picanha Angus No Detalhe
    [Tags]    smoke    detalhe
    Page Should Contain    Picanha Angus

Verificar Preco Por Kg No Detalhe
    [Tags]    smoke    detalhe
    Verificar Preco Por Kg    R$89,90

Verificar Label Preco Por Kg
    [Tags]    smoke    detalhe
    Verificar Label Do Preco

Verificar Quantidade Inicial De Um Virgula Cinco Kg
    [Tags]    detalhe
    Verificar Quantidade Padrao

Verificar Estimativa De Valor Visivel No Checkout
    [Tags]    detalhe
    Verificar Estimativa Visivel

Verificar Dois Botoes De Controle De Quantidade
    [Tags]    detalhe
    ${btns}=    Get WebElements    ${DETAIL_QTY_BTN}
    Length Should Be    ${btns}    2

Aumentar Quantidade E Verificar Mudanca De Valor
    [Tags]    detalhe
    ${antes}=    Obter Quantidade Atual
    Aumentar Quantidade
    ${depois}=    Obter Quantidade Atual
    Should Not Be Equal    ${antes}    ${depois}

Diminuir Quantidade Apos Aumento E Verificar Reducao
    [Tags]    detalhe
    Aumentar Quantidade
    ${apos_aumento}=    Obter Quantidade Atual
    Diminuir Quantidade
    ${apos_diminuicao}=    Obter Quantidade Atual
    Should Not Be Equal    ${apos_aumento}    ${apos_diminuicao}

Verificar Botao Adicionar Ao Pedido Visivel E Com Texto Correto
    [Tags]    smoke    detalhe
    Verificar Botao Adicionar Ao Pedido

Clicar Botao Voltar No Detalhe Retorna Catalogo
    [Tags]    regressao    detalhe    navegacao
    Voltar Para Catalogo Pelo Botao
    Page Should Contain Element    ${CATALOG_SCREEN}
