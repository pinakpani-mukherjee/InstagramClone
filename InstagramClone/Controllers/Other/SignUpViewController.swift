//
//  SignUpViewController.swift
//  InstagramClone
//
//  Created by Pinakpani Mukherjee on 2022/09/15.
//

import UIKit
import SafariServices
class SignUpViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Declare all of our sub views
    
    private let profilePictureImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .label
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 45
        return imageView
    }()
    private let usernameField:IGTextField = {
        let field = IGTextField()
        field.placeholder = "Username"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.returnKeyType = .next
        field.autocorrectionType = .no
        return field
    }()
    
    private let emailField:IGTextField = {
        let field = IGTextField()
        field.placeholder = "Email Address"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.autocorrectionType = .no
        return field
    }()
    
    private let passwordField:IGTextField = {
        let field = IGTextField()
        field.placeholder = "Create Password"
        field.isSecureTextEntry = true
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no

        return field
    }()
    
    private let passwordCheckField:IGTextField = {
        let field = IGTextField()
        field.placeholder = "Retype Password"
        field.isSecureTextEntry = true
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no

        return field
    }()
    
    private let signUpButton:UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let termsButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Terms of Service", for: .normal)
        return button
    }()
    
    private let privacyButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Privacy Policy", for: .normal)
        return button
    }()
    
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.

        title = "Create Account"
        view.backgroundColor = .secondarySystemBackground
        addSubViews()
        emailField.delegate = self
        usernameField.delegate = self
        passwordField.delegate = self
        addButtonActions()
        addImageGesture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageSize: CGFloat = 110
        
        profilePictureImageView.frame = CGRect(x: (view.width - imageSize)/2,
                                  y: view.safeAreaInsets.top + 15,
                                  width: imageSize,
                                  height: imageSize)
        emailField.frame = CGRect(x: 25, y: profilePictureImageView.bottom + 20, width: view.width - 50, height: 50)
        emailField.frame = CGRect(x: 25, y: emailField.bottom + 20, width: view.width - 50, height: 50)
        passwordField.frame = CGRect(x: 25, y: emailField.bottom + 10, width: view.width - 50, height: 50)
        passwordCheckField.frame = CGRect(x: 25, y: passwordField.bottom + 10, width: view.width - 50, height: 50)
        signUpButton.frame = CGRect(x: 35, y: passwordCheckField.bottom + 20, width: view.width - 70, height: 50)

        termsButton.frame = CGRect(x: 35, y: signUpButton.bottom + 70, width: view.width - 70, height: 40)
        privacyButton.frame = CGRect(x: 35, y: termsButton.bottom + 10, width: view.width - 70, height: 40)
    }
    
    private func addSubViews(){
        view.addSubview(profilePictureImageView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(passwordCheckField)
        view.addSubview(signUpButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }
    
    private func addImageGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        profilePictureImageView.isUserInteractionEnabled = true
        profilePictureImageView.addGestureRecognizer(tap)
    }
    
    private func addButtonActions(){
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTerms), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacy), for: .touchUpInside)
    }

    //MARK: - Actions
    
    @objc func didTapImage(){
        let sheet = UIAlertController(title: "Profile Picture", message: "Set a picture to help your friends find you.", preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _
            in
            DispatchQueue.main.async {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.allowsEditing = true
                picker.delegate = self
                self?.present(picker,animated: true)
            }
        }))
        sheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _
            in
            DispatchQueue.main.async {
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.allowsEditing = true
                picker.delegate = self
                self?.present(picker,animated: true)
            }
        }))
        present(sheet,animated: true)
    }
    
    
    
    
    @objc func didTapSignUp(){
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let email = emailField.text,
              let password = passwordField.text,
              let passwordCheck = passwordCheckField.text,
              let username = usernameField.text,
              !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !username.trimmingCharacters(in: .alphanumerics).isEmpty,
              !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !passwordCheck.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              password.count > 6,
              password == passwordCheck else{
                  presentGeneralError(title: "Whoops", message: "Please fill the fields properly.")
                  return
                }
        
        //Sign in with auth Manager
        signIn()
    }
    private func presentGeneralError(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel,handler: nil))
        present(alert,animated: true)
    }
    
    @objc func didTapTerms(){
        guard let url = URL(string: "https://www.instagram.com") else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc func didTapPrivacy(){
        guard let url = URL(string: "https://www.instagram.com") else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    private func signIn(){
        
    }
    
    
    //MARK: - Field Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField{
            emailField.becomeFirstResponder()
        }
        else if textField == emailField{
            passwordField.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
            didTapSignUp()
        }
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Image Picker Function
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        profilePictureImageView.image = image
    }

}
