*** Settings ***
Suite Setup       Browser Setup
Suite Teardown    Close Browser
Test Setup        Open Browser and Login
Test Teardown     Delete Cookies and Logout
Default Tags      smoke    regression
Metadata          Executed At    %{COMPUTERNAME}
Metadata          Test User    mverma
Metadata          Operating System    %{OS}
Metadata          Processor    %{PROCESSOR_LEVEL}
Metadata          Test Framework    Robot Framework Python
Resource          common_page.robot

#robot -x report.xml --loglevel DEBUG --outputdir output common_tests.robot
*** Test Cases ***
Navigate UI as Admin User to Rules Page
    Goto Connect Page    ${loc_ham_rules}
    Title Should Be    All Rules - Connect Management
    Wait Until Page Contains    All Rules
    Wait Until Page Contains    Action Rules
    Wait Until Page Contains    Automation Rules
    Wait Until Page Contains    Data Collection Rules
    Wait Until Page Contains    Enrollment Rules
    Wait Until Page Contains    Custom Rules

Navigate UI as Admin User to Reports Page
    Goto Connect Page    ${loc_ham_reports}
    Title Should Be    Reports - Connect Management
    Wait Until Page Contains    RECORDS
    Wait Until Page Contains    Quick Report

Navigate UI as Admin User to Users Page
    Goto Connect Page    ${loc_ham_user_security}
    Title Should Be    Users - Connect Management
    Wait Until Page Contains    View All Users
    Wait Until Page Contains    Administrator
    Wait Until Page Contains    Global User

    
Navigate UI as Admin User to Alerts Page
    Goto Connect Page    ${loc_ham_alerts}
    Title Should Be    New Devices - Connect Management
    Wait Until Page Contains    New Devices
    Wait Until Page Contains    Rule Alerts
    Wait Until Page Contains    System Messages
    
Navigate UI as Admin User to Global Settings Page
    Goto Connect Page    ${loc_ham_global_settings}
    Title Should Be    General Settings - Connect Management
    Wait Until Page Contains    General
    Wait Until Page Contains    Logging
    Wait Until Page Contains    Privacy
    
Navigate UI as Admin User to Administration Page
    Goto Connect Page    ${loc_ham_administration}
    Title Should Be    System Management - Connect Management
    Wait Until Page Contains    Logs
    Wait Until Page Contains    Device Type Definitions
    Wait Until Page Contains    System Management

Navigate UI as Admin User to Devices Page
    Goto Connect Page    ${loc_ham_devices}
    Title Should Be    Devices - Connect Management
    Wait Until Page Contains    DEVICES

Navigate UI as Global User to Rules Page
    [Tags]  globaluser
    Goto Connect Page    ${loc_ham_rules}
    Title Should Be    All Rules - Connect Management
    Wait Until Page Contains    All Rules
    Wait Until Page Contains    Action Rules
    Wait Until Page Contains    Automation Rules
    Wait Until Page Contains    Data Collection Rules
    Wait Until Page Contains    Enrollment Rules
    Wait Until Page Contains    Custom Rules

Navigate UI as Global User to Reports Page
    [Tags]  globaluser
    Goto Connect Page    ${loc_ham_reports}
    Title Should Be    Reports - Connect Management
    Wait Until Page Contains    RECORDS
    Wait Until Page Contains    Quick Report

Navigate UI as Global User to Alerts Page
    [Tags]  globaluser
    Goto Connect Page    ${loc_ham_alerts}
    Title Should Be    New Devices - Connect Management
    Wait Until Page Contains    Rule Alerts
    Wait Until Page Contains    System Messages

Navigate UI as Global User to Devices Page
    [Tags]  globaluser
    Goto Connect Page    ${loc_ham_devices}
    Title Should Be    Devices - Connect Management
    Wait Until Page Contains    DEVICES