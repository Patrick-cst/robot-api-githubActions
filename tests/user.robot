*** Settings ***

Resource    ../resources/keywords/users_keywords.resource

Suite Setup    Start session

*** Test Cases ***
Listar todos os usuários paginados
    [Documentation]    Listar todos os usuários paginados
    [Tags]    e2e
    Dado que realize uma pesquisa de usuarios
    Então é apresentada a lista de usuarios


Buscar um usuário específico existente
    [Documentation]    Buscar um usuário específico existente
    [Tags]    e2e
    Dado que pesquise por um usuario específico     1
    Então é apresentado as informações do usuario pesquisado

Criar usuário com dados válidos
    [Documentation]    Criar usuário com dados válidos
    [Tags]    e2e
    Dado que um novo usuario seja cadastrado
    Então validar usuario cadastrado com sucesso


Atualizar usuário existente com novos dados
    [Documentation]    Atualizar usuário existente com novos dados
    [Tags]    e2e
    Dado que atualize os dados do usuario    2
    Então validar dados do usuario atualizados


Excluir usuário existente
    [Documentation]    Excluir usuário existente
    [Tags]    e2e
    Dado que exclua um usuario                1
    Então validar usuario excluido
