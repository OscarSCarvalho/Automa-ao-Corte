*** Settings ***
Documentation    Testes da tela de Catálogo de Produtos
Resource         ../keywords/keywords.robot
Suite Setup      Abrir Browser
Suite Teardown   Fechar Browser
Test Setup       Navegar Para Catalogo De Carnes

*** Test Cases ***
Verificar Titulo Nossos Cortes No Catalogo
    [Tags]    smoke    catalogo
    Verificar Heading Do Catalogo    Nossos Cortes

Verificar Contagem De Cinco Produtos Em Carnes
    [Tags]    smoke    catalogo
    Verificar Contagem De Produtos    5

Verificar Container De Chips De Filtro Visivel
    [Tags]    smoke    catalogo    filtros
    Page Should Contain Element    ${CHIPS}

Verificar Chip Bovino Ativo Ao Entrar Em Carnes
    [Tags]    catalogo    filtros
    Verificar Chip Ativo    Bovino

Verificar Produto Picanha Angus Listado
    [Tags]    smoke    catalogo
    Verificar Produto No Catalogo    Picanha Angus

Verificar Produto File Mignon Listado
    [Tags]    catalogo
    Verificar Produto No Catalogo    Filé Mignon

Verificar Produto Costela Bovina Listada
    [Tags]    catalogo
    Verificar Produto No Catalogo    Costela Bovina

Verificar Produto Contrafilee Listado
    [Tags]    catalogo
    Verificar Produto No Catalogo    Contrafilé

Verificar Produto Alcatra Listada
    [Tags]    catalogo
    Verificar Produto No Catalogo    Alcatra

Verificar Badges De Qualidade Nos Produtos
    [Tags]    catalogo
    Page Should Contain    Premium
    Page Should Contain    Nobre
    Page Should Contain    Popular

Verificar Botoes Adicionar Presentes Em Todos Os Cards
    [Tags]    catalogo
    Verificar Botoes Adicionar Nos Cards

Clicar Chip Todos E Verificar Ativacao
    [Tags]    catalogo    filtros
    Clicar Chip    Todos
    Verificar Chip Ativo    Todos

Clicar Produto Picanha E Verificar Tela Detalhe
    [Tags]    fluxo    catalogo    detalhe
    Clicar Produto No Catalogo    Picanha Angus
    Verificar Detalhe Carregado

Clicar Botao Voltar No Catalogo Retorna Categorias
    [Tags]    regressao    catalogo    navegacao
    Voltar Para Categorias Pelo Botao
    Page Should Contain Element    ${CAT_GRID}
