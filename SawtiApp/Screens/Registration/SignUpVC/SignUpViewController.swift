//
//  SignUpViewController.swift
//  SawtiApp
//
//  Created by Ilmhona 10 on 20/11/24.
//

import UIKit
import SnapKit
import AuthenticationServices

class SignUpViewController: UIViewController {
    
    var onSuccessSignUp: ((Bool) -> Void)?
    
    // MARK: - UI
    let colorBrown = UIColor(named: "Brown")
    
    // Image Logo
    
    let logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        return logo
    }()
    
    // Title
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In To Your Account"
        label.textColor = UIColor(named: "Dark")
        label.font = UIFont(name: "Inter24pt-ExtraBold", size: 25)
        return label
    }()
    
    // Email
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "E-mail"
        label.textColor = UIColor(named: "Dark")
        label.font = UIFont(name: "Inter24pt-ExtraBold", size: 12)
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.placeholder = "yourEmail@example.com"
        textField.backgroundColor = UIColor(named: "Light Green")
        textField.layer.cornerRadius = 15
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(named: "UI Green")?.cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    // Password
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = UIColor(named: "Dark")
        label.font = UIFont(name: "Inter24pt-ExtraBold", size: 12)
        return label
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "***************"
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(named: "Light Green")
        textField.layer.cornerRadius = 15
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(named: "UI Green")?.cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        let toggleButton = UIButton(type: .custom)
        toggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        toggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        toggleButton.tintColor = UIColor(named: "UI Green")
        toggleButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        toggleButton.contentMode = .scaleAspectFit
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        toggleButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)

        textField.rightView = toggleButton
        textField.rightViewMode = .always
        
        
        return textField
    }()
    
    // Sign Up Button
    let signButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor(named: "Milk"), for: .normal)
        button.backgroundColor = UIColor(named: "Brown")
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "Dark")?.cgColor
        button.addTarget(self, action: #selector(signButtonTapped), for: .touchUpInside)
        return button
    }()
    
//    apple button

    var appleButton: UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "apple"), for: .normal)
        button.addTarget(self, action: #selector(signButtonTapped), for: .touchUpInside)
        return button
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Milk")
        setupUI()
        setupNavigationBar()
    }
    
    // MARK: - Setup Navigation Bar with Custom Back Button
    func setupNavigationBar() {
        if let brownColor = UIColor(named: "Brown") {
            navigationController?.navigationBar.tintColor = brownColor
        } else {
            navigationController?.navigationBar.tintColor = .brown
        }
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    
    // MARK: - Constraints
    func setupUI() {
        
        // image
        
        view.addSubview(logoImage)
        
        logoImage.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.top.equalToSuperview().inset(80)
            make.leading.equalToSuperview().inset(100)
        }
        
        // Title
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }

        // Email
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }

        // Password
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }

        // Sign Up Button
        view.addSubview(signButton)
        signButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    // MARK: Action
    
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
    
    @objc func signButtonTapped() {
        
//        guard let name = nameTextField.text, !name.isEmpty else {
//            showAlert(message: "Please enter your name.")
//            return
//        }
        guard let email = emailTextField.text, isValidEmail(email) else {
            showAlert(message: "Please enter a valid email.")
            return
        }
        guard let password = passwordTextField.text, password.count >= 6 else {
            showAlert(message: "Password should be at least 6 characters.")
            return
        }
        registerUser(email: email, password: password)
    }

    // checking email
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    // show Alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))  // Не переходим на другой экран
        present(alert, animated: true)
    }

    //  User registration logic
    func registerUser(email: String, password: String) {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            let tabBarController = TabBarController()
            window.rootViewController = tabBarController
        }
    }
}
