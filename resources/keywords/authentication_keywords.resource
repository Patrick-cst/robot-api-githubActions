*** Settings ***

Resource    ../../config/settings.resource
Resource    ../paths/autentication_path.resource


*** Keywords ***
Dado que eu envio credenciais válidas
    Request body           ${validCredentials}
    ${response}    POST    ${BASE_URL}${EP_LOGIN}      json=${data}
    Set Global Variable    ${AUTH_TOKEN}               ${response.json()['token']}

Dado que eu envio credenciais inválidas
    Request body           ${invalidCredentials}
    ${response}    POST    ${BASE_URL}${EP_LOGIN}      json=${data}    expected_status=any

    Set Global Variable      ${LOGIN_RESPONSE}           ${response}

Então eu devo receber um token de autenticação
    Should Not Be Empty    ${AUTH_TOKEN}

Então eu devo receber uma mensagem de erro
    [Arguments]            ${mensagem}
    Should Contain         ${LOGIN_RESPONSE.json()['error']}    ${mensagem}
