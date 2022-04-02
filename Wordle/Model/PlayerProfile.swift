//
//  PlayerProfile.swift
//  Wordle
//
//  Created by Alex Golyshkov on 29.03.2022.
//

import Foundation

struct PlayerProfile {
    var playerUsername = ""
    var currentWordle: Countries = .ALGERIA
    var difficultLevel = 5
    var wordIsGuessed = false
    var guessedLetters = 0
    var succsesAttempt = 0
    var helpsCount = 0
    var playerRank: Rank = .cheater
    
    mutating func getRandomWorlde(on level: Int) {
        if level == 5 {
            currentWordle = Countries.getRandomFiveLetterCountry()
        }
        else {
            currentWordle = Countries.getRandomFourLetterCountry()
        }
    }
}

enum Rank: String {
    case cheater = "Читер"
    case master = "Магистр"
    case PhD = "Кандидат наук"
    case Ph_D = "Доктор наук"
    
    init(withHelpsCount number: Int) {
        switch number {
        case 0 :
            self = .Ph_D
        case 1:
            self = .PhD
        case 2:
            self = .master
        default:
            self = .cheater
        }
    }
}
