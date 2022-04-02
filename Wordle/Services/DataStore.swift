//
//  DataStore.swift
//  Wordle
//
//  Created by Сергей Иванов on 29.03.2022.
//

import Foundation

class DataStore {
    static let shared = DataStore()
    
    let letters = [
        "Й", "Ц", "У", "К", "Е", "Н", "Г", "Ш", "Щ", "З", "Х", "Ъ",
        "Ф", "Ы", "В", "А", "П", "Р", "О", "Л", "Д", "Ж", "Э",
        "Я", "Ч", "С", "М", "И", "Т", "Ь", "Б", "Ю"
    ]
    private init() {}
}

enum Countries: String {
    case ALGERIA = "🇩🇿"
    case BELIZE = "🇧🇿"
    case BENIN = "🇧🇯"
    case BHUTAN = "🇧🇹"
    case GABON = "🇬🇦"
    case HAITI = "🇭🇹"
    case DENMARK = "🇩🇰"
    case INDIA = "🇮🇳"
    case YEMEN = "🇾🇪"
    case QATAR = "🇶🇦"
    case KENYA = "🇰🇪"
    case LEBANON = "🇱🇧"
    case LIBYA = "🇱🇾"
    case LITHUANIA = "🇱🇹"
    case NAURU = "🇳🇷"
    case NEPAL = "🇳🇵"
    case NIGER = "🇳🇪"
    case PALAU = "🇵🇼"
    case PAPUA = "🇵🇬"
    case SAMOA = "🇼🇸"
    case SYRIA = "🇸🇾"
    case SUDAN = "🇸🇩"
    case TONGA = "🇹🇴"
    case TUNISIA = "🇹🇳"
    case FIJI = "🇫🇯"
    case CZECH = "🇨🇿"
    case CHINESE = "🇨🇳"
    case GHANA = "🇬🇭"
    case IRAQ = "🇮🇶"
    case IRAN = "🇮🇷"
    case CYPRUS = "🇨🇾"
    case DPRK = "🇰🇵"
    case CUBA = "🇨🇺"
    case LAOS = "🇱🇦"
    case MALI = "🇲🇱"
    case OMAN = "🇴🇲"
    case PERU = "🇵🇪"
    case TOGO = "🇹🇬"
    case CHILE = "🇨🇱"
    
    func description() -> String {
        switch self {
            
        case .ALGERIA:
            return "АЛЖИР"
        case .BELIZE:
            return "БЕЛИЗ"
        case .BENIN:
            return "БЕНИН"
        case .BHUTAN:
            return "БУТАН"
        case .GABON:
            return "ГАБОН"
        case .HAITI:
            return "ГАИТИ"
        case .DENMARK:
            return "ДАНИЯ"
        case .INDIA:
            return "ИНДИЯ"
        case .YEMEN:
            return "ЙЕМЕН"
        case .QATAR:
            return "КАТАР"
        case .KENYA:
            return "КЕНИЯ"
        case .LEBANON:
            return "ЛИВАН"
        case .LIBYA:
            return "ЛИВИЯ"
        case .LITHUANIA:
            return "ЛИТВА"
        case .NAURU:
            return "НАУРУ"
        case .NEPAL:
            return "НЕПАЛ"
        case .NIGER:
            return "НИГЕР"
        case .PALAU:
            return "ПАЛАУ"
        case .PAPUA:
            return "ПАПУА"
        case .SAMOA:
            return "САМОА"
        case .SYRIA:
            return "СИРИЯ"
        case .SUDAN:
            return "СУДАН"
        case .TONGA:
            return "ТОНГА"
        case .TUNISIA:
            return "ТУНИС"
        case .FIJI:
            return "ФИДЖИ"
        case .CZECH:
            return "ЧЕХИЯ"
        case .CHINESE:
            return "КИТАЙ"
        case .GHANA:
            return "ГАНА"
        case .IRAQ:
            return "ИРАК"
        case .IRAN:
            return "ИРАН"
        case .CYPRUS:
            return "КИПР"
        case .DPRK:
            return "КНДР"
        case .CUBA:
            return "КУБА"
        case .LAOS:
            return "ЛАОС"
        case .MALI:
            return "МАЛИ"
        case .OMAN:
            return "ОМАН"
        case .PERU:
            return "ПЕРУ"
        case .TOGO:
            return "ТОГО"
        case .CHILE:
            return "ЧИЛИ"
        }
    }
    
    static func getRandomFiveLetterCountry() -> Countries {
        let fiveLetterCountries: [Countries] = [
            .ALGERIA, .BELIZE, .BENIN, .BHUTAN, .GABON, .HAITI, .DENMARK,
            .INDIA, .YEMEN, .QATAR, .KENYA, .LEBANON, .LIBYA, .LITHUANIA,
            .NAURU, .NEPAL, .NIGER, .PALAU, .PAPUA, .SAMOA, .SYRIA, .SUDAN,
            .TONGA, .TUNISIA, .FIJI, .CZECH, .CHINESE
        ]
        return fiveLetterCountries.randomElement() ?? .ALGERIA
    }
    
    static func getRandomFourLetterCountry() -> Countries {
        let fourLetterCountries: [Countries] = [
            .GHANA, .IRAQ, .IRAN, .CYPRUS, .DPRK, .CUBA, .LAOS, .MALI, .OMAN,
            .PERU, .TOGO, .CHILE
            ]
        return fourLetterCountries.randomElement() ?? .CUBA
    }
}
