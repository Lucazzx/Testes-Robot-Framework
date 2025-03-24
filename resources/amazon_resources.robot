*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    firefox
${URL}    https://www.amazon.com.br/
${MENU_ELETRONICOS}    (//a[contains(text(),'Eletrônicos')])[1]
${HEADER_ELETRONICOS}    (//span[contains(text(),'Eletrônicos e Tecnologia')])[1]
${PAINEL_GARANTIA}    //div[@id='attach-warranty-pane']
${BOTAO_NEGAR_GARANTIA}   //input[@aria-labelledby='attachSiNoCoverage-announce'] 
${CAMPO_PESQUISA}    //input[@id='twotabsearchtextbox']
${BOTAO_PESQUISAR}    //input[@id='nav-search-submit-button']
${BOTAO_ADICIONAR_CARRINHO}    //input[@id='add-to-cart-button']
${BOTAO_IR_CARRINHO}    //span[@id='sw-gtc']

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
    Wait Until Element Is Visible    locator=${CAMPO_PESQUISA}
    Input Text    locator=${CAMPO_PESQUISA}    text=${PRODUTO}

Clicar no botão de pesquisa
    Click Button    locator=${BOTAO_PESQUISAR}

Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Page Should Contain Element     locator=//h2[@aria-label='${PRODUTO}']

Adicionar o produto "${PRODUTO}" no carrinho
    Click Element    locator=//h2[@aria-label='${PRODUTO}']
    Wait Until Element Is Visible    locator=${BOTAO_ADICIONAR_CARRINHO}
    Click Button    locator=${BOTAO_ADICIONAR_CARRINHO}

Recusar garantia se oferecida
    ${PAINEL}=    Run Keyword And Return Status    Element Should Be Visible    locator=${PAINEL_GARANTIA}
    Run Keyword If    ${PAINEL}    Rolar Para Elemento E Clicar   locator=${BOTAO_NEGAR_GARANTIA}

Verificar se o produto foi adicionado com sucesso no carrinho
    Element Should Be Visible    locator=//h1[normalize-space()='Adicionado ao carrinho']

Ir para o carrinho
    #Wait Until Element Is Visible    locator=//span[@id='sw-gtc']
    Click Element    locator=${BOTAO_IR_CARRINHO}

Remover o produto "${PRODUTO}" do carrinho
    Wait Until Element Is Visible    locator=//button[@aria-label='Excluir ${PRODUTO}']
    Click Button    locator=//button[@aria-label='Excluir ${PRODUTO}']

Verificar se o carrinho fica vazio
    Wait Until Page Contains    text=Subtotal (0 produtos):

Rolar Para Elemento E Clicar
    [Arguments]    ${locator}
    Scroll Element Into View    ${locator}
    Sleep    1s 
    Click Element    ${locator}