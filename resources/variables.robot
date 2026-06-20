*** Variables ***
# URL da aplicação
${BASE_URL}         http://localhost:3000

# URL externa para testes
${MERCADO_LIVRE_URL}       https://www.mercadolivre.com.br/
${CAMPO_PESQUISA}          id=cb1-edit
${INPUT_PESQUISA}          notebook

# Configurações do browser
${BROWSER}          chrome
${HEADLESS}         False
${IMPLICIT_WAIT}    10
${PAGE_TIMEOUT}     30


# Dados de teste
${USUARIO}          usuario_teste
${SENHA}            senha_teste
