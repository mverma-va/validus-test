*** Settings ***
Documentation     Login Page Methods
Resource          ../common/common_page.robot

*** Variables ***
# List of Locators

# Data Variables
${userpwd1}   test1
${userpwd2}   test2

*** Keywords ***
Fill Create User Form
    [Arguments]  ${firstname}
    sleep  2s
    Element Should Be Disabled    //button[@type='submit']
    Input Text    //input[@name='fullName']    ${firstname}
    Input Text    //input[@name='edit_username']    ${firstname}
    Input Text    //input[@name='email']    ${firstname}@domain.com
    Input Text    //input[@name='edit_password']    ${userpwd1}
    Input Text    //input[@name='confirmPassword']    ${userpwd1}
#    Element Should Contain  //div[@class='warning-msg']    No roles added
#    Click Element    //button[@class='btn btn-link']
    Click Element    //button[@type='submit']

Fill Edit User Form
    sleep  2s
    Input Text    //input[@name='fullName']    ${firstname}
    Input Text    //input[@name='edit_username']    ${firstname}
    Input Text    //input[@name='email']    ${firstname}@domain.co.in
    Click Element    //button[@type='submit']

Fill Change User Password Form
    Element Should Be Disabled    //button[@type='submit']
    Input Text    //input[@name='password']    ${userpwd2}
    Input Text    //input[@name='confirm-password']    ${userpwd2}
    Click Element    //button[@type='submit']

Find And Click User In Users Table
    [Arguments]  ${firstname}
    ${row_id}=  Get Row Index of Element  ${loc_users_table}    ${firstname}
    Click Element    xpath://div[@class='table-content-rows']//soti-row[${row_id}]//soti-cell[2]

