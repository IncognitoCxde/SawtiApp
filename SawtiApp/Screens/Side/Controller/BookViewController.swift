//
//  BookViewController.swift
//  SawtiApp
//
//  Created by Ilmhona 10 on 18/11/24.
//

import UIKit
import SnapKit

class BookViewController: UIViewController {

    // MARK: - UI
    
    var menuButton = UIButton()
    let backgroundView = UIView()
    var bookImageView = UIImageView()
    let bookNameLabel = UILabel()
    let authorLabel = UILabel()
    var ratingButtons: [UIButton] = []
    let descriptionLabel = UILabel()
    let listenButton = UIButton()
    let readButton = UIButton()

    var currentRating: Int = 0

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Milk")
        configureNavigationBarAppearance()
        setUpUI()

    }
    
    // MARK: - Bar Button
    
    private func configureNavigationBarAppearance() {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "arrow.left")
        button.tintColor = UIColor(named: "Brown")
        navigationController?.navigationItem.backButtonTitle = ""
        navigationController?.navigationItem.backBarButtonItem = button
    }

    
    // MARK: - UI

    func setUpUI() {
        setupBackgroundView()
        setupUI()
        setupButton()
        setupRatingButtons()
        configureNavTitle()
    }

    // MARK: - Navigation

    func configureNavTitle() {
        navigationItem.title = "صوتي"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(named: "Brown"),
                              NSAttributedString.Key.font: UIFont(name: "Inter24pt-ExtraBold", size: 24)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
    }

    // MARK: - Setup Icon Button

    func setupButton() {

        menuButton = UIButton(type: .custom)
        menuButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        menuButton.tintColor = UIColor(named: "Brown")
        menuButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)

        view.addSubview(menuButton)

        menuButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.right.equalToSuperview().inset(20)
            make.width.height.equalTo(30)
        }
    }

    // MARK: - Setup Background View

    func setupBackgroundView() {
        backgroundView.backgroundColor = UIColor(named: "Light Green")
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.borderWidth = 4
        backgroundView.layer.borderColor = UIColor(named: "UI Green")?.cgColor

        view.addSubview(backgroundView)

        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(400)
        }
    }

    // MARK: - Setup UI
    func setupUI() {

        bookImageView.image = UIImage(named: "1984")
        bookImageView.contentMode = .scaleAspectFit
        bookImageView.layer.cornerRadius = 20
        bookImageView.clipsToBounds = true

        view.addSubview(bookImageView)

        bookImageView.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.top).offset(50)
            make.centerX.equalTo(backgroundView.snp.centerX)
            make.width.equalTo(140)
            make.height.equalTo(200)
        }

        bookNameLabel.text = "1984"
        bookNameLabel.font = UIFont(name: "Inter18pt-Bold", size: 20)
        bookNameLabel.textColor = UIColor(named: "Brown")

        view.addSubview(bookNameLabel)

        bookNameLabel.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        authorLabel.text = "George Orwell"
        authorLabel.font = UIFont(name: "Inter-Regular", size: 17)
        authorLabel.textColor = UIColor(named: "Brown")

        view.addSubview(authorLabel)

        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(bookNameLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        descriptionLabel.text = "A dystopian novel by George Orwell. Thematically centring on the consequences of totalitarianism, mass surveillance, and repressive regimentation of people and behaviours within society."
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = UIColor(named: "Dark")
        descriptionLabel.font = UIFont(name: "Inter-Italic", size: 15)
        descriptionLabel.numberOfLines = 0

        view.addSubview(descriptionLabel)

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.bottom)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(160)
        }

        listenButton.setTitle("Read", for: .normal)
        listenButton.titleLabel?.font = UIFont(name: "Inter18pt-SemiBold", size: 15)
        listenButton.backgroundColor = UIColor(named: "Brown")
        listenButton.layer.cornerRadius = 14
        listenButton.addTarget(self, action: #selector(listenButtonTapped), for: .touchUpInside)

        readButton.setTitle("Listen", for: .normal)
        readButton.titleLabel?.font = UIFont(name: "Inter18pt-SemiBold", size: 15)
        readButton.backgroundColor = UIColor(named: "Brown")
        readButton.layer.cornerRadius = 14
        readButton.addTarget(self, action: #selector(readButtonTapped), for: .touchUpInside)

        let buttonStackView = UIStackView(arrangedSubviews: [listenButton, readButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 15
        buttonStackView.distribution = .fillEqually

        view.addSubview(buttonStackView)

        buttonStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(680)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(120)
            make.height.equalTo(20)
            make.width.equalTo(40)
        }
    }

    // MARK: - Setup Rating Buttons
    func setupRatingButtons() {
        for index in 0..<5 {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(systemName: "star"), for: .normal)
            button.setImage(UIImage(systemName: "star.fill"), for: .selected)
            button.tintColor = UIColor(named: "Yellow")
            button.tag = index
            button.addTarget(self, action: #selector(ratingButtonTapped(_:)), for: .touchUpInside)

            ratingButtons.append(button)
            view.addSubview(button)

            button.snp.makeConstraints { make in
                make.top.equalTo(authorLabel.snp.bottom).offset(8)

                make.left.equalToSuperview().inset(90 + CGFloat(index) * 40)
                make.width.height.equalTo(40)
            }
        }

        updateRating(rating: currentRating)
    }

    // MARK: - Action for Rating Buttons

    @objc private func ratingButtonTapped(_ sender: UIButton) {
        let selectedRating = sender.tag + 1
        updateRating(rating: selectedRating)
    }

    // MARK: - Update Rating
    func updateRating(rating: Int) {
        currentRating = rating

        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }

    // MARK: - Actions

    @objc private func listenButtonTapped() {
        let readVC = ReadViewController()
        navigationController?.pushViewController(readVC, animated: true)
    }

    @objc private func readButtonTapped() {
        let listenVC = ListenViewController()
        navigationController?.pushViewController(listenVC, animated: true)
    }

    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc private func moreButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
