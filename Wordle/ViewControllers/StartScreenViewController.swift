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
        currentUser.playerUsername = usernameTextField.text ?? ""
        currentUser.getRandomWorlde(on: currentUser.difficultLevel)
        
        performSegue(withIdentifier: "showGameScreen", sender: nil)
    }
}
