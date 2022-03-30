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
    var difficultLevel = 4
    
    mutating func getRandomWorlde(on level: Int) {
        if level == 5 {
            currentWordle = DataStore.shared.fiveLetterCountries.randomElement() ?? ""
        } else {
            currentWordle = DataStore.shared.fourLetterCountries.randomElement() ?? ""
        }
    }
}
