import UIKit
import SnapKit

class BookCollectionViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    let firstImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let secondImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let thirdImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let forthImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(firstImageView)
        contentView.addSubview(secondImageView)
        contentView.addSubview(thirdImageView)
        contentView.addSubview(forthImageView)
        
        selectionStyle = .none
        
        let imageHeight: CGFloat = 150
        
// MARK: - Constraints for images
        firstImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).inset(20)
            make.width.equalTo(100)
            make.height.equalTo(imageHeight)
        }
        
        secondImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.centerX.equalTo(contentView)
            make.width.equalTo(100)
            make.height.equalTo(imageHeight)
        }
        
        thirdImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).inset(20)
            make.width.equalTo(100)
            make.height.equalTo(imageHeight)
        }
        
        forthImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).inset(20)
            make.width.equalTo(100)
            make.height.equalTo(imageHeight)
        }
    }

    func setup(with books: [ProfileModel.Book]) {
        firstImageView.image = nil
        secondImageView.image = nil
        thirdImageView.image = nil
        
        if books.count > 0 {
            firstImageView.image = UIImage(named: books[0].imageNames.first ?? "")
        }
        if books.count > 1 {
            secondImageView.image = UIImage(named: books[1].imageNames.first ?? "")
        }
        if books.count > 2 {
            thirdImageView.image = UIImage(named: books[2].imageNames.first ?? "")
        }
        if books.count > 3 {
            thirdImageView.image = UIImage(named: books[2].imageNames.first ?? "")
        }
    }
}

