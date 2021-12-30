//
//  CarTrackUITests.swift
//  CarTrackUITests
//
//  Created by Prashant Singh on 8/5/21.
//

import XCTest

class WhenLoginViewIsDisplayed: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }
    
    func test_Email_And_Password_Fields_Contain_Default_Value(){
        let loginTextField = app.textFields["loginTextField"]
        XCTAssertEqual(loginTextField.value as! String, "Email Address")
        
        let securedEntryPasswordTextField = app.secureTextFields["passwordTextField"]
        XCTAssertEqual(securedEntryPasswordTextField.value as! String, "Password")
    }

    func test_Secure_Entry_Button_Tap() {
        let toggleSecuredEntry = app.buttons["toggleSecureEntry"]
        toggleSecuredEntry.tap()
        
        let unsecuredEntryPasswordTextField = app.textFields["passwordTextField"]
        XCTAssertEqual(unsecuredEntryPasswordTextField.value as! String, "Password")
    }
    
    func test_Selected_Country_Button_Tap() {
        let selectCountryButton = app.buttons["selectCountryButton"]
        selectCountryButton.tap()
    }

    func test_Stay_Logged_In_Button_Tap() {
        let stayLoggedInButton = app.buttons["stayLoggedButton"]
        stayLoggedInButton.tap()
    }
    
    func test_Login_Button_Is_Disabled() {
        let loginButton = app.buttons["loginButton"]
        XCTAssertFalse(loginButton.isEnabled)
    }
    
    func test_Login_Button_Not_Enabled_When_Password_Is_Not_Entered() {
        let loginTextField = app.textFields["loginTextField"]
        let loginButton = app.buttons["loginButton"]
        
        loginTextField.tap()
        loginTextField.typeText("UserName")
        XCTAssertFalse(loginButton.isEnabled)
    }
    
    func test_Login_Button_Not_Enabled_When_User_Name_Is_Not_Entered() {
        let securedEntryPasswordTextField = app.secureTextFields["passwordTextField"]
        let loginButton = app.buttons["loginButton"]

        securedEntryPasswordTextField.tap()
        securedEntryPasswordTextField.typeText("Pasword")
        XCTAssertFalse(loginButton.isEnabled)
        
    }
    
    func test_Login_Button_Not_Enabled_When_User_Name_Is_Invalid_Format() {
        let loginTextField = app.textFields["loginTextField"]
        let securedEntryPasswordTextField = app.secureTextFields["passwordTextField"]
        let loginButton = app.buttons["loginButton"]

        loginTextField.tap()
        loginTextField.typeText("UserName")
        securedEntryPasswordTextField.tap()
        securedEntryPasswordTextField.typeText("Pasword")
        XCTAssertFalse(loginButton.isEnabled)
    }
    
    func test_Login_Button_Enabled_When_User_Name_Valid_Format_And_Password_Invalid_Format() {
        let loginTextField = app.textFields["loginTextField"]
        let securedEntryPasswordTextField = app.secureTextFields["passwordTextField"]
        let loginButton = app.buttons["loginButton"]

        loginTextField.tap()
        loginTextField.typeText("UserName@xyz.com")
        securedEntryPasswordTextField.tap()
        securedEntryPasswordTextField.typeText("Pas")
        XCTAssertFalse(loginButton.isEnabled)
    }
    
    func test_Login_Button_Enabled_When_User_Name_And_Password_Valid_Format() {
        let loginTextField = app.textFields["loginTextField"]
        let securedEntryPasswordTextField = app.secureTextFields["passwordTextField"]
        let loginButton = app.buttons["loginButton"]

        loginTextField.tap()
        loginTextField.typeText("UserName@xyz.com")
        securedEntryPasswordTextField.tap()
        securedEntryPasswordTextField.typeText("Password")
        XCTAssertTrue(loginButton.isEnabled)
        
        loginButton.tap()
        addUIInterruptionMonitor(withDescription: "Invalid Entry") { (alert) -> Bool in
            alert.buttons["OK"].tap()
            return true
        }
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }
}
