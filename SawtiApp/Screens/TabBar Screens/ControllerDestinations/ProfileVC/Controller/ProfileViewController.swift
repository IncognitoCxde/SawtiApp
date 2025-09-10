//
//  ProfileViewController.swift
//  SawtiApp
//
//  Created by Ilmhona 10 on 01/11/24.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    // MARK: - UI Elements
    
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let userLabel = UILabel()
    
    var notificationButton = UIButton()
//    var notificationPopup: UIView!

    var settingButton = UIButton()
    
    
    // MARK: - Collection
    
    var categoryCollectionView: UICollectionView!
    var booksCollectionView: UICollectionView!
    
    // MARK: - Table
    
    var tableView: UITableView!
    
    // MARK: - Filter
    
    var filteredCategories: [ProfileModel.Category] = []
    
    // MARK: - Model
    
    var model: ProfileModel
    
    // MARK: - Initializer
    
    init(model: ProfileModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.model = ProfileModel()
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Milk")
        
        filteredCategories = model.categories.filter { category in
            return !category.books.isEmpty
        }
        
        setupNavigationTitle()
        setupProfile()
        setupTableView()
        setupCategoryCollectionView()
        setupbooksCollectionView()
//        setupNotificationsPopup()
        setupConstraints()
    }
    
    // MARK: - Navigation
    
    func setupNavigationTitle() {
        navigationItem.title = "صوتي"
        
        if let customFont = UIFont(name: "Inter24pt-ExtraBold", size: 24) {
            let textAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(named: "Brown") ?? UIColor.brown,
                .font: customFont
            ]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        } else {
            print("Font 'Inter24pt-ExtraBold' not found")
        }
    }
    
    // MARK: - Profile Setup
    
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
        
        // Setup Notification Button
        notificationButton = UIButton(type: .custom)
        notificationButton.setImage(UIImage(systemName: "bell.badge"), for: .normal)
        notificationButton.tintColor = UIColor(named: "Brown")
        notificationButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        view.addSubview(notificationButton)
        
        // Setup Setting Button
        settingButton = UIButton(type: .custom)
        settingButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        settingButton.tintColor = UIColor(named: "Brown")
        settingButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        view.addSubview(settingButton)
    }
    
   
    
    // MARK: - TableView Setup
    func setupTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(named: "Milk")
        tableView.register(CategoryHeaderView.self, forHeaderFooterViewReuseIdentifier: "CategoryHeaderView")
        
        
        tableView.register(BookCollectionViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        view.addSubview(tableView)
    }
    
    // MARK: - Category CollectionView Setup
    
    func setupCategoryCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        layout.itemSize = CGSize(width: 120, height: 35)
        
        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.showsHorizontalScrollIndicator = false
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "categoryCell")
        categoryCollectionView.backgroundColor = UIColor(named: "Milk")
        view.addSubview(categoryCollectionView)
        
    }
    
    // MARK: - Books CollectionView Setup
    
    func setupbooksCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        layout.itemSize = CGSize(width: 120, height: 30)
        
        booksCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        booksCollectionView.delegate = self
        booksCollectionView.dataSource = self
        booksCollectionView.showsHorizontalScrollIndicator = false
        booksCollectionView.backgroundColor = UIColor(named: "Milk")
        view.addSubview(booksCollectionView)
        
    }
    
    // MARK: - Setup Setting PopUp
    
