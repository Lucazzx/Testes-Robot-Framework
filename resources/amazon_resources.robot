*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    firefox
${URL}    https://www.amazon.com.br/
${MENU_ELETRONICOS}    (//a[contains(text(),'Eletrônicos')])[1]
${HEADER_ELETRONICOS}    (//span[contains(text(),'Eletrônicos e Tecnologia')])[1]

*** Keywords ***
Abrir o Navegador
    IF    '${BROWSER}' == 'chrome'
        Open Browser    browser=${BROWSER}    options=add_experimental_option("detach", True)
    ELSE
        Open Browser    browser=${BROWSER}
    END
    Maximize Browser Window

Fechar o Navegador
    Capture Page Screenshot
    Close Browser

Acessar a home page do site Amazon.com.br
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=${MENU_ELETRONICOS}

Entrar no menu "Eletrônicos"
    Click Element    locator=${MENU_ELETRONICOS}

Verificar se aparece a frase "${FRASE}"
    Wait Until Page Contains    text=${FRASE}
    Wait Until Element Is Visible    locator=${HEADER_ELETRONICOS}

Verificar se o título da página fica "${TITULO}"
    Title Should Be    title=${TITULO}

Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should Be Visible    locator=//span[@class='nav-a-content'][normalize-space()='${NOME_CATEGORIA}']

Digitar o nome do produto "${PRODUTO}" no campo de pesquisa
    Input Text    locator=//input[@id='twotabsearchtextbox']    text=${PRODUTO}

Clicar no botão de pesquisa
    Click Button    locator=//input[@id='nav-search-submit-button']

Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Page Should Contain Element     locator=//span[contains(text(), '${PRODUTO}')]

Adicionar o produto "${PRODUTO}" no carrinho