*** Settings ***
Documentation    Teste inicial: abrir Mercado Livre Brasil
Resource         ../resources/keywords.robot
Suite Setup      Abrir Mercado Livre
Suite Teardown   Fechar Browser

*** Test Cases ***
Abrir Mercado Livre Brasil
    [Tags]    smoke
    Verificar Titulo Contem   Mercado Livre Brasil - Frete Grátis no mesmo dia
    Clicar campo pesquisa e pesquisar
