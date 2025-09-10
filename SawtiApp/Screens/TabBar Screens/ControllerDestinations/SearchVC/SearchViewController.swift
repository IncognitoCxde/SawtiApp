//
//  SearchViewController.swift
//  SawtiApp
//
//  Created by Ilmhona 10 on 01/11/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Variables
    
    let exploreTitle = UILabel()
    let searchBar = ATCTextField()
    let searchLogo = UIImageView()
    var collectionView: UICollectionView!
    
    let categories = ["Self-Enlightment", "Culture & Society", "Fiction", "Mind & Philosophy", "Education", "World History", "Tajik-Persian Poetry", "Tajik History", "Islamic", "Technology", "Non-Fiction", "Inspirational", "Action", "Other..."]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Milk")
        setUpUI()
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 8
        layout.estimatedItemSize = CGSize(width: categories.count, height: categories.count + 30)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchCategoryCell.self, forCellWithReuseIdentifier: SearchCategoryCell.identifier)
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.top).inset(95)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(280)
        }
    }
    
    func setUpUI() {
        configureNavTitle()
        configureLabel()
        configureSearchBar()
        setUpConstraints()
    }
    
    // MARK: - Navigation
    
    func configureNavTitle() {
        navigationItem.title = "صوتي"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(named: "Brown"),
                              NSAttributedString.Key.font: UIFont(name: "Inter24pt-ExtraBold", size: 24)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
    }
    
    // MARK: - Configuration
    
    func configureLabel() {
        exploreTitle.text = "Explore"
        exploreTitle.textColor = UIColor(named: "Dark")
        exploreTitle.font = UIFont(name: "Inter24pt-Bold", size: 18)
        view.addSubview(exploreTitle)
    }
    
    func configureSearchBar() {
        searchBar.placeholder = "Title, author or keyword"
        searchBar.backgroundColor = UIColor(named: "Light Green")
        searchBar.keyboardType = .default
        searchBar.borderStyle = .none
        searchBar.layer.cornerRadius = 15
        view.addSubview(searchBar)
        
        searchLogo.image = UIImage(systemName: "magnifyingglass")
        searchLogo.tintColor = UIColor(named: "Brown")
        view.addSubview(searchLogo)
    }
    
    // MARK: - Constraints
    
    func setUpConstraints() {
        exploreTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.left.equalToSuperview().inset(25)
        }
        
        searchBar.snp.makeConstraints{ make in
            make.top.equalTo(exploreTitle.snp.bottom).offset(15)
            make.right.equalTo(exploreTitle.snp.right).offset(285)
            make.width.equalTo(355)
            make.height.equalTo(55)
        }
        
        searchLogo.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.top).inset(20)
            make.left.equalTo(searchBar.snp.left).inset(15)
        }
    }
    
    // MARK: - Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCategoryCell.identifier, for: indexPath) as? SearchCategoryCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: categories[indexPath.item])
        return cell
    }
    
    // MARK: - Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = categories[indexPath.item]
        let font = UIFont(name: "Inter18pt-Bold", size: 12)
        let textWidth = text.size(withAttributes: [.font: font!]).width + 20
        return CGSize(width: textWidth, height: 20)
    }

}
