//
//  ListenViewController.swift
//  SawtiApp
//
//  Created by Ilmhona 10 on 18/11/24.
//

import UIKit
import AVFoundation
import SnapKit

class ListenViewController: UIViewController {
    
    // MARK: - UI Elements
    
    var menuButton = UIButton()
    let bookImageView = UIImageView()
    let starIcon = UIImageView()
    let raitingLabel = UILabel()
    let languageIcon = UIImageView()
    let languageLabel = UILabel()
    let audiaTimeIcon = UIImageView()
    let timeLabel = UILabel()
    let bookNameLabel = UILabel()
    let authorLabel = UILabel()

    // MARK: - AudioPlayer UI
    
    var slider = UISlider()
    var startTimeLabel = UILabel()
    var endTimeLabel = UILabel()
    
    let buttonBackgroundView = UIView()
    
    var playPauseButton = UIButton()
    var skipBackwardButton = UIButton()
    var skipForwardButton = UIButton()
    var rewindToStartButton = UIButton()
    var rewindToEndButton = UIButton()
   

    var audioPlayer: AVAudioPlayer?
    var isPlaying = false
    var timer: Timer?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Milk")
        
        // Создаем экземпляр CircleView
        let circleView = CircleView(frame: CGRect(x: 48.5, y: 100, width: 300, height: 300))
        view.addSubview(circleView)
        
        setupNavigationTitle()
        setupButton()
        setupBookImage()
        setupLabels()
        setupButtonBackground()
        setupAudioPlayerUI()
        setupAudioPlayer()
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

    // MARK: - Setup Icon Buttons (Arrow and Menu)
    func setupButton() {

        menuButton = UIButton(type: .custom)
        menuButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        menuButton.tintColor = UIColor(named: "Brown")
        menuButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        view.addSubview(menuButton)

        menuButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.right.equalToSuperview().inset(20)
            make.width.height.equalTo(30)
        }
    }

    // MARK: - Setup Book Image
    func setupBookImage() {
        view.addSubview(bookImageView)
        bookImageView.image = UIImage(named: "1984")
        bookImageView.contentMode = .scaleAspectFit
        bookImageView.layer.cornerRadius = 20
        bookImageView.clipsToBounds = true

        bookImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(145)
            make.height.equalTo(200)
        }
    }

    // MARK: - Setup Labels for Book Details
    func setupLabels() {
        let colorBrown = UIColor(named: "Brown")
        let colorText = UIColor(named: "Dark")

        // Language Label
        view.addSubview(languageIcon)
        view.addSubview(languageLabel)
        languageIcon.image = UIImage(systemName: "globe")
        languageIcon.tintColor = colorBrown
        languageLabel.text = "English"
        languageLabel.font = UIFont.boldSystemFont(ofSize: 14)
        languageLabel.textColor = colorText

        languageIcon.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.bottom).offset(20)
            make.right.equalTo(languageLabel.snp.left).offset(-5)
            make.width.height.equalTo(25)
        }

        languageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(languageIcon.snp.centerY)
        }

        // Rating Label
        view.addSubview(starIcon)
        view.addSubview(raitingLabel)
        starIcon.image = UIImage(systemName: "star.fill")
        starIcon.tintColor = colorBrown
        raitingLabel.text = "4.5"
        raitingLabel.font = UIFont.boldSystemFont(ofSize: 14)
        raitingLabel.textColor = colorText

        raitingLabel.snp.makeConstraints { make in
            make.right.equalTo(languageIcon.snp.left).offset(-20)
            make.centerY.equalTo(languageIcon.snp.centerY)
        }

        starIcon.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.bottom).offset(20)
            make.right.equalTo(raitingLabel.snp.left).offset(-5)
            make.width.height.equalTo(25)
        }

        // Audio Time Label
        view.addSubview(audiaTimeIcon)
        view.addSubview(timeLabel)
        audiaTimeIcon.image = UIImage(systemName: "mic.fill")
        audiaTimeIcon.tintColor = colorBrown
        timeLabel.text = "2 hours"
        timeLabel.font = UIFont.boldSystemFont(ofSize: 14)
        timeLabel.textColor = colorText

        audiaTimeIcon.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.bottom).offset(20)
            make.left.equalTo(languageLabel.snp.right).offset(20)
            make.width.height.equalTo(25)
        }

        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(audiaTimeIcon.snp.centerY)
            make.left.equalTo(audiaTimeIcon.snp.right).offset(5)
        }

        // Book and Author Labels
        view.addSubview(bookNameLabel)
        view.addSubview(authorLabel)

        bookNameLabel.text = "1984"
        bookNameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        bookNameLabel.textColor = colorText
        bookNameLabel.snp.makeConstraints { make in
            make.top.equalTo(languageLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        authorLabel.text = "George Orwell"
        authorLabel.font = UIFont.systemFont(ofSize: 16)
        authorLabel.textColor = colorText
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(bookNameLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupButtonBackground(){
        buttonBackgroundView.backgroundColor = UIColor(named: "Light Green")
        buttonBackgroundView.layer.borderWidth = 3
        buttonBackgroundView.layer.borderColor = UIColor(named: "UI Green")?.cgColor
        buttonBackgroundView.layer.cornerRadius = 30
        view.addSubview(buttonBackgroundView)

    }

    // MARK: - AudioPlayer UI
    func setupAudioPlayerUI() {
        let colorBrown = UIColor(named: "Brown")
        // Slider
        slider.minimumValue = 0
        slider.maximumValue = 15
        slider.minimumTrackTintColor = colorBrown
        slider.thumbTintColor = colorBrown
        slider.value = 0
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        view.addSubview(slider)

        // Time Labels
        startTimeLabel.text = "0:00"
        startTimeLabel.textAlignment = .left
        startTimeLabel.font = UIFont.systemFont(ofSize: 14)
        startTimeLabel.textColor = colorBrown
        view.addSubview(startTimeLabel)

        endTimeLabel.text = "00:00"
        endTimeLabel.textAlignment = .right
        endTimeLabel.font = UIFont.systemFont(ofSize: 14)
        endTimeLabel.textColor = colorBrown
        view.addSubview(endTimeLabel)

        // Audio Control Buttons
        view.addSubview(playPauseButton)
        playPauseButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        playPauseButton.tintColor = colorBrown
        playPauseButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)

        view.addSubview(skipBackwardButton)
        skipBackwardButton.setImage(UIImage(systemName: "gobackward.10"), for: .normal)
        skipBackwardButton.tintColor = colorBrown
        skipBackwardButton.addTarget(self, action: #selector(skipBackward), for: .touchUpInside)

        view.addSubview(skipForwardButton)
        skipForwardButton.setImage(UIImage(systemName: "goforward.10"), for: .normal)
        skipForwardButton.tintColor = colorBrown
        skipForwardButton.addTarget(self, action: #selector(skipForward), for: .touchUpInside)

        view.addSubview(rewindToStartButton)
        rewindToStartButton.setImage(UIImage(systemName: "backward.end"), for: .normal)
        rewindToStartButton.tintColor = colorBrown
        rewindToStartButton.addTarget(self, action: #selector(rewindToStart), for: .touchUpInside)

        view.addSubview(rewindToEndButton)
        rewindToEndButton.setImage(UIImage(systemName: "forward.end"), for: .normal)
        rewindToEndButton.tintColor = colorBrown
        rewindToEndButton.addTarget(self, action: #selector(rewindToEnd), for: .touchUpInside)

      

        setupPlayerConstraints()
    }

    // MARK: - Setup Audio Player Constraints
    func setupPlayerConstraints() {
        slider.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(100)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }

        startTimeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(slider.snp.top).inset(-10)
            make.left.equalTo(slider.snp.left)
        }

        endTimeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(slider.snp.top).inset(-10)
            make.right.equalTo(slider.snp.right)
        }
        
        // Set the stack view's constraints using SnapKit
        buttonBackgroundView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(slider.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(60)
        }
//        button in stack
        playPauseButton.snp.makeConstraints { make in
            make.centerX.equalTo(buttonBackgroundView.snp.centerX)
            make.centerY.equalTo(buttonBackgroundView.snp.centerY)
            make.width.height.equalTo(60)
        }

        skipBackwardButton.snp.makeConstraints { make in
            make.centerY.equalTo(buttonBackgroundView.snp.centerY)
            make.right.equalTo(playPauseButton.snp.left).offset(-10)
            make.width.height.equalTo(60)
        }

        skipForwardButton.snp.makeConstraints { make in
            make.centerY.equalTo(buttonBackgroundView.snp.centerY)
            make.left.equalTo(playPauseButton.snp.right).offset(10)
            make.width.height.equalTo(60)
        }

        rewindToStartButton.snp.makeConstraints { make in
            make.centerY.equalTo(buttonBackgroundView.snp.centerY)
            make.right.equalTo(skipBackwardButton.snp.left).offset(-10)
            make.width.height.equalTo(60)
        }

        rewindToEndButton.snp.makeConstraints { make in
            make.centerY.equalTo(buttonBackgroundView.snp.centerY)
            make.left.equalTo(skipForwardButton.snp.right).offset(10)
            make.width.height.equalTo(60)
        }
    }
    
    // MARK: - Action for icon
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func moreButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    

    // MARK: - Audio Player Setup
    func setupAudioPlayer() {
        if let audioPath = Bundle.main.path(forResource: "1984Audio", ofType: "mp3") {
            let audioUrl = URL(fileURLWithPath: audioPath)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
                audioPlayer?.prepareToPlay()
                slider.maximumValue = Float(audioPlayer!.duration)
                endTimeLabel.text = formatTime(audioPlayer!.duration)
            } catch {
                print("Error loading audio file: \(error.localizedDescription)")
            }
        } else {
            print("Audio file not found!")
        }

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatePlayerTime), userInfo: nil, repeats: true)
    }

    // MARK: - Actions for Audio Controls
    
    @objc func playPauseButtonTapped() {
        if isPlaying {
            audioPlayer?.pause()
            playPauseButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        } else {
            audioPlayer?.play()
            playPauseButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        }
        isPlaying.toggle()
    }

    @objc func skipBackward() {
        audioPlayer?.currentTime -= 10
    }

    @objc func skipForward() {
        audioPlayer?.currentTime += 10
    }

    @objc func rewindToStart() {
        audioPlayer?.currentTime = 0
        startTimeLabel.text = formatTime(audioPlayer!.currentTime)
    }

    @objc func rewindToEnd() {
        audioPlayer?.currentTime = audioPlayer!.duration
        startTimeLabel.text = formatTime(audioPlayer!.currentTime)
    }

    @objc func updatePlayerTime() {
        if let player = audioPlayer {
            slider.value = Float(player.currentTime)
            startTimeLabel.text = formatTime(player.currentTime)
        }
    }

    @objc func sliderValueChanged(_ sender: UISlider) {
        audioPlayer?.currentTime = TimeInterval(sender.value)
        startTimeLabel.text = formatTime(audioPlayer!.currentTime)
    }

    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

