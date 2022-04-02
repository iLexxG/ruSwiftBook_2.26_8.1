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
    var correctLettersIndexInAttempt: [Int] = []
    var correctLettersIndexInGame: [Int] = []
    var currentAttempt = 0
    var wordForMultiContainCheck = ""
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Welcome, \(currentUser.playerUsername)"
        
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
        if let settingsVC = segue.destination as? SettingsScreenViewController {
            settingsVC.currentUser = currentUser
            settingsVC.delegate = self
        } else if let resultVC = segue.destination as? ResultScreenViewController {
            resultVC.currentUser = currentUser
        }
    }
    
    //MARK: - IB Actions
    @IBAction func clickAnyLetter(_ sender: UIButton) {
        guard let activeTextField = playerAnswers[currentAttempt].firstIndex(
            where: {$0.text == ""}
        ) else { return }
        playerAnswers[currentAttempt][activeTextField].text = DataStore.shared.letters[sender.tag]
    }
    
    @IBAction func backspaceButtonPressed() {
        guard let activeTextField = playerAnswers[currentAttempt].lastIndex(
            where: {$0.text != ""}
        ) else { return }
        playerAnswers[currentAttempt][activeTextField].text = ""
    }
    
    @IBAction func enterButtonPressed() {
        let enteredUserWord = getEnteredUserWord()
        correctLettersIndexInAttempt = []
        wordForMultiContainCheck = currentUser.currentWordle.description()

        if enteredUserWord.count != currentUser.difficultLevel {
            showAlert(
                title: "Ошибка",
                message: "Слово должно быть из \(currentUser.difficultLevel) букв!"
            )
            return
        }

        checkCorrectLetters()
        checkOtherLetters()

        if enteredUserWord == currentUser.currentWordle.description() {
            currentUser.wordIsGuessed = true
            endCurrentGame()
        } else if currentAttempt == 5 {
            currentUser.wordIsGuessed = false
            endCurrentGame()
        } else {
            currentAttempt += 1
        }
    }
    
    @IBAction func helpButtonPressed() {
        let currentTextFields = playerAnswers[currentAttempt]
        let possibleIndexForHelp = Array(stride(from: 0, to: currentUser.difficultLevel, by: 1))
            .filter {correctLettersIndexInGame.contains($0) == false}
        
        if currentAttempt == 5 || possibleIndexForHelp.isEmpty {
            for index in 0..<currentUser.difficultLevel {
                currentTextFields[index].text = String(Array(currentUser.currentWordle.description())[index])
            }
            enterButtonPressed()
            return
        }
        
        guard let indexForHelp = possibleIndexForHelp.randomElement() else { return }
        
        for index in 0..<currentUser.difficultLevel where index != indexForHelp {
            currentTextFields[index].shake()
            currentTextFields[index].backgroundColor = .systemGray
        }

        currentTextFields[indexForHelp].text = String(Array(currentUser.currentWordle.description())[indexForHelp])
        guard let currentScreenButton = DataStore.shared.letters.firstIndex(
            of: currentTextFields[indexForHelp].text ?? ""
        ) else { return }
        
        animateLetter(
            in: currentTextFields[indexForHelp],
            and: currentScreenButton,
            with: .transitionFlipFromTop,
            by: .systemGreen
        )
        
        currentUser.helpsCount += 1
        currentAttempt += 1
        correctLettersIndexInGame.append(indexForHelp)
    }
    
    @IBAction func newGameButtonPressed() {
        startNewGame(atLevel: currentUser.difficultLevel)
    }
    
    //MARK: - Private Methods
    private func getEnteredUserWord() -> String {
        var enteredUserWord = ""
        
        playerAnswers[currentAttempt].forEach { textField in
            guard let currentLetter = textField.text else { return }
            enteredUserWord += currentLetter
        }
        return enteredUserWord
    }
    
    private func checkCorrectLetters() {
        for index in 0..<currentUser.currentWordle.description().count {
            let currentTextField = playerAnswers[currentAttempt][index]
            let currentWordleLetter = String(Array(currentUser.currentWordle.description())[index])
            guard let currentUserLetter = currentTextField.text else { return }
            guard let currentScreenButton = DataStore.shared.letters.firstIndex(of: currentUserLetter) else { return }
            
            if currentUserLetter == currentWordleLetter {
                animateLetter(
                    in: currentTextField,
                    and: currentScreenButton,
                    with: .transitionFlipFromTop,
                    by: .systemGreen
                )
                
                if let i = wordForMultiContainCheck.firstIndex(of: Character(currentUserLetter)) {
                    wordForMultiContainCheck.remove(at: i)
                }
                currentUser.guessedLetters += 1
                correctLettersIndexInGame.append(index)
                correctLettersIndexInAttempt.append(index)
            }
        }
    }
    
    private func checkOtherLetters() {
        for index in 0..<currentUser.currentWordle.description().count {
            if correctLettersIndexInAttempt.contains(index) { continue }
            
            let currentTextField = playerAnswers[currentAttempt][index]
            guard let currentUserLetter = currentTextField.text else { return }
            guard let currentScreenButton = DataStore.shared.letters.firstIndex(of: currentUserLetter) else { return }
            
            if wordForMultiContainCheck.contains(currentUserLetter) {
                animateLetter(
                    in: currentTextField,
                    and: currentScreenButton,
                    with: .transitionFlipFromTop,
                    by: .systemYellow
                )
                
                if let i = wordForMultiContainCheck.firstIndex(of: Character(currentUserLetter)) {
                    wordForMultiContainCheck.remove(at: i)
                }
            } else {
                currentTextField.shake()
                currentTextField.backgroundColor = .systemGray
                currentTextField.textColor = .white
                screenLettersButtons[currentScreenButton].backgroundColor = .systemGray
            }
        }
    }
    
    private func endCurrentGame() {
        currentUser.succsesAttempt = currentAttempt
        currentUser.playerRank = Rank(withHelpsCount: currentUser.helpsCount)
        
        gameScreenButtonsSV.isHidden = true
        animate(gameScreenButtonsSV, with: .transitionFlipFromTop)
        endgameButtonsSV.isHidden = false
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

extension GameScreenViewController {
    private func animateLetter(
        in currentTextField: UITextField,
        and currentScreenButton: Int,
        with options: UIView.AnimationOptions,
        by color: UIColor
    ) {
        UIView.transition(
            with: currentTextField,
            duration: 0.5,
            options: options,
            animations: nil
        )
        currentTextField.backgroundColor = color
        currentTextField.textColor = .white
        screenLettersButtons[currentScreenButton].backgroundColor = color
    }
    
    private func animate(_ uiItem: UIView, with options: UIView.AnimationOptions) {
        UIView.transition(
            with: uiItem,
            duration: 0.5,
            options: options,
            animations: nil
        )
    }
}

// MARK: - Show Alert
extension GameScreenViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - StartNewGameDelegate
extension GameScreenViewController: StartNewGameDelegate {
    func startNewGame(atLevel level: Int) {
        playerAnswers = []
        correctLettersIndexInGame = []
        currentAttempt = 0
        currentUser.helpsCount = 0
        currentUser.guessedLetters = 0
        currentUser.getRandomWorlde(on: level)
        self.currentUser.difficultLevel = level
        
        
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
        
        screenLettersButtons.forEach { currentButton in
            currentButton.backgroundColor = .white
        }
        
        playerAnswers.forEach { currentStackView in
            currentStackView.forEach { currentTextField in
                currentTextField.textColor = .black
                currentTextField.text = ""
                currentTextField.backgroundColor = .white
            }
        }
        
        endgameButtonsSV.isHidden = true
        gameScreenButtonsSV.isHidden = false
        animate(super.view, with: .transitionCurlUp)
    }
}
