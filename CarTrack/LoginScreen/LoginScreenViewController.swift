//
//  LoginScreenViewController.swift
//  CarTrack
//
//  Created by Prashant Singh on 9/5/21.
//

import UIKit
import Combine

class LoginScreenViewController: UIViewController {
    
    var userEmail: String = ""
    var userPassword: String = ""
    var selectedToKeepLoggedIn: Bool = false
    
    var userEmailSubsciber: AnyCancellable?
    var loginPasswordSubsciber: AnyCancellable?
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private lazy var contentView = LoginScreenView()
    private let viewModel: LoginScreenViewModel
    
    init(viewModel: LoginScreenViewModel = LoginScreenViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }
    
    private func setUpTargets() {
        contentView.loginTextField.addTarget(self, action: #selector(loginFieldDidChange(_:)), for: .editingChanged)
        contentView.passwordTextField.addTarget(self, action: #selector(passwordFieldDidChange(_:)), for: .editingChanged)
        contentView.toggleSecureEntry.addTarget(self, action: #selector(toggleSecureEntryDidClick(_:)), for: .touchUpInside)
        contentView.stayLoggedButton.addTarget(self, action: #selector(toggleStayLoggedDidClick(_:)), for: .touchUpInside)
        contentView.selectCountryButton.addTarget(self, action: #selector(selectCountryDidClick(_:)), for: .touchUpInside)
        
        contentView.loginButton.addTarget(self, action: #selector(loginDidClick(_:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Mark:- This is only to insert test Email/Password when run on a new device.
        let testAcct = InsertTestData()
        testAcct.checkTestDataExists()
        
        self.view.frame.origin.y = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginScreenViewController.keyboardDidShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        
        initialization()
    }
    
    @objc private func hideKeyboard(notification: NSNotification) {
        self.view.frame.origin.y = 0
        self.view.endEditing(true)
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else
        {
            return
        }
        self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    private func initialization() {
        
        setUpTargets()
        
        let userEmail = viewModel.userEmailMessagePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] (str) in
                
                guard self != nil else {
                    return
                }
        }
        userEmailSubsciber = AnyCancellable(userEmail)
        
        let loginPassword = viewModel.loginPasswordMessagePublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] (str) in
                
                guard self != nil else {
                    return
                }
        }
        loginPasswordSubsciber = AnyCancellable(loginPassword)
        
        
        viewModel.validToProceed
            .map { $0 != nil}
            .receive(on: RunLoop.main)
            .sink(receiveValue: { (isEnable) in
                if isEnable {
                    self.contentView.loginButton.setTitleColor(.white, for: UIControl.State.normal)
                    self.contentView.loginButton.backgroundColor = UIColor.init(colorWithHexValue: 0x0A91FF)
                } else {
                    self.contentView.loginButton.setTitleColor(.lightGray, for: UIControl.State.normal)
                    self.contentView.loginButton.backgroundColor = UIColor.init(colorWithHexValue: 0x246AA3)
                }
                self.contentView.loginButton.isEnabled = isEnable
            })
            .store(in: &cancellableSet)
    }
}

extension LoginScreenViewController {
    
    @objc func loginFieldDidChange(_ textField: UITextField) {
        viewModel.userEmail = textField.text ?? ""
    }
    
    @objc func passwordFieldDidChange(_ textField: UITextField) {
        viewModel.loginPassword = textField.text ?? ""
    }
    
    
    @objc func toggleSecureEntryDidClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            contentView.passwordTextField.isSecureTextEntry = false
            contentView.toggleSecureEntry.setImage(UIImage(systemName: "eye"), for: UIControl.State.normal)
        } else {
            contentView.passwordTextField.isSecureTextEntry = true
            contentView.toggleSecureEntry.setImage(UIImage(systemName: "eye.slash"), for: UIControl.State.normal)
        }
    }
    
    @objc func toggleStayLoggedDidClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            contentView.stayLoggedButton.setImage(UIImage(systemName: "square"), for: UIControl.State.normal)
            contentView.stayLoggedButton.tintColor = UIColor.lightGray
            selectedToKeepLoggedIn = false
        } else {
            contentView.stayLoggedButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: UIControl.State.normal)
            contentView.stayLoggedButton.tintColor = UIColor.lightGray
            selectedToKeepLoggedIn = true
        }
    }

    @IBAction func selectCountryDidClick(_ sender: UIButton) {
        let viewController = CountryListScreenViewController()
        viewController.countryListScreenViewControllerDelegate = self
        present(viewController, animated: true, completion: nil)
        
    }

    @IBAction func loginDidClick(_ sender: UIButton) {
        
        if let email = contentView.loginTextField.text {
            userEmail = email
        }
            
        if let pass = contentView.passwordTextField.text {
            userPassword = pass
        }
            
        if  userEmail != "" &&
            userPassword != "" {
            let isValid = viewModel.validateLoginCredentials(userEmail: userEmail, password: userPassword)
            if isValid.0 == true && isValid.1 == true {
                if selectedToKeepLoggedIn == true {
                    UserDefaults.standard.setIsLoggedIn(value: true)
                }
                let viewController = UsersListScreenViewController()
                let navigationVC = UINavigationController(rootViewController: viewController)
                navigationVC.modalPresentationStyle = .fullScreen
                present(navigationVC, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Invalid Entry", message: "User Email/Password Invalid", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
}

extension LoginScreenViewController: CountryListScreenViewControllerDelegate {
    func displayTextOnLoginScreen(textToDisplay: String) {
        contentView.selectCountryButton.setTitle(textToDisplay, for: .normal)
    }
}



