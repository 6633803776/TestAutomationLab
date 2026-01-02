*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${SERVER}         localhost:7272
${BROWSER}        Chrome
${URL}            http://${SERVER}/Lab4/Registration.html
${DELAY}          0.5

*** Test Cases ***
# --- Scenario 1: ลงทะเบียนสำเร็จ (Success Cases) ---

UAT-Lab04-001-01 Register Success (Full Data)
    [Documentation]    ทดสอบกรอกข้อมูลครบทุกช่อง รวมทั้ง Organization
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text      id=firstname      Somyod
    Input Text      id=lastname       Sodsai
    Input Text      id=organization   CS KKU
    Input Text      id=email          somyod@kkumail.com
    Input Text      id=phone          091-001-1234
    Click Button    Register
    # [cite_start]ตรวจสอบผลลัพธ์หน้า Success [cite: 29]
    Title Should Be    Success
    Page Should Contain    Thank you for registering with us
    Page Should Contain    We will send a confirmation to your email soon.
    [Teardown]    Close Browser

UAT-Lab04-001-02 Register Success (No Organization)
    [Documentation]    ทดสอบกรอกข้อมูลครบ *ยกเว้น* Organization (Optional)
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text      id=firstname      Somyod
    Input Text      id=lastname       Sodsai
    # เว้นช่อง Organization ไว้
    Input Text      id=email          somyod@kkumail.com
    Input Text      id=phone          091-001-1234
    Click Button    Register
    # [cite_start]ตรวจสอบผลลัพธ์หน้า Success [cite: 29]
    Title Should Be    Success
    Page Should Contain    Thank you for registering with us
    [Teardown]    Close Browser

# --- Scenario 2: ลงทะเบียนไม่สำเร็จ (Failure Cases) ---

UAT-Lab04-002-01 Empty First Name
    [Documentation]    ทดสอบไม่กรอก First Name
    Open Browser    ${URL}    ${BROWSER}
    Input Text      id=lastname       Sodsai
    Input Text      id=organization   CS KKU
    Input Text      id=email          somyod@kkumail.com
    Input Text      id=phone          091-001-1234
    Click Button    Register
    # [cite_start]ตรวจสอบ Error Message [cite: 30]
    Page Should Contain    Please enter your first name!!
    [Teardown]    Close Browser

UAT-Lab04-002-02 Empty Last Name
    [Documentation]    ทดสอบไม่กรอก Last Name
    Open Browser    ${URL}    ${BROWSER}
    Input Text      id=firstname      Somyod
    Input Text      id=organization   CS KKU
    Input Text      id=email          somyod@kkumail.com
    Input Text      id=phone          091-001-1234
    Click Button    Register
    Page Should Contain    Please enter your last name!!
    [Teardown]    Close Browser

UAT-Lab04-002-03 Empty Email
    [Documentation]    ทดสอบไม่กรอก Email
    Open Browser    ${URL}    ${BROWSER}
    Input Text      id=firstname      Somyod
    Input Text      id=lastname       Sodsai
    Input Text      id=organization   CS KKU
    Input Text      id=phone          091-001-1234
    Click Button    Register
    Page Should Contain    Please enter your email!!
    [Teardown]    Close Browser

UAT-Lab04-002-04 Empty Phone Number
    [Documentation]    ทดสอบไม่กรอก Phone Number
    Open Browser    ${URL}    ${BROWSER}
    Input Text      id=firstname      Somyod
    Input Text      id=lastname       Sodsai
    Input Text      id=organization   CS KKU
    Input Text      id=email          somyod@kkumail.com
    Click Button    Register
    Page Should Contain    Please enter your phone number!!
    [Teardown]    Close Browser

UAT-Lab04-002-05 Invalid Phone Number
    [Documentation]    ทดสอบกรอกเบอร์โทรผิดรูปแบบ (1234)
    Open Browser    ${URL}    ${BROWSER}
    Input Text      id=firstname      Somyod
    Input Text      id=lastname       Sodsai
    Input Text      id=organization   CS KKU
    Input Text      id=email          somyod@kkumail.com
    Input Text      id=phone          1234
    Click Button    Register
    Page Should Contain    Please enter a valid phone number
    [Teardown]    Close Browser