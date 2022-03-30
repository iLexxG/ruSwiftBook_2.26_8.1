//
//  ViewController.swift
//  Wordle
//
//  Created by Alex Golyshkov on 25.03.2022.
//

import UIKit

protocol StartNewGameDelegate {
    func startNewGame(atLevel level: Int)
}

class GameScreenViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet var label: UILabel!
    
    @IBOutlet var screenLettersButtons: [UIButton]!
    @IBOutlet var manageButtons: [UIButton]!
    
    @IBOutlet var levelFourStackView: UIStackView!
    @IBOutlet var levelFiveStackView: UIStackView!
    @IBOutlet var gameScreenButtonsSV: UIStackView!
    @IBOutlet var endgameButtonsSV: UIStackView!
    
    @IBOutlet var firstTryLevelFourTF: [UITextField]!
    @IBOutlet var secondTryLevelFourTF: [UITextField]!
    @IBOutlet var thirdTryLevelFourTF: [UITextField]!
    @IBOutlet var fourthTryLevelFourTF: [UITextField]!
    @IBOutlet var fifthTryLevelFourTF: [UITextField]!
    @IBOutlet var sixthTryLevelFourTF: [UITextField]!
    
    @IBOutlet var firstTryLevelFiveTF: [UITextField]!
    @IBOutlet var secondTryLevelFiveTF: [UITextField]!
    @IBOutlet var thirdTryLevelFiveTF: [UITextField]!
    @IBOutlet var fourthTryLevelFiveTF: [UITextField]!
    @IBOutlet var fifthTryLevelFiveTF: [UITextField]!
    @IBOutlet var sixthTryLevelFiveTF: [UITextField]!
    
    
    //MARK: - Public properties
    var currentUser: PlayerProfile!
    var playerAnswers: [[UITextField]] = []
    var currentAttempt = 0
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Welcome, \(currentUser.playerUsername)"
        label.text = currentUser.currentWordle
        
        screenLettersButtons.forEach { letter in
            letter.layer.cornerRadius = 10
            letter.layer.borderWidth = 1
            letter.layer.borderColor = UIColor.gray.cgColor
        }
        
        manageButtons.forEach { button in
            button.layer.cornerRadius = 10
        }
        
        endgameButtonsSV.isHidden = true
        
        startNewGame(atLevel: currentUser.difficultLevel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsScreenViewController else { return }
        settingsVC.currentUser = currentUser
        settingsVC.delegate = self
    }
    
    //MARK: - IB Actions
    @IBAction func clickAnyLetter(_ sender: UIButton) {
        guard let activeTextField = playerAnswers[currentAttempt].firstIndex(where: {$0.text == ""}) else { return }
        playerAnswers[currentAttempt][activeTextField].text = DataStore.shared.letters[sender.tag]
    }
    
    @IBAction func backspaceButtonPressed() {
        guard let activeTextField = playerAnswers[currentAttempt].lastIndex(where: {$0.text != ""}) else { return }
        playerAnswers[currentAttempt][activeTextField].text = ""
    }
    
    @IBAction func enterButtonPressed() {
        var userAttemptWord = ""
        
        for index in 0..<currentUser.currentWordle.count {
            guard let currentUserLetter = playerAnswers[currentAttempt][index].text else { return }
            let currentWordleLetter = String(Array(currentUser.currentWordle)[index])
            userAttemptWord += currentUserLetter
            
            if currentUserLetter == currentWordleLetter {
                UIView.transition(with: playerAnswers[currentAttempt][index], duration: 0.2, options: [.transitionFlipFromTop, .showHideTransitionViews], animations: nil)
                playerAnswers[currentAttempt][index].backgroundColor = UIColor.green
            } else if currentUser.currentWordle.contains(currentUserLetter) {
                UIView.transition(with: playerAnswers[currentAttempt][index], duration: 0.2, options: [.transitionFlipFromTop, .showHideTransitionViews], animations: nil)
                playerAnswers[currentAttempt][index].backgroundColor = UIColor.yellow
            } else {
                playerAnswers[currentAttempt][index].backgroundColor = UIColor.gray
                playerAnswers[currentAttempt][index].shake()
            }
        }
        
        if userAttemptWord == currentUser.currentWordle || currentAttempt == 5 {
            gameScreenButtonsSV.isHidden = true
            UIView.transition(with: gameScreenButtonsSV, duration: 0.5, options: [.transitionCrossDissolve], animations: nil)
            endgameButtonsSV.isHidden = false
        } else {
            currentAttempt += 1
        }
    }
    
    @IBAction func newGameButtonPressed() {
        currentUser.getRandomWorlde(on: currentUser.difficultLevel)
        startNewGame(atLevel: currentUser.difficultLevel)
    }
}

// MARK: - Animation
extension UIView {
    func shake(duration: TimeInterval = 0.05, shakeCount: Float = 3, xValue: CGFloat = 3, yValue: CGFloat = 0){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = shakeCount
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - xValue, y: self.center.y - yValue))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + xValue, y: self.center.y - yValue))
        self.layer.add(animation, forKey: "shake")
    }
}

// MARK: - StartNewGameDelegate
extension GameScreenViewController: StartNewGameDelegate {
    func startNewGame(atLevel level: Int) {
        playerAnswers = []
        currentAttempt = 0
        self.currentUser.difficultLevel = level
        currentUser.getRandomWorlde(on: level)
        label.text = currentUser.currentWordle
        
        if level == 5 {
            levelFourStackView.isHidden = true
            levelFiveStackView.isHidden = false
            
            playerAnswers.append(firstTryLevelFiveTF)
            playerAnswers.append(secondTryLevelFiveTF)
            playerAnswers.append(thirdTryLevelFiveTF)
            playerAnswers.append(fourthTryLevelFiveTF)
            playerAnswers.append(fifthTryLevelFiveTF)
            playerAnswers.append(sixthTryLevelFiveTF)
            
        } else {
            levelFourStackView.isHidden = false
            levelFiveStackView.isHidden = true
            
            playerAnswers.append(firstTryLevelFourTF)
            playerAnswers.append(secondTryLevelFourTF)
            playerAnswers.append(thirdTryLevelFourTF)
            playerAnswers.append(fourthTryLevelFourTF)
            playerAnswers.append(fifthTryLevelFourTF)
            playerAnswers.append(sixthTryLevelFourTF)
        }
        
        playerAnswers.forEach { currentStackView in
            currentStackView.forEach { currentTextField in
                currentTextField.text = ""
                currentTextField.backgroundColor = UIColor.white
            }
        }
        
        endgameButtonsSV.isHidden = true
        gameScreenButtonsSV.isHidden = false
        UIView.transition(with: super.view, duration: 0.2, options: [.transitionCurlUp], animations: nil)
    }
}
