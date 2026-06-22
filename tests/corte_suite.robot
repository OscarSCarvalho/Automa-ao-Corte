*** Settings ***
Documentation    Suite de testes - Aplicação CORTE · Açougue Inteligente
Resource         ../keywords/keywords.robot
Suite Setup      Abrir Browser
Suite Teardown   Fechar Browser
Test Setup       Go To    ${BASE_URL}

*** Test Cases ***
Verificar Abertura Da Pagina Inicial
    [Tags]    smoke
    Verificar Pagina Home Carregada

Verificar Nome Da Marca Na Home
    [Tags]    smoke
    Verificar Nome Da Marca    CORTE

Verificar Titulo Do Browser
    [Tags]    smoke
    Verificar Titulo Do Browser    CORTE · Açougue Inteligente

Verificar Relogio Na Home
    [Tags]    smoke
    Verificar Relogio Visivel

Verificar Produto Em Destaque
    [Tags]    smoke
    Verificar Produto Em Destaque Visivel

Verificar Botao Toque Aqui Para Iniciar
    [Tags]    smoke    botao-cta
    Verificar Botao Toque Para Iniciar

Tocar Botao Iniciar E Verificar Proxima Tela
    [Tags]    fluxo    botao-cta
    Tocar Botao Iniciar
    Verificar Tela Selecao Retirada
    Verificar Opcoes De Retirada Visiveis

Clicar Agendar Retirada E Verificar Categorias
    [Tags]    fluxo    categorias
    Tocar Botao Iniciar
    Clicar Agendar Retirada
    Verificar Tela Categorias
    Verificar Todas Categorias Visiveis
    Clicar Categoria Carnes
    Page Should Contain    Nossos Cortes
