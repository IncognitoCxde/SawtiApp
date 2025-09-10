import UIKit
import SnapKit

class CategoryHeaderView: UITableViewHeaderFooterView {
    
    var onSelectAll: (() -> Void)?
    
    // MARK: - UI Elements
    private let titleLabel = UILabel()
    private let seeAllButton = UIButton()
    
    // MARK: - Properties
    var categoryName: String? {
        didSet {
            titleLabel.text = categoryName
        }
    }
    
    // MARK: - Initializer
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup with SnapKit
    private func setupUI() {
        // Set up titleLabel
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Set up seeAllButton
        seeAllButton.setTitle("See All", for: .normal)
        seeAllButton.setTitleColor(.gray, for: .normal)
        seeAllButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        seeAllButton.addTarget(self, action: #selector(didTapSeeAll), for: .touchUpInside)
        
        // Add subviews
        addSubview(titleLabel)
        addSubview(seeAllButton)
        
        // Layout constraints using SnapKit
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Action
    @objc private func didTapSeeAll() {
        onSelectAll?()
    }
}
