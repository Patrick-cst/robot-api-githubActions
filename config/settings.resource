*** Settings ***

Library     RequestsLibrary
Library     JSONLibrary
Resource    environment/endpoints.resource
Resource    ../resources/paths/autentication_path.resource
Resource    ../resources/variables/autentication_variables.resource

*** Keywords ***
Start session
    [Documentation]    Start session
    
    Generate Token 
    
Request POST
    [Documentation]    Request POST
    [Arguments]                                ${endpoint}    
    ...                                        ${params}=None

    IF  ${params} == None
        ${response}    POST    ${BASE_URL}${endpoint}    
        ...    json=${data}    
        ...    headers=${HEADERS}   
        ...    expected_status=any
    ELSE
        ${response}    POST    ${BASE_URL}${endpoint}    
        ...    json=${data}    
        ...    params=${params}    
        ...    headers=${HEADERS}    
        ...    expected_status=any
    END

    Set Test Variable                          ${RESPONSE}    
    ...                                        ${response}

Request GET
    [Documentation]    Request GET
    [Arguments]                                ${endpoint}    
    ...                                        ${params}=None
    
    IF  ${params} == None
        ${response}    GET     ${BASE_URL}${endpoint}
        ...    headers=${HEADERS} 
        ...    expected_status=any
    ELSE
        ${response}    GET     ${BASE_URL}${endpoint}       
        ...    params=${params}    
        ...    headers=${HEADERS}    
        ...    expected_status=any
    END

    Set Test Variable                          ${RESPONSE}    
    ...                                        ${response}

Request PUT
    [Documentation]    Request PUT
    [Arguments]                                ${endpoint}    
    ...                                        ${params}=None
    
    IF  ${params} == None
        ${response}    PUT     ${BASE_URL}${endpoint}     
        ...    json=${data}
        ...    headers=${HEADERS} 
        ...    expected_status=any
    ELSE
        ${response}    PUT     ${BASE_URL}${endpoint}    
        ...    json=${data}    
        ...    params=${params}    
        ...    headers=${HEADERS}    
        ...    expected_status=any
    END

    Set Test Variable                          ${RESPONSE}    
    ...                                        ${response}

Request DELETE
    [Documentation]    Request DELETE
    [Arguments]                                ${endpoint}    
    ...                                        ${params}=None

    IF  ${params} == None
        ${response}    DELETE   ${BASE_URL}${endpoint}     
        ...    json=${data}
        ...    headers=${HEADERS} 
        ...    expected_status=any
    ELSE
        ${response}     DELETE  ${BASE_URL}${endpoint}    
        ...    json=${data}    
        ...    params=${params}    
        ...    headers=${HEADERS}    
        ...    expected_status=any
    END

    Set Test Variable                          ${RESPONSE}    
    ...                                        ${response}

Request body
    [Documentation]    Request body
    [Arguments]                                ${path}

    ${data}        Load JSON From File         ${path}

    Set Global Variable                        ${data}


Headers
    [Documentation]    Headers

    ${headers}    Create Dictionary
    ...    Content-Type=application/json
    ...    Accept=application/json
    ...    Authorization=Bearer ${AUTH_TOKEN}

    Set Global Variable                        ${HEADERS}    
    ...                                        ${headers}

Generate Token
    [Documentation]    Generate token
    
    Request body                               ${validCredentials}

    ${response}             POST               ${BASE_URL}${EP_LOGIN}      
    ...    json=${data}      
    ...    expected_status=any
    
    Set Global Variable                        ${AUTH_TOKEN}               
    ...                                        ${response.json()['token']}

Validar status code
    [Documentation]    Validar status code
    [Arguments]                                ${statusCode}

    Should Be Equal As Strings                 ${RESPONSE.status_code}            
    ...                                        ${statusCode}