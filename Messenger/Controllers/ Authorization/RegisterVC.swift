//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Валентина Евдокимова on 16.10.2022.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class RegisterViewController: UIViewController {

    private let scrollView : UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.tintColor = .black
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.width/2
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        return imageView
    }()
    
    private let nameLabel : UILabel = {
        var nameLabel = UILabel()
        nameLabel.text = "Name:"
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 15)
        return nameLabel
    }()
    
    private let nameTextField : UITextField = {
        var nameTextField = UITextField()
        nameTextField.layer.cornerRadius = 12
        nameTextField.layer.borderWidth = 1
        nameTextField.placeholder = "Enter your first name..."
        nameTextField.layer.borderColor = UIColor.systemGray.cgColor
        nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        nameTextField.leftViewMode = .always
        return nameTextField
    }()
    
    
    private let lastnameLabel : UILabel = {
        var nameLabel = UILabel()
        nameLabel.text = "Last name:"
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 15)
        return nameLabel
    }()
    
    private let lastnameTextField : UITextField = {
        var lastnameTextField = UITextField()
        lastnameTextField.layer.cornerRadius = 12
        lastnameTextField.layer.borderWidth = 1
        lastnameTextField.placeholder = "Enter your last name..."
        lastnameTextField.layer.borderColor = UIColor.systemGray.cgColor
        lastnameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        lastnameTextField.leftViewMode = .always
        return lastnameTextField
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
        emailTextField.placeholder = "Email:"
        emailTextField.layer.borderColor = UIColor.systemGray.cgColor
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
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
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        passwordTextField.leftViewMode = .always
        return passwordTextField
    }()
    
    private let registerButton : UIButton = {
        let registerButton = UIButton()
        registerButton.layer.cornerRadius = 12
        registerButton.setTitle("Create an account", for: .normal)
        registerButton.backgroundColor = .systemGreen
        registerButton.titleLabel?.font = .systemFont(ofSize: 20)
        return registerButton
    }()
    
    private let spinner = JGProgressHUD(style: .dark)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(lastnameLabel)
        scrollView.addSubview(lastnameTextField)
        scrollView.addSubview(emailLabel)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordLabel)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(imageView)
        scrollView.addSubview(registerButton)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(createProfilePicture))
        imageView.addGestureRecognizer(gesture)
        
        scrollView.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
        
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width/3
        imageView.frame = CGRect(x: (view.width - size)/2, y: 20, width: size, height: size)
        scrollView.frame = view.bounds
        
        nameLabel.frame = CGRect(x: 30, y: imageView.bottom + 5, width: scrollView.width-60, height: 15)
        nameTextField.frame = CGRect(x: 30, y: nameLabel.bottom + 5, width: scrollView.width-60, height: 30)
        
        lastnameLabel.frame = CGRect(x: 30, y: nameTextField.bottom + 5, width: scrollView.width-60, height: 15)
        lastnameTextField.frame = CGRect(x: 30, y: lastnameLabel.bottom + 10, width: scrollView.width-60, height: 30)
        
        emailLabel.frame = CGRect(x: 30, y: lastnameTextField.bottom + 5, width: scrollView.width-60, height: 15)
        emailTextField.frame = CGRect(x: 30, y: emailLabel.bottom + 10, width: scrollView.width-60, height: 30)
        
        passwordLabel.frame = CGRect(x: 30, y: emailTextField.bottom + 5, width: scrollView.width-60, height: 15)
        passwordTextField.frame = CGRect(x: 30, y: passwordLabel.bottom + 10, width: scrollView.width-60, height: 30)
        
        registerButton.frame = CGRect(x: 70, y: passwordTextField.bottom + 30, width: scrollView.width-140, height: 40)
        
    }
    
    @objc private func registerButtonTapped() {
        guard let nameText = nameTextField.text,
              let lastnameText = lastnameTextField.text,
              let emailText = emailTextField.text,
              let passwordText = passwordTextField.text,
              !emailText.isEmpty,
              !nameText.isEmpty,
              !lastnameText.isEmpty else {
            self.alertLogin()
            return
        }
        guard passwordText.count >= 6 else {
            self.alertPassword()
            return
        }
        spinner.show(in: view)
        DatabaseManager.shared.checkIfEmailExists(email: emailText) { [weak self] exists in
            guard let self = self else { return }
            guard !exists else {
                let alert = UIAlertController(title: "Error", message: "The user with this email already exists.", preferredStyle: .alert)
                self.present(alert, animated: true)
                return
            }
            DispatchQueue.main.async {
                self.spinner.dismiss()
            }
            
            FirebaseAuth.Auth.auth().createUser(withEmail: emailText, password: passwordText) { result, error in
                guard error == nil,
                      result != nil else {
                    print("Can't create user")
                    return
                }
                DatabaseManager.shared.inserUserInDatabase(user: User(name: nameText, lastname: lastnameText, email: emailText))
            }
        }
        
        
    }
    
    @objc private func createProfilePicture() {
        
        let alert = UIAlertController(title: "Select a photo", message: nil, preferredStyle: .actionSheet)
        let takePhoto = UIAlertAction(title: "Camera", style: .default) { _ in
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.delegate = self
            vc.allowsEditing = true
            self.present(vc, animated: true)
        }
        let openPhotoLibrary = UIAlertAction(title: "Photo Library", style: .default) { _ in
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.delegate = self
            vc.allowsEditing = true
            self.present(vc, animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(takePhoto)
        alert.addAction(openPhotoLibrary)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    private func alertLogin() {
        let alert = UIAlertController(title: "Error", message: "Please, enter all the information to register a new account", preferredStyle: .alert)
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

extension RegisterViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            registerButton.becomeFirstResponder()
        }
        return true
    }
    
}

extension RegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let selectedPhoto = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        self.imageView.image = selectedPhoto
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

