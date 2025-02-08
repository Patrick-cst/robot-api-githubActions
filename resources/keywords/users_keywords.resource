*** Settings ***

Resource    ../../config/settings.resource
Resource    ../paths/user_path.resource

Library    RequestsLibrary
Library    Collections
Library    OperatingSystem

*** Keywords ***
Dado que realize uma pesquisa de usuarios
    [Documentation]    Realizar uma pesquisa de usuarios
    
    &{page}    Create Dictionary    page=1

    Headers    
    ${response}    GET    url=${BASE_URL}${EP_LIST_USERS}
    ...                   params=&{page}
    ...                   headers=${HEADERS}
    ...                   expected_status=any
    
    Set Test Variable    ${response}
    

Então é apresentada a lista de usuarios
    [Documentation]    É apresentada a lista de usuarios
   
    Should Be Equal As Strings           ${response.status_code}            200
    Should Be Equal As Numbers           ${response.json()['page']}         1
    Dictionary Should Contain Key        ${response.json()}                 per_page
    Dictionary Should Contain Key        ${response.json()}                 total
    Dictionary Should Contain Key        ${response.json()}                 total_pages

    ${listaDeUsuarios}=    Get From Dictionary      ${response.json()}      data

    FOR   ${perfilUsuario}    IN    @{listaDeUsuarios} 

        Dictionary Should Contain Key    ${perfilUsuario}                    id    
        Dictionary Should Contain Key    ${perfilUsuario}                    email
        Dictionary Should Contain Key    ${perfilUsuario}                    first_name
        Dictionary Should Contain Key    ${perfilUsuario}                    last_name
        Dictionary Should Contain Key    ${perfilUsuario}                    avatar
    
        Should Be True                   ${perfilUsuario}[id] > 0
        Should Not Be Empty              ${perfilUsuario}[email]  
        Should Not Be Empty              ${perfilUsuario}[first_name]
        Should Not Be Empty              ${perfilUsuario}[last_name]
        Should Not Be Empty              ${perfilUsuario}[avatar]                  
    END       

    Dictionary Should Contain Key        ${response.json()}                  support
    Dictionary Should Contain Key        ${response.json()['support']}       url 
    Should Not Be Empty                  ${response.json()['support']['url']}
    
    
    Dictionary Should Contain Key        ${response.json()['support']}       text    
    Should Be Equal As Strings           ${response.json()['support']['text']}  Tired of writing endless social media content? Let Content Caddy generate it for you.


Dado que pesquise por um usuario específico
    [Documentation]    Pesquisar por um usuario específico
    [Arguments]                          ${user}

    ${params}    Create Dictionary    nome=teste

    Request POST                         ${EP_USER}${user}    
    ...                                  ${params}


Então é apresentado as informações do usuario pesquisado
    [Documentation]    É apresentado as informações do usuario pesquisado

    Should Be Equal As Strings           ${RESPONSE.status_code}            201


Dado que um novo usuario seja cadastrado
    [Documentation]    Usuario seja cadastrado    

    Request body                         ${PATH_USER_REGISTER}
    Request POST                         ${EP_USER_REGISTER}


Então validar usuario cadastrado com sucesso
    [Documentation]    Validar usuario cadastrado com sucesso

    Should Be Equal As Strings           ${RESPONSE.status_code}            200

    Dictionary Should Contain Key        ${RESPONSE.json()}                 id
    Should Be True                       ${RESPONSE.json()['id']} > 0
    Dictionary Should Contain Key        ${RESPONSE.json()}                 token
    Should Not Be Empty                  ${RESPONSE.json()['token']} 


Dado que atualize os dados do usuario
    [Documentation]    atualizar os dados do usuario
    [Arguments]                          ${idUsuario}

    Request body                         ${PATH_USER_UPDATE}
    Request PUT                          ${EP_USER_UPDATE}${idUsuario}


Então validar dados do usuario atualizados
    [Documentation]    Validar dados do usuario atualizados

    Should Be Equal As Strings           ${RESPONSE.status_code}            200

    Dictionary Should Contain Key        ${RESPONSE.json()}                 name
    Dictionary Should Contain Key        ${RESPONSE.json()}                 job
    Dictionary Should Contain Key        ${RESPONSE.json()}                 updatedAt


Dado que exclua um usuario
    [Documentation]    Excluir um usuario
    [Arguments]                          ${idUsuario}

    Request DELETE                       ${EP_USER_DELETE}${idUsuario}


Então validar usuario excluido
    [Documentation]    validar usuario excluido

    Should Be Equal As Strings           ${RESPONSE.status_code}            204