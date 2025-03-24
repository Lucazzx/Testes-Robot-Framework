*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/amazon_resources.robot

*** Keywords ***
Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br

Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"

Então o título da página deve ficar "${TITULO}"
    Verificar se o título da página fica "${TITULO}"

E o texto "${FRASE}" deve ser exibido na página
        Verificar se aparece a frase "${FRASE}"

E a categoria "${NOME_CATEGORIA}" deve ser exibida na página
    Verificar se aparece a categoria "${NOME_CATEGORIA}"

Quando pesquisar pelo produto "${PRODUTO}"
    Digitar o nome do produto "${PRODUTO}" no campo de pesquisa
    Clicar no botão de pesquisa

E um produto da linha "${PRODUTO}" deve ser mostrado na página
    Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"

Quando adicionar o produto "${PRODUTO}" no carrinho
    Digitar o nome do produto "${PRODUTO}" no campo de pesquisa
    Clicar no botão de pesquisa
    Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Adicionar o produto "${PRODUTO}" no carrinho
    Recusar garantia se oferecida

Então o produto "${PRODUTO}" deve ser mostrado no carrinho
        Verificar se o produto foi adicionado com sucesso no carrinho

E existe o produto "${PRODUTO}" no carrinho
    Digitar o nome do produto "${PRODUTO}" no campo de pesquisa
    Clicar no botão de pesquisa
    Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Adicionar o produto "${PRODUTO}" no carrinho
    Recusar garantia se oferecida
    Verificar se o produto foi adicionado com sucesso no carrinho
    Ir para o carrinho

Quando remover o produto "${PRODUTO}" do carrinho
    Ir para o carrinho
    Remover o produto "${PRODUTO}" do carrinho

Então o carrinho deve ficar vazio
    Verificar se o carrinho fica vazio