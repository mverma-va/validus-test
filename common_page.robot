*** Settings ***
Documentation     MSUI base resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.

Variables         ../common/myvariables.py
Resource          ../resource/resource.robot
Library           ../resource/resource_python.py

*** Variables ***
# List of Locators

# Data Variables
${LOGIN_URL}      https://ril-nightly.sotidev.com/Connect/
${timeout}        5s

*** Keywords ***
Open Browser To Login Page
    [Documentation]    Open and maximize browser, go to application login url
    #Go To    about:
    go to    ${LOGIN_URL}
    Maximize Browser Window
    Login Page Should Be Open

Login Page Should Be Open
    [Documentation]    In login page, verify the title.
    Title Should Be    Log In - Connect Management

Login To Application
    [Arguments]    ${username}    ${password}
    [Documentation]    Login into application with given username and loc_password.
    Wait Until Element Is Visible    ${loc_username}    ${timeout}
    input text    ${loc_username}    ${username}
    input password    ${loc_password}    ${password}
    submit form

Open Browser and Login
    [Documentation]    Open and maximize the browser, login into application with automation user.
    Open Browser To Login Page
    Login To Application    ${username}    ${password}

Logout of Application
    [Documentation]    Successfully logout out of the application.
    Click Element    ${loc_user_dropdown}
    Click Element    ${loc_logout}

Delete Cookies and Logout
    [Documentation]    Logout of the application and delete cookies.
    go to    ${LOGIN_URL}
    sleep  2s
    Logout of Application
    Delete All Cookies

Validate Carousel Message
    [Documentation]  Validate Carousel Message
    [Arguments]  ${carousel_message}
    Wait Until Element Is Visible  ${loc_carousel}
    Element Should Contain  ${loc_carousel}    ${carousel_message}
    Close Carousel

Close Carousel
    Click Element    ${loc_carousel_close}

Goto Connect Page
    [Arguments]  ${loc_ham_row}
    Click Element    ${loc_hamburger_menu}
    sleep  0.25s
    Click Element    ${loc_ham_row}
    sleep  2s

Click Button by Text
    [Arguments]  ${btn_text}
    Click Element    //*[contains(text(),'${btn_text}')]

Click Button by Class
    [Arguments]  ${class_name}
    Click Element    //*[@class='${class_name}']

Select Column by Name
    [Arguments]  ${col_name}
    Click Element  ${loc_column_dropdown}
    Click Element  ${loc_right_unselectall_checkbox}
    Input Text  //input[@placeholder='Search']  ${col_name}
    Click Element  //strong[contains(text(),'${col_name}')]

Search Devices By Device Property
    [Arguments]  ${device_property}  ${search_text}
    Click Element  ${loc_device_search_dropdown}
    ${row_id}=  Get Row Index of Element  //div[@class='search-header']//soti-option//div[1]  ${device_property}
    Click ELement  //div[@class='search-header']//soti-option[${row_id}]//div[1]
    Input Text  ${loc_device_search_textbox}  ${search_text}
    Click Element  ${loc_device_search_button}
    sleep  2s

Open Device Panel By Name
    [Arguments]  ${device_name}
    Search Devices By Device Property   Device Name  ${device_name}
    Click Element    //span[contains(text(),'${device_name}')]
    Wait Until Page Contains Element   ${loc_dpanel_3dots_button}