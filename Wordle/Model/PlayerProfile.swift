//
//  PlayerProfile.swift
//  Wordle
//
//  Created by Alex Golyshkov on 29.03.2022.
//

import Foundation

struct PlayerProfile {
    var playerUsername = ""
    var currentWordle = ""
    var difficultLevel = 5
    var wordIsGuessed = false
    var guessedLetters = 0
    var succsesAttempt = 0
    
    mutating func getRandomWorlde(on level: Int) {
        if level == 5 {
            currentWordle = DataStore.shared.fiveLetterCountries.randomElement() ?? ""
        } else {
            currentWordle = DataStore.shared.fourLetterCountries.randomElement() ?? ""
        }
    }
}
