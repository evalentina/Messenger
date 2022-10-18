//
//  LoginViewController.swift
//  Messenger
//
//  Created by Валентина Евдокимова on 16.10.2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let scrollView : UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let emailLabel : UILabel = {
        var emailLabel = UILabel()
        emailLabel.text = "Last name:"
        emailLabel.textColor = .black
        emailLabel.font = .systemFont(ofSize: 15)
        return emailLabel
    }()
    
    private let emailTextField : UITextField = {
        var emailTextField = UITextField()
        emailTextField.layer.cornerRadius = 12
        emailTextField.layer.borderWidth = 1
        emailTextField.placeholder = "Enter your login..."
        emailTextField.layer.borderColor = UIColor.systemGray.cgColor
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        emailTextField.leftViewMode = .always
        return emailTextField
    }()
    
    private let passwordLabel : UILabel = {
        var passwordLabel = UILabel()
        passwordLabel.text = "Password:"
        passwordLabel.textColor = .black
        passwordLabel.font = .systemFont(ofSize: 15)
        return passwordLabel
    }()
    
    private let passwordTextField : UITextField = {
        var passwordTextField = UITextField()
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.layer.borderWidth = 1
        passwordTextField.placeholder = "Enter your password..."
        passwordTextField.layer.borderColor = UIColor.systemGray.cgColor
        passwordTextField.isSecureTextEntry = true
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passwordTextField.leftViewMode = .always
        return passwordTextField
    }()
    
    private let loginButton : UIButton = {
        let loginButton = UIButton()
        loginButton.layer.cornerRadius = 12
        loginButton.setTitle("Log in", for: .normal)
        loginButton.backgroundColor = .purple
        loginButton.titleLabel?.font = .systemFont(ofSize: 20)
        
        return loginButton
    }()
    
    private let registerButton : UIButton = {
        let registerButton = UIButton()
        registerButton.layer.cornerRadius = 12
        registerButton.backgroundColor = .white
        registerButton.titleLabel?.numberOfLines = 0
        registerButton.titleLabel?.lineBreakMode = .byWordWrapping
        let attributedString = NSAttributedString(string: NSLocalizedString("Don't you have an account yet? Register", comment: ""), attributes:[
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13),
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.underlineStyle:1.0
        ])
        registerButton.setAttributedTitle(attributedString, for: .normal)        
        return registerButton
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(emailLabel)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(passwordLabel)
        scrollView.addSubview(imageView)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(registerButton)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width/3
        imageView.frame = CGRect(x: (view.width - size)/2, y: 20, width: size, height: size)
        scrollView.frame = view.bounds
        emailLabel.frame = CGRect(x: 30, y: imageView.bottom + 5, width: scrollView.width-60, height: 15)
        emailTextField.frame = CGRect(x: 30, y: emailLabel.bottom + 10, width: scrollView.width-60, height: 40)
        passwordLabel.frame = CGRect(x: 30, y: emailTextField.bottom + 5, width: scrollView.width-60, height: 15)
        passwordTextField.frame = CGRect(x: 30, y: passwordLabel.bottom + 10, width: scrollView.width-60, height: 40)
        loginButton.frame = CGRect(x: 70, y: passwordTextField.bottom + 30, width: scrollView.width-140, height: 50)
        registerButton.frame = CGRect(x: 40, y: loginButton.bottom + 10, width: scrollView.width-80, height: 40)
        
    }
    
    @objc func loginButtonTapped() {
        guard let emailText = emailTextField.text,
              let passwordText = passwordTextField.text,
              !emailText.isEmpty else {
            self.alertLogin()
            return
        }
        guard passwordText.count >= 6 else {
            self.alertPassword()
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: emailText, password: passwordText) { [weak self] result, error in
            guard let self = self,
                  error == nil,
                  let result = result else {
                print("Error sign in")
                return
            }
            let user = result.user
            self.navigationController?.dismiss(animated: false)
        }
    }
    
    @objc func registerButtonTapped() {
        let vc = RegisterViewController()
        vc.title = "Create an account"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func alertLogin() {
        let alert = UIAlertController(title: "Error", message: "Please, enter your login", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel)
        alert.addAction(dismiss)
        present(alert, animated: true)
    }
    private func alertPassword() {
        let alert = UIAlertController(title: "Error", message: "The password must be at least 6 characters long", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel)
        alert.addAction(dismiss)
        present(alert, animated: true)
    }
    

    
}

extension LoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            loginButton.becomeFirstResponder()
        }
        return true
    }
    
}
