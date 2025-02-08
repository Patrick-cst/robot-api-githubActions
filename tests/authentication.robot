*** Settings ***
Resource    ../config/settings.resource
Resource    ../resources/keywords/authentication_keywords.resource

Suite Setup    Start session

*** Test Cases ***
Login com Sucesso
    [Documentation]    Teste de login bem-sucedido na API
    Dado que eu envio credenciais válidas
    Então eu devo receber um token de autenticação

Login com Falha
    [Documentation]    Teste de login com credenciais inválidas
    Dado que eu envio credenciais inválidas
    Então eu devo receber uma mensagem de erro    Missing password