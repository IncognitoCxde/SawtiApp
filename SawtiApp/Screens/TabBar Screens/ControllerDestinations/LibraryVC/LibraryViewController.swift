//
//  LibraryViewController.swift
//  SawtiApp
//
//  Created by Ilmhona 10 on 01/11/24.
//

import UIKit

class LibraryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Variables
    
    let yourBooksTitle = UILabel()
    let moreButton = UIButton()
    let settingsButton = UIButton()
    
    var bookImages: [UIImage] = [
        UIImage(named: "Sahih")!,
        UIImage(named: "1984")!,
        UIImage(named: "Tajiks")!,
        UIImage(named: "Kafka")!,
        UIImage(named: "451")!,
        UIImage(named: "farsi")!,
        UIImage(named: "arabs")!,
        UIImage(named: "hungerGames")!,
        UIImage(named: "hundredyear")!,
    ]
    
    var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Milk")
        setUpUI()
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 12
        layout.estimatedItemSize = CGSize(width: 130, height: 180)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BookCategoryCell.self, forCellWithReuseIdentifier: BookCategoryCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(220)
            make.left.equalTo(yourBooksTitle.snp.left).inset(4)
            make.right.equalTo(settingsButton.snp.left).inset(35)
        }
    }
    
    // MARK: - UI
    
    func setUpUI() {
        configureNavTitle()
        configureTitles()
        configureButtons()
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
    
    func configureTitles() {
        yourBooksTitle.text = "Your Library"
        yourBooksTitle.textColor = UIColor(named: "Dark")
        yourBooksTitle.font = UIFont(name: "Inter24pt-Bold", size: 18)
        view.addSubview(yourBooksTitle)
    }
    
    func configureButtons() {
        moreButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        moreButton.tintColor = UIColor(named: "Brown")
        
        view.addSubview(moreButton)
        
        settingsButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        settingsButton.tintColor = UIColor(named: "Brown")
        
        view.addSubview(settingsButton)
    }
    
    // MARK: - Constraints
    
    func setUpConstraints() {
        yourBooksTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(170)
            make.left.equalToSuperview().inset(30)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.equalToSuperview().inset(20)
            make.width.height.equalTo(50)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.right.equalToSuperview().inset(20)
            make.width.height.equalTo(50)
        }
    }
    
    // MARK: - UICollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCategoryCell.identifier, for: indexPath) as! BookCategoryCell
        let image = bookImages[indexPath.item]
        cell.bookImageView.image = image
        return cell
    }
    

}
