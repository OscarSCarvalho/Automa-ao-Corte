*** Settings ***
Documentation       Testes de login da aplicação
Resource            ../resources/keywords.robot
Resource            ../pages/login_page.robot
Resource            ../pages/home_page.robot
Suite Setup         Abrir Browser
Suite Teardown      Fechar Browser
Test Setup          Navegar Para    /login

*** Test Cases ***
Login Com Credenciais Validas
    [Tags]    login    smoke
    Fazer Login    ${USUARIO}    ${SENHA}
    Verificar Pagina Home Carregada

Login Com Senha Incorreta
    [Tags]    login    negativo
    Fazer Login    ${USUARIO}    senha_errada
    Verificar Mensagem De Erro    Usuário ou senha inválidos

Login Com Usuario Em Branco
    [Tags]    login    negativo
    Fazer Login    ${EMPTY}    ${SENHA}
    Verificar Mensagem De Erro    Informe o usuário
