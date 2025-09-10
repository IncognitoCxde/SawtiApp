//
//  BookCategoryCell.swift
//  SawtiApp
//
//  Created by Ilmhona 10 on 15/11/24.
//

import UIKit

class BookCategoryCell: UICollectionViewCell {
    
    static let identifier = "BookCategoryCell"
    
    var bookImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        bookImageView = UIImageView(frame: self.contentView.bounds)
        bookImageView.contentMode = .scaleAspectFill
        bookImageView.clipsToBounds = true
        bookImageView.layer.cornerRadius = 10
        self.contentView.addSubview(bookImageView)
    }
}
