


import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
                
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with name: String) {
        label.text = name
        label.textAlignment = .center
        label.backgroundColor = UIColor(named: "UI Green")
        label.layer.borderColor = UIColor(named: "Gray")?.cgColor
        label.layer.borderWidth = 0.2
        label.textColor = UIColor(named: "Dark")
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        label.font = UIFont(name: "Inter18pt-Bold", size: 15)
    }
}

