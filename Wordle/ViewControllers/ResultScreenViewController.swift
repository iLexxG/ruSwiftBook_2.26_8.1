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

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameResult", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
//        content.text = currentUser.playerUsername
//        
//        
//        cell.contentConfiguration = content
        
        return cell
    }
}