//    func setupNotificationsPopup() {
//        notificationPopup = UIView()
//        notificationPopup.backgroundColor = UIColor(white: 1, alpha: 0.9) /*UIColor(named: "Milk")*/
//        notificationPopup.layer.cornerRadius = 12
//        notificationPopup.layer.shadowOpacity = 0.3
//        notificationPopup.layer.shadowRadius = 5
//        notificationPopup.layer.shadowOffset = CGSize(width: 0, height: 2)
//        notificationPopup.alpha = 0
//        
//        let notificationSwitch = UISwitch()
//        notificationSwitch.onTintColor = .green
//        notificationPopup.addSubview(notificationSwitch)
//        
//        let natificationLabel = UILabel()
//        natificationLabel.text = "Turn on notifications"
//        natificationLabel.textColor = UIColor(named: "Dark")
//        notificationPopup.addSubview(natificationLabel)
//        
//        let closeButton = UIButton(type: .system)
//        closeButton.setTitle("Close", for: .normal)
//        closeButton.tintColor = UIColor(named: "Dark")
//        closeButton.addTarget(self, action: #selector(closeNotificationsPopup), for: .touchUpInside)
//        notificationPopup.addSubview(closeButton)
//        
//        self.view.addSubview(notificationPopup)
//        
//        notificationPopup.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.width.equalTo(self.view.frame.width - 100)
//            make.height.equalTo(150)
//        }
//        
//        notificationSwitch.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(70)
//            make.left.equalToSuperview().offset(20)
//        }
//        
//        natificationLabel.snp.makeConstraints { make in
//            make.centerY.equalTo(notificationSwitch)
//            make.left.equalTo(notificationSwitch.snp.right).offset(10)
//        }
//        
//        closeButton.snp.makeConstraints { make in
//            make.top.equalTo(notificationPopup.snp.top).offset(10)
//            make.right.equalTo(notificationPopup.snp.right).offset(-10)
//            make.width.equalTo(80)
//            make.height.equalTo(40)
//        }
//    }
    
    // MARK: - Constraints Setup
    
    func setupConstraints() {
        // Setup Image profile
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(140)
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
        
        // Setup Setting Button
        settingButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.right.equalToSuperview().inset(20)
            make.width.height.equalTo(50)
        }
        
        // Setup Notification Button
        notificationButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.right.equalTo(settingButton.snp.left).offset(10)
            make.width.height.equalTo(50)
        }
        
        // Setup Category Collection
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        
        // Setup TableView Constraints
        tableView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Setup Notification PopUp
    
    @objc func logoutTapped() {
        // Создаем UIAlertController
        let alertController = UIAlertController(title: "Notification", message: "Here you can turn on notifications!", preferredStyle: .alert)

        // Создаем UISwitch
        let switchControl = UISwitch()
        switchControl.isOn = false
        
        // Создаем UIStackView для размещения элементов
        let stackView = UIStackView(arrangedSubviews: [switchControl])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Добавляем stackView в alertController
        alertController.view.addSubview(stackView)

        // Настроим констрейнты для stackView
        stackView.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 70).isActive = true
        stackView.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor).isActive = true

        // Увеличиваем высоту alertController
        let heightConstraint = NSLayoutConstraint(item: alertController.view!,
                                                   attribute: .height,
                                                   relatedBy: .greaterThanOrEqual,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1.0,
                                                   constant: 150) // Установите нужную высоту
        alertController.view.addConstraint(heightConstraint)

        // Добавляем кнопку Cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        // Показываем alert
        present(alertController, animated: true, completion: nil)
    }


    
    // MARK: - Actions
    @objc func settingsTapped() {
        let svc = SettingsViewController()
        let nc = UINavigationController(rootViewController: svc)
        
        present(nc, animated: true)
    }

}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredCategories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BookCollectionViewCell
        let category = filteredCategories[indexPath.section]
        let books = category.books
        let booksToDisplay = Array(books.prefix(3))
        cell.setup(with: booksToDisplay)
        
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CategoryHeaderView") as! CategoryHeaderView
        let category = filteredCategories[section]
        headerView.categoryName = category.name
        headerView.onSelectAll = { [weak self] in
            guard let self = self else {
                return
            }
            self.navigateToLibrary()
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func navigateToLibrary() {
        tabBarController?.selectedIndex = 1
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        let category = model.categories[indexPath.item]
        cell.setup(with: category.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = model.categories[indexPath.item]
        
        if selectedCategory.books.isEmpty {
            let alert = UIAlertController(title: "Нет книг", message: "В этой категории нет доступных книг.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
            filteredCategories = []
        } else {
            filteredCategories = [selectedCategory]
        }
        tableView.reloadData()
    }
    
}


