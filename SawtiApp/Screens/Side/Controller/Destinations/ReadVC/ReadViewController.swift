//
//  ReadViewController.swift
//  SawtiApp
//
//  Created by Ilmhona 10 on 18/11/24.
//

import UIKit
import SnapKit

class ReadViewController: UIViewController {
    
    // MARK: - UI
    
    var menuIconButton = UIButton()
    var bookmarkIconButton = UIButton()
    var searchIconButton = UIButton()
    var settingIconButton = UIButton()
    
    var textView: UITextView!
    
    var currentFont: UIFont = UIFont(name: "Inter-Regular", size: 18)!
    var fontSize: CGFloat = 18
    var fontColor: UIColor = UIColor(named: "Brown")!
    
    let slider = UISlider()
    let percentageLabel = UILabel()
    let pagesLeftLabel = UILabel()
    let pagesReadLabel = UILabel()
    
    
    let totalPages: Float = 208
    let pagesInChapter: Float = 17
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Milk")
        
        setupUI()
    }
    
    func setupUI() {
        setupNavigationTitle()
        setupButton()
        setupConstraints()
        
        setupPercentageLabel()
        setupSlider()
        setupLabels()
        updateLabels()
    }
    
    // MARK: - Navigation
    
    private func setupNavigationTitle() {
        navigationItem.title = "صوتي"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(named: "Brown") ?? .black,
            .font: UIFont(name: "Inter24pt-Bold", size: 24) ?? .boldSystemFont(ofSize: 24),
            .obliqueness: 0.2
        ]
    }
    
    // MARK: - Setup Percent
    
    func setupPercentageLabel() {
        percentageLabel.text = "0%"
        percentageLabel.font = UIFont.systemFont(ofSize: 12)
        percentageLabel.textColor = fontColor
        
        view.addSubview(percentageLabel)
        
        percentageLabel.snp.makeConstraints { make in
            make.bottom.equalTo(slider.snp.top).offset(-5)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func updatePercentageLabel() {
        let percentage = (slider.value / totalPages) * 100
        percentageLabel.text = String(format: "%d%%", Int(percentage))
    }
    
    // MARK: - Setup Slider
    func setupSlider() {
        slider.minimumValue = 0
        slider.maximumValue = totalPages
        slider.minimumTrackTintColor = fontColor
        slider.thumbTintColor = fontColor
        
        slider.value = 0
        slider.isContinuous = true
        
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        view.addSubview(slider)
    }
        
       
    // MARK: - Setup Labels on slider
    func setupLabels() {
        pagesLeftLabel.textAlignment = .center
        pagesReadLabel.textAlignment = .center
        pagesLeftLabel.font = UIFont.systemFont(ofSize: 12)
        pagesReadLabel.font = UIFont.systemFont(ofSize: 12)
        pagesLeftLabel.textColor = fontColor
        pagesReadLabel.textColor = fontColor
        
        view.addSubview(pagesLeftLabel)
        view.addSubview(pagesReadLabel)
        
       
    }

    // MARK: - Setup Button
    func setupButton() {
        
        // Setup menuIconButton
        menuIconButton = UIButton(type: .custom)
        menuIconButton.setImage(UIImage(systemName: "list.star"), for: .normal)
        menuIconButton.tintColor = UIColor(named: "Brown")
        menuIconButton.setTitle("", for: .normal)
        menuIconButton.addTarget(self, action: #selector(menuTapped), for: .touchUpInside)
        
        view.addSubview(menuIconButton)
        
        // Setup bookmarkIconButton
        bookmarkIconButton = UIButton(type: .custom)
        bookmarkIconButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        bookmarkIconButton.tintColor = UIColor(named: "Brown")
        bookmarkIconButton.setTitle("", for: .normal)
        bookmarkIconButton.addTarget(self, action: #selector(menuTapped), for: .touchUpInside)
        
        view.addSubview(bookmarkIconButton)
        
        // Setup searchIconButton
        searchIconButton = UIButton(type: .custom)
        searchIconButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchIconButton.tintColor = UIColor(named: "Brown")
        searchIconButton.setTitle("", for: .normal)
        searchIconButton.addTarget(self, action: #selector(menuTapped), for: .touchUpInside)
        
        view.addSubview(searchIconButton)
        
        // Setup settingIconButton
        settingIconButton = UIButton(type: .custom)
        settingIconButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        settingIconButton.tintColor = UIColor(named: "Brown")
        settingIconButton.setTitle("", for: .normal)
        settingIconButton.addTarget(self, action: #selector(menuTapped), for: .touchUpInside)
        
        view.addSubview(settingIconButton)
        
        // Set up textView
        textView = UITextView()
        textView.isEditable = false
        textView.font = currentFont
        textView.textColor = fontColor
        textView.backgroundColor = .clear
        textView.text = """

        Part I


        * Chapter One *


        It was a bright cold day in April, and the clocks were striking thirteen. Winston Smith, his chin nuzzled into his breast in an effort to escape the vile wind, slipped quickly through the glass doors of Victory Mansions, though not quickly enough to prevent a swirl of gritty dust from entering along with him.
        
        The hallway smelt of boiled cabbage and old rag mats. At one end of it a coloured poster, too large for indoor display, had been tacked to the wall. It depicted simply an enormous face, more than a metre wide: the face of a man of about forty-five, with a heavy black moustache and ruggedly handsome features. Winston made for the stairs. It was no use trying the lift. Even at the best of times it was seldom working, and at present the electric current was cut off during daylight hours. It was part of the economy drive in preparation for Hate Week. The flat was seven flights up, and Winston, who was thirty-nine and had a varicose ulcer above his right ankle, went slowly, resting several times on the way. On each landing, opposite the lift-shaft, the poster with the enormous face gazed from the wall. It was one of those pictures which are so contrived that the eyes follow you about when you move. BIG BROTHER IS WATCHING YOU, the caption beneath it ran.

        Inside the flat a fruity voice was reading out a list of figures which had something to do with the production of pig-iron. The voice came from an oblong metal plaque like a dulled mirror which formed part of the surface of the right-hand wall. Winston turned a switch and the voice sank somewhat, though the words were still distinguishable. The instrument (the telescreen, it was called) could be dimmed, but there was no way of shutting it off completely. He moved over to the window: a smallish, frail figure, the meagreness of his body merely emphasized by the blue overalls which were the uniform of the party. His hair was very fair, his face naturally sanguine, his skin roughened by coarse soap and blunt razor blades and the cold of the winter that had just ended.

        Outside, even through the shut window-pane, the world looked cold. Down in the street little eddies of wind were whirling dust and torn paper into spirals, and though the sun was shining and the sky a harsh blue, there seemed to be no colour in anything, except the posters that were plastered everywhere. The blackmoustachio'd face gazed down from every commanding corner. There was one on the house-front immediately opposite. BIG BROTHER IS WATCHING YOU, the caption said, while the dark eyes looked deep into Winston's own. Down at streetlevel another poster, torn at one corner, flapped fitfully in the wind, alternately covering and uncovering the single word INGSOC. In the far distance a helicopter skimmed down between the roofs, hovered for an instant like a bluebottle, and darted away again with a curving flight. It was the police patrol, snooping into people's windows. The patrols did not matter, however. Only the Thought Police mattered.
"""
        textView.backgroundColor = .white
        
        view.addSubview(textView)
    }
    
    // MARK: - Actions
    @objc func backTapped() {
        
    }
    
    @objc func menuTapped() {
        
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        updateLabels()
        updatePercentageLabel()
    }

    func updateLabels() {
        let pagesRead = round(slider.value)
        let pagesLeft = totalPages - pagesRead
        pagesLeftLabel.text = "\(Int(pagesLeft)) pages to the end of the Book"
        pagesReadLabel.text = "\(Int(pagesRead)) pages of \(Int(totalPages))"
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        view.addSubview(menuIconButton)
        view.addSubview(settingIconButton)
        view.addSubview(searchIconButton)
        view.addSubview(bookmarkIconButton)
        view.addSubview(textView)
        view.addSubview(slider)
        view.addSubview(pagesLeftLabel)
        view.addSubview(pagesReadLabel)

        // Setup Constraints for menuIconButton
        menuIconButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.right.equalToSuperview().inset(140)
            make.width.height.equalTo(30)
        }

        // Setup Constraints for settingIconButton
        settingIconButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(30)
        }

        // Setup Constraints for searchIconButton
        searchIconButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(settingIconButton.snp.leading).offset(-10)
            make.width.height.equalTo(30)
        }

        // Setup Constraints for bookmarkIconButton
        bookmarkIconButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalTo(searchIconButton.snp.leading).offset(-10)
            make.width.height.equalTo(30)
        }

        // Setup Constraints for textView
        textView.snp.makeConstraints { make in
            make.top.equalTo(bookmarkIconButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-100)
        }

        // Setup Constraints for Slider
        slider.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        // Setup Constraints for pagesLeftLabel
        pagesLeftLabel.snp.makeConstraints { make in
            make.top.equalTo(slider.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }

        // Setup Constraints for pagesReadLabel
        pagesReadLabel.snp.makeConstraints { make in
            make.top.equalTo(slider.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(20)
        }
    }

}


