//
//  StartScreenViewController.swift
//  Wordle
//
//  Created by Сергей Иванов on 29.03.2022.
//

import UIKit

class StartScreenViewController: UIViewController {
    var currentUser = PlayerProfile()
    
    @IBOutlet var usernameTextField: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let gameScreenVC = navigationVC.topViewController as? GameScreenViewController else { return }
        gameScreenVC.currentUser = currentUser
    }
    
    @IBAction func startButtonPressed() {
        guard let inputText = usernameTextField.text, !inputText.isEmpty else {
            showAlert(title: "Username is empty", message: "Enter your name")
            return
        }
        if let _ = Double(inputText) {
            showAlert(title: "Wrong format", message: "Enter your name")
            return
        }
        
        currentUser.playerUsername = usernameTextField.text ?? ""
        currentUser.getRandomWorlde(on: currentUser.difficultLevel)
        
        performSegue(withIdentifier: "showGameScreen", sender: nil)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.usernameTextField.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
