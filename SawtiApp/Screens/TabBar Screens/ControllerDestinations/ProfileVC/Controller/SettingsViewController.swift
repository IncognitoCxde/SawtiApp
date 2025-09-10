import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    // MARK: - UI
    let titleLabel = UILabel()
    
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let userLabel = UILabel()
    
    let changePasswordButton = UIButton(type: .system)
    let logoutButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        // background
        view.backgroundColor = UIColor(named: "Milk")
        // func
        setupProfile()
        setupSetting()
    }
    
    func setupProfile() {
        // Setup Image profile
        profileImageView.image = UIImage(named: "profile")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 35
        view.addSubview(profileImageView)
        
        // Setup Name
        nameLabel.text = "Afsana Khorasani"
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        nameLabel.textColor = UIColor(named: "Dark")
        view.addSubview(nameLabel)
        
        // Setup Username
        userLabel.text = "@afsanakhorasani"
        userLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        userLabel.textColor = UIColor(named: "Dark")
        view.addSubview(userLabel)
    }
    
    func setupSetting(){
        // Title
        titleLabel.text = "Settings"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = UIColor(named: "Dark")
        view.addSubview(titleLabel)
        
        // Change Password
        changePasswordButton.setTitle("Change password", for: .normal)
        changePasswordButton.addTarget(self, action: #selector(changePasswordTapped), for: .touchUpInside)
        view.addSubview(changePasswordButton)
        
        // Sign out
        logoutButton.setTitle("Log out of your account", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        view.addSubview(logoutButton)
        
        let separator1 = UIView()
        separator1.backgroundColor = UIColor(named: "Brown")
        view.addSubview(separator1)
        
        let separator2 = UIView()
        separator2.backgroundColor = UIColor(named: "Brown")
        view.addSubview(separator2)
        
        let separator3 = UIView()
        separator3.backgroundColor = UIColor(named: "Brown")
        view.addSubview(separator3)
        
        // Constraints
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        separator1.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(1)
        }
        
        // Setup Image profile
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(separator1.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
            make.width.height.equalTo(70)
        }
        
        // Setup Name
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.centerY).inset(20)
            make.left.equalTo(profileImageView.snp.right).offset(20)
        }
        
        // Setup Username
        userLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalTo(profileImageView.snp.right).offset(20)
        }
        
        separator2.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(1)
        }
        
        changePasswordButton.snp.makeConstraints { make in
            make.top.equalTo(separator2.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }
        
        separator3.snp.makeConstraints { make in
            make.top.equalTo(changePasswordButton.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(1)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(separator3.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }
        
       
    }
    // MARK: - Actions
    
    @objc func changePasswordTapped() {
        let alertController = UIAlertController(title: "Change password", message: "Enter new password", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "New Password"
            textField.isSecureTextEntry = true
        }
        
        let confirmAction = UIAlertAction(title: "Change", style: .default) { _ in
            if let newPassword = alertController.textFields?.first?.text, !newPassword.isEmpty {
                print("New Password: \(newPassword)")
                self.showSuccessAlert(message: "The password has been successfully changed. ")
            } else {
                self.showErrorAlert(message: "The password cannot be empty. ")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func logoutTapped() {
        let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to log out?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Log out", style: .destructive) { _ in
            print("User logged out")
            self.updateProfileToLoggedOutState()
            self.showSuccessAlert(message: "You have successfully logged out.")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Helper Methods
    
    func updateProfileToLoggedOutState() {
        profileImageView.image = UIImage(named: "unknown") 
        nameLabel.text = "Unknown"
        userLabel.text = "unknown@mail.com"
    }
    
    // success
    func showSuccessAlert(message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    // error
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
