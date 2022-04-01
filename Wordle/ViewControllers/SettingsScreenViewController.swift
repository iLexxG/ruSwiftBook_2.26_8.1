//
//  SettingsScreenViewController.swift
//  Wordle
//
//  Created by Сергей Иванов on 29.03.2022.
//

import UIKit

class SettingsScreenViewController: UIViewController {
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    
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
        
        label1.text = currentUser.playerUsername
        label2.text = currentUser.currentWordle
    }
    
    @IBAction func changeDifficultLevel() {
        if difficultLevelSwitch.isOn { currentUser.difficultLevel = 5 } else {
            currentUser.difficultLevel = 4
        }
        delegate.startNewGame(atLevel: currentUser.difficultLevel)
    }
}
