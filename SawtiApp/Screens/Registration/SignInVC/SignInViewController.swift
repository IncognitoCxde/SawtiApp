//
//  SignInViewController.swift
//  SawtiApp
//
//  Created by Ilmhona 10 on 20/11/24.
//

import UIKit
import SnapKit

class SignInViewController: UIViewController {
    
    // MARK: - UI
    let colorBrown = UIColor(named: "Brown")
    
    // Title
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In"
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
        textField.placeholder = "your-email@example.com"
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
        toggleButton.addTarget(SignInViewController.self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
//        toggleButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)

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
        button.addTarget(SignInViewController.self, action: #selector(signButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Milk")
        setupUI()
    }
    
    // MARK: - Constraints
    func setupUI() {
        // Title
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(170)
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
    
    // MARK: - Action
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    @objc func signButtonTapped() {
        guard let email = emailTextField.text, isValidEmail(email) else {
            showAlert(message: "Please enter a valid email.")
            return
        }
        guard let password = passwordTextField.text, password.count >= 6 else {
            showAlert(message: "Password should be at least 6 characters.")
            return
        }
        // Check user data
        authenticateUser(email: email, password: password)
    }

    // User authentication logic
    func authenticateUser(email: String, password: String) {
        if email == "afsanaK@icloud.com" && password == "icode2024" {
            let mainVC = MainViewController()
            navigationController?.pushViewController(mainVC, animated: true)
        } else {
            showAlert(message: "Invalid email or password.")
        }
    }

}
