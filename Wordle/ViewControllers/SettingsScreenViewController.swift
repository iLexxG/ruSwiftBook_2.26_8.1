//
//  SettingsScreenViewController.swift
//  Wordle
//
//  Created by Сергей Иванов on 29.03.2022.
//

import UIKit

class SettingsScreenViewController: UIViewController {
    
    @IBOutlet var difficultLevelSwitch: UISwitch!
    
    var currentUser: PlayerProfile!
    var delegate: GameScreenViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentUser.difficultLevel == 5 {
            difficultLevelSwitch.isOn = true
        } else {
            difficultLevelSwitch.isOn = false
        }
    }
    
    @IBAction func changeDifficultLevel() {
        if difficultLevelSwitch.isOn { currentUser.difficultLevel = 5 } else {
            currentUser.difficultLevel = 4
        }
        delegate.startNewGame(atLevel: currentUser.difficultLevel)
    }
}
