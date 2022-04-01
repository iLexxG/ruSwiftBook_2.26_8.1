//
//  ResultScreenViewController.swift
//  Wordle
//
//  Created by Сергей Иванов on 29.03.2022.
//

import UIKit

class ResultScreenViewController: UITableViewController {
    var currentUser: PlayerProfile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Ваш резульат, \(currentUser.playerUsername):"
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCell = tableView.dequeueReusableCell(withIdentifier: "gameResult", for: indexPath)
        var content = currentCell.defaultContentConfiguration()
        
        if indexPath.row == 0 {
            content.text = currentUser.currentWordle
        } else {
            content.text = String(currentUser.difficultLevel)
        }
        
        currentCell.contentConfiguration = content
        return currentCell
    }
}
