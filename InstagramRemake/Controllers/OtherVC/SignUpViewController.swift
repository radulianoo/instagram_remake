//
//  SignUpViewController.swift
//  InstagramRemake
//
//  Created by Octav Radulian on 22.03.2023.
//

import UIKit
import SafariServices

//for signup our user

class SignUpViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //create subviews
    private let profilePictureImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .lightGray
        image.image = UIImage(systemName: "person.circle")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 45
        return image
    }()
    
    
    private let emailField: IGTextField = {
        let field = IGTextField()
        field.placeholder = "Email address"
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.autocorrectionType = .no
        return field
    }()
    
    private let usernameField: IGTextField = {
        let field = IGTextField()
        field.placeholder = "Username"
        field.keyboardType = .default
        field.returnKeyType = .next
        field.autocorrectionType = .no
        return field
    }()
    
    private let passwordField: IGTextField = {
        let field = IGTextField()
        field.placeholder = "Create password"
        field.isSecureTextEntry = true
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        return field
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
   
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Terms & Conditions", for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Privacy", for: .normal)
        return button
    }()
    
    public var completion: (() -> Void)?
    
    //MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create account"
        view.backgroundColor = .systemBackground
        
        addSubviews()
        emailField.delegate = self
        usernameField.delegate = self
        passwordField.delegate = self
        addButtonActions()
        addImageGesture()
        
    }
    
    //create the gradient as an independent view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageSize: CGFloat = 90
        
        profilePictureImageView.frame = CGRect(
            x: (view.width - imageSize)/2,
            y: view.safeAreaInsets.top + 15,
            width: imageSize,
            height: imageSize
            
        )
        emailField.frame = CGRect(x: 25, y: profilePictureImageView.bottom + 20, width: view.width - 50, height: 50)
        usernameField.frame = CGRect(x: 25, y: emailField.bottom + 10, width: view.width - 50, height: 50)
        passwordField.frame = CGRect(x: 25, y: usernameField.bottom + 10, width: view.width - 50, height: 50)
        
        signUpButton.frame = CGRect(x: 25, y: passwordField.bottom + 20, width: view.width - 50, height: 50)
        
        termsButton.frame = CGRect(x: 25, y: signUpButton.bottom + 50, width: view.width - 50, height: 50)
        privacyButton.frame = CGRect(x: 25, y: termsButton.bottom + 10, width: view.width - 50, height: 50)
    }
    
    private func addSubviews() {
        view.addSubview(profilePictureImageView)
        view.addSubview(emailField)
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(signUpButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }
    
    private func addButtonActions() {
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTerms), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacy), for: .touchUpInside)
    }
    
    private func addImageGesture() {
        //adding image gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        profilePictureImageView.isUserInteractionEnabled = true
        profilePictureImageView.addGestureRecognizer(tap)
        
    }
    
    //MARK: - Actions
    
    @objc func didTapSignUp() {
        
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let username = usernameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6,
              username.trimmingCharacters(in: .alphanumerics).isEmpty,
              username.count >= 2
        else {
            presentError()
            return
        }
        
        let data = profilePictureImageView.image?.pngData()
        
        //sign up with auth manager
        print("create account operation started")
        AuthManager.shared.signUp(
            email: email,
            username: username,
            password: password,
            profilePicture: data) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let user):
                        //saving info
                        UserDefaults.standard.set(user.email, forKey: "email")
                        UserDefaults.standard.set(user.username, forKey: "username")
                        
                        self?.navigationController?.popToRootViewController(animated: true)
                        self?.completion?()
                    case .failure(let error):
                        print("\n\nSign Up Error: \(error)")
                    }
                }
            }
    }
   
    private func presentError() {
        let alert = UIAlertController(title: "Woops", message: "Please make sure to fill all fields and have a password longer than 6 characters", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc func didTapTerms() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870/?helpref=hc_fnav") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc func didTapPrivacy() {
        guard let url = URL(string: "https://help.instagram.com/196883487377501/?helpref=hc_fnav") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc func didTapImage() {
        //show action sheet
        let sheet = UIAlertController(title: "Profile Picture",
                                      message: "Set a picture to help your friends find you",
                                      preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        sheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            DispatchQueue.main.async {
                let picker = UIImagePickerController()
                picker.allowsEditing = true
                picker.sourceType = .camera
                picker.delegate = self
                self?.present(picker, animated: true)
            }
        }))
        sheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _ in
            DispatchQueue.main.async {
                let picker = UIImagePickerController()
                picker.allowsEditing = true
                picker.sourceType = .photoLibrary
                picker.delegate = self
                self?.present(picker, animated: true)
            }
        }))
        
        present(sheet, animated: true)
    }

    //MARK: - Field Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        }
        else if textField == passwordField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            didTapSignUp()
        }
        
        return true
    }
    
    //MARK: - Image Picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        profilePictureImageView.image = image
    }
}
