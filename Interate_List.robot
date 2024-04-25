*** Settings ***
Library    AppiumLibrary
Library    Collections


*** Variables ***
${element_id}      id=com.app.abhibus:id/cityElasticSearchRv
${Title_of_app}    id=com.app.abhibus:id/titleTextView
${Leaving_Frome}   id=com.app.abhibus:id/sourceTextView
${Source}          id=android:id/search_src_text
&{USERDETAILS}     source_Text=Surat       Destination_Text=Ahmedabad
${Data}            //android.view.ViewGroup[@resource-id='com.app.abhibus:id/constraintLayout']//android.widget.TextView
@{text_list}



*** Test Cases ***
Open Application
    [Tags]    Suite_Setup
    Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=964987592300047    appPackage=com.app.abhibus    appActivity=com.abhibus.mobile.WelcomeScreen    automationName=Uiautomator2    noReset=true    fullReset=false    autoGrantPermissions=true    noSign=true    newCommandTimeout=480
    Wait Until Page Contains Element    ${Title_of_app}     timeout=10s        # Your Open Application Test Case Implementation Here

Search Bus
    Click Element    ${Leaving_Frome}
    Sleep    1s
    Click Element    ${Source}
    Sleep    2s
    Input Text    ${Source}    ${USERDETAILS}[source_Text]
    Sleep    2s

    Hide Keyboard

Store_City_Data_into_Variable

    ${text_elements}=    Get WebElements    xpath=${Data}
    FOR    ${element}    IN    @{text_elements}
        ${text}=    Get Text    ${element}
        Append To List    ${text_list}    ${text}    # Enclose ${text} in a list
    END
#    Log to console    ${text_list}

Print_Only_City_NOT_StATE

     FOR    ${index}    IN RANGE    0    ${text_list.__len__()}    2
        Log to console    ${text_list}[${index}]
    END
