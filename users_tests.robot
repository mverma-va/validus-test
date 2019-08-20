*** Settings ***
Suite Setup       Run Keywords  Browser Setup    Users Testsuite Setup
Suite Teardown    Close Browser
Test Setup        Open Browser and Login
Test Teardown     Delete Cookies and Logout
Default Tags      smoke    regression
Metadata          Executed At    %{COMPUTERNAME}
Metadata          Test User    mverma
Metadata          Operating System    %{OS}
Metadata          Processor    %{PROCESSOR_LEVEL}
Metadata          Test Framework    Robot Framework Python
Resource          users_page.robot

#robot -x report.xml --loglevel DEBUG --outputdir output users_tests.robot
*** Keywords ***
Users Testsuite Setup
    ${firstname}=  FakerLibrary.User Name
    ${roleuser1}=  FakerLibrary.User Name
    ${rolename1}=  FakerLibrary.User Name
    ${rolename2}=  FakerLibrary.User Name
    set suite variable  ${firstname}
    set suite variable  ${roleuser1}
    set suite variable  ${rolename1}
    set suite variable  ${rolename2}
*** Test Cases ***
Create User
    Goto Connect Page    ${loc_ham_user_security}
    ${row_id}=  Get Row Index of Element  //div[@class='selection-menu']/div    Administrator
    Click Element    //div[@class='selection-menu']/div[${row_id}]/div[1]
    sleep  1s
    Click Element    ${loc_new_user}
    Fill Create User Form  ${firstname}
    sleep  1s
    Page Should Contain  ${firstname}

Force Change Password For New User
    [Setup]  NONE
    Open Browser To Login Page
    Login To Application    ${firstname}    ${userpwd1}
    sleep  2s
    Element Should Be Enabled  //button[@class='secondary']
    Element Should Be Disabled  //button[contains(text(),'OK')]
    Input Text    //input[@id='currentPassword']    ${userpwd1}
    Input Text    //input[@id='newPassword']    ${userpwd2}
    Input Text    //input[@id='confirm-password']    ${userpwd2}
    Element Should Be Enabled  //button[contains(text(),'OK')]
    Click Button by Text  OK
    sleep  2s

Create Existing User Should Fail
    Goto Connect Page    ${loc_ham_user_security}
    ${row_id}=  Get Row Index of Element  //div[@class='selection-menu']/div    Administrator
    Click Element    //div[@class='selection-menu']/div[${row_id}]/div[1]
    sleep  1s
    Click Element    ${loc_new_user}
    Fill Create User Form  ${firstname}
    sleep  1s
    Page Should Contain  ${firstname}
    Validate Carousel Message    Your attempt to create a user failed because a user with that username already exists

Edit User
#    ${firstname}=  set variable    hooverbrent
    Goto Connect Page    ${loc_ham_user_security}
    Find And Click User In Users Table  ${firstname}
    Click Element    ${loc_user_actionbar_rename}
    Fill Edit User Form

Edit Existing User Should Fail
#    ${firstname}=  set variable    hooverbrent
    Goto Connect Page    ${loc_ham_user_security}
    Find And Click User In Users Table  ${firstname}
    click element    ${loc_user_actionbar_rename}
    sleep  2s
    Input Text    //input[@name='edit_username']    Administrator
    Click Element    //button[@type='submit']
    Validate Carousel Message    Your attempt to modify a user failed because a user with that username already exists

Change User Password
#    ${firstname}=  set variable    hooverbrent
    Goto Connect Page    ${loc_ham_user_security}
    Find And Click User In Users Table  ${firstname}
    click element    ${loc_user_actionbar_password}
    Fill Change User Password Form

Delete User
#    ${firstname}=  set variable    User965
    Goto Connect Page    ${loc_ham_user_security}
    Find And Click User In Users Table  ${firstname}
    Click Element    ${loc_user_actionbar_delete}
    Element Should Contain  //div[@class='content']    Are you sure you want to remove the user '${firstname}'?
    Click Button by Class  primary

# ++++++++++++++Roles Test suites+++++++++
Create Role
    Goto Connect Page    ${loc_ham_user_security}
    ${row_id}=  Get Row Index of Element  //div[@class='selection-menu']/div    Administrator
    Click Element    //div[@class='selection-menu']/div[${row_id}]/div[1]
    Click Element    //div[@class='selection-menu']//div[${row_id}]//div[1]//sc-action-dropdown-button[1]
    Click Element    //soti-dropdown-node[@class='ng-star-inserted']
    Clear Element Text    //input[@id='input-modal']
    Input Text  //input[@id='input-modal']    ${rolename1}
    sleep  1s
    Click Button by Text  Save
    Page Should Contain  ${rolename1}

Create User For Role
    Goto Connect Page    ${loc_ham_user_security}
    ${row_id}=  Get Row Index of Element  //div[@class='selection-menu']/div    ${rolename1}
    Click Element    //div[@class='selection-menu']/div[${row_id}]/div[1]
    sleep  1s
    Click Element    ${loc_new_user}
    Fill Create User Form  ${roleuser1}
    sleep  1s
    Page Should Contain  ${roleuser1}

    Click Element    //div[@class='selection-menu']/div[${row_id}]/div[1]
    Click Element    //div[@class='selection-menu']//div[${row_id}]//div[1]//sc-action-dropdown-button[1]
    Page Should Not Contain Element  //body//soti-dropdown-node[3]
    Click Element    ${loc_background1}
#    Drag And Drop By Offset  //body//soti-dropdown-node[2]  50  50

Rename Role
    Goto Connect Page    ${loc_ham_user_security}
    ${row_id}=  Get Row Index of Element  //div[@class='selection-menu']/div    ${rolename1}
    Click Element    //div[@class='selection-menu']/div[${row_id}]/div[1]
    Click Element    //div[@class='selection-menu']//div[${row_id}]//div[1]//sc-action-dropdown-button[1]
    Click Element  //body//soti-dropdown-node[2]
    Element Should Be Disabled  //button[contains(text(),'Save')]
    Clear Element Text    //input[@id='input-modal']
    Input Text  //input[@id='input-modal']    ${rolename1}
    Element Should Contain  //span[@class='error-message-text']  You need to enter a unique name
    Clear Element Text    //input[@id='input-modal']
    Input Text  //input[@id='input-modal']    ${rolename2}
    Click Button by Text  Save

Delete Role
    Goto Connect Page    ${loc_ham_user_security}
    Find And Click User In Users Table  ${roleuser1}
    Click Element    ${loc_user_actionbar_delete}
    Click Button by Class  primary
    sleep  1s
    ${row_id}=  Get Row Index of Element  //div[@class='selection-menu']/div    ${rolename2}
    Click Element    //div[@class='selection-menu']/div[${row_id}]/div[1]
    Click Element    //div[@class='selection-menu']//div[${row_id}]//div[1]//sc-action-dropdown-button[1]
    Click Element  //body//soti-dropdown-node[3]
    Element Should Contain  //div[@id='delete']  Are you sure you want to delete the role '${rolename2}'?
    Click Button by Class  primary
