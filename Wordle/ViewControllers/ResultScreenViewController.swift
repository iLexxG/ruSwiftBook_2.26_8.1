//
//  ResultScreenViewController.swift
//  Wordle
//
//  Created by Сергей Иванов on 29.03.2022.
//

import UIKit

class ResultScreenViewController: UITableViewController {
    var currentUser: PlayerProfile!
    var playerResults: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = currentUser.playerUsername
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Ваш результат:"
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCell = tableView.dequeueReusableCell(withIdentifier: "gameResult", for: indexPath)
        var content = currentCell.defaultContentConfiguration()
        
        if currentUser.wordIsGuessed {
            playerResults.append("Вы отгадали слово! 👍")
            playerResults.append("Да, это \"\(currentUser.currentWordle)\"")
            playerResults.append("Количество попыток: \(currentUser.succsesAttempt + 1)")
            playerResults.append("Уровень сложности: \(currentUser.difficultLevel)")
        } else {
            playerResults.append("Вы не отгадали слово 🤦‍♂️")
            playerResults.append("А это \"\(currentUser.currentWordle)\"")
            playerResults.append("Количество угаданных букв: \(currentUser.guessedLetters)")
            playerResults.append("Уровень сложности: \(currentUser.difficultLevel)")
        }
        
        for index in 0..<tableView.numberOfRows(inSection: 0) {
            if indexPath.row == index {
                content.text = playerResults[index]
            }
        }
        
        currentCell.contentConfiguration = content
        return currentCell
    }
}
