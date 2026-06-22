*** Variables ***
${BASE_URL}         https://corte.vercel.app/

${BROWSER}          chrome
${HEADLESS}         False
${IMPLICIT_WAIT}    10
${PAGE_TIMEOUT}     30
${SELENIUM_SPEED}   1.5s

# Dimensões do totem físico: 1080x1920 (portrait 9:16)
# Escala 67% para visualizar o botão "toque para iniciar"
${TOTEM_WIDTH}      720
${TOTEM_HEIGHT}     1280
