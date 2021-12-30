//
//  LoginScreenView.swift
//  CarTrack
//
//  Created by Prashant Singh on 8/5/21.
//

import UIKit

final class LoginScreenView: UIView {
        
        lazy var logoImage = UIImageView()
        lazy var loginTextField = UITextField()
        lazy var passwordTextField = UITextField()
        lazy var toggleSecureEntry = UIButton()
        lazy var selectCountryButton = UIButton()
        lazy var loginButton = UIButton()
        lazy var stayLoggedButton = UIButton()
        lazy var stayLoggedLabel = UILabel()

        init() {
            super.init(frame: .zero)
            
            addSubviews()
            setUpConstraints()
            setUpViews()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        
        private func addSubviews() {
            [logoImage, loginTextField, passwordTextField, selectCountryButton, stayLoggedButton, stayLoggedLabel, loginButton]
                .forEach {
                    addSubview($0)
                    $0.translatesAutoresizingMaskIntoConstraints = false
                }
        }
        
        private func setUpConstraints() {
            
            NSLayoutConstraint.activate([
                logoImage.topAnchor.constraint(equalTo: self.topAnchor),
                logoImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                logoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0),
                logoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0.0),
                logoImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
                                            
                loginTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 30),
                loginTextField.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor),
                loginTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
                loginTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
                loginTextField.heightAnchor.constraint(equalToConstant: 35.0),
                
                passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
                passwordTextField.centerXAnchor.constraint(equalTo: loginTextField.centerXAnchor),
                passwordTextField.widthAnchor.constraint(equalTo: loginTextField.widthAnchor, multiplier: 1.0),
                passwordTextField.heightAnchor.constraint(equalTo: loginTextField.heightAnchor),
                                            
                selectCountryButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
                selectCountryButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
                selectCountryButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor, multiplier: 1.0),
                selectCountryButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor),
                
                stayLoggedButton.topAnchor.constraint(equalTo: selectCountryButton.bottomAnchor, constant: 10),
                stayLoggedButton.leftAnchor.constraint(equalTo: selectCountryButton.leftAnchor),
                stayLoggedButton.widthAnchor.constraint(equalToConstant: 20),
                stayLoggedButton.heightAnchor.constraint(equalToConstant: 20),
                
                stayLoggedLabel.topAnchor.constraint(equalTo: selectCountryButton.bottomAnchor, constant: 10),
                stayLoggedLabel.leftAnchor.constraint(equalTo: stayLoggedButton.rightAnchor, constant: 10),
                stayLoggedLabel.widthAnchor.constraint(equalToConstant: 200),
                stayLoggedLabel.heightAnchor.constraint(equalTo: stayLoggedButton.heightAnchor),
                
                loginButton.topAnchor.constraint(equalTo: stayLoggedButton.bottomAnchor, constant: 70),
                loginButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
                loginButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor, multiplier: 1.0),
                loginButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor)
            ])
        }
        
        private func setUpViews() {
            backgroundColor = UIColor.black
            
            logoImage.image = UIImage(named: "Logo")
            
            loginTextField.addPadding(padding: .left(10))
            loginTextField.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            loginTextField.backgroundColor = UIColor.init(colorWithHexValue: 0x121212)
            loginTextField.textColor = UIColor.lightGray
            loginTextField.accessibilityIdentifier = "loginTextField"
            
            passwordTextField.addPadding(padding: .left(10))
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            passwordTextField.backgroundColor = UIColor.init(colorWithHexValue: 0x121212)
            passwordTextField.isSecureTextEntry = true
            passwordTextField.textColor = UIColor.lightGray
            passwordTextField.accessibilityIdentifier = "passwordTextField"
            
            toggleSecureEntry = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            toggleSecureEntry.tintColor = UIColor.lightGray
            toggleSecureEntry.setImage(UIImage(systemName: "eye.slash"), for: UIControl.State.normal)
            toggleSecureEntry.accessibilityIdentifier = "toggleSecureEntry"
            
            passwordTextField.rightView = toggleSecureEntry
            passwordTextField.rightViewMode = .always
            
            selectCountryButton.setTitle("Singapore", for: UIControl.State.normal)
            selectCountryButton.layer.backgroundColor = UIColor.init(colorWithHexValue: 0x121212).cgColor
            selectCountryButton.setTitleColor(.lightGray, for: UIControl.State.normal)
            selectCountryButton.contentHorizontalAlignment = .left
            selectCountryButton.titleEdgeInsets.left = 10
            selectCountryButton.accessibilityIdentifier = "selectCountryButton"
   
            stayLoggedButton.tintColor = UIColor.lightGray
            stayLoggedButton.setImage(UIImage(systemName: "square"), for: UIControl.State.normal)
            stayLoggedButton.accessibilityIdentifier = "stayLoggedButton"
            
            stayLoggedLabel.text = "Stay Logged In"
            stayLoggedLabel.backgroundColor = UIColor.black
            stayLoggedLabel.textColor = UIColor.lightGray
            stayLoggedLabel.font = UIFont.systemFont(ofSize: 14)
            stayLoggedLabel.accessibilityIdentifier = "stayLoggedLabel"
            
            loginButton.setTitle("Log In", for: UIControl.State.normal)
            loginButton.accessibilityIdentifier = "loginButton"
        }
}
