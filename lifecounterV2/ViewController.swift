//
//  ViewController.swift
//  lifecounterV2
//
//  Created by Phillip Dang on 4/25/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var players = ["Player 1: 20", "Player 2: 20", "Player 3: 20", "Player 4: 20"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
        cell.textLabel?.text = players[indexPath.row]
        return cell
    }
    
    @IBOutlet weak var playerTable: UITableView!
    @IBOutlet weak var currentPlayer: UILabel!
    var currentPlayerValue = 1 {
        didSet {
            currentPlayer.text = "Current Player: \(currentPlayerValue)"
        }
    }
    @IBOutlet weak var livesToChange: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerTable.dataSource = self
        playerTable.delegate = self
    }
    
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var removePlayerButton: UIButton!
    
    @IBAction func addPlayer(_ sender: UIButton) {
        players.append("Player \(players.count + 1): 20")
        playerTable.reloadData()
    }
    
    @IBAction func removePlayer(_ sender: UIButton) {
        players.removeLast()
        playerTable.reloadData()
    }
    
    @IBAction func stepper(_ sender: UIStepper) {
        currentPlayerValue = Int(sender.value)
    }
    
    @IBAction func addLife(_ sender: UIButton) {
        let numberSet = CharacterSet.decimalDigits
        if (livesToChange.text!.rangeOfCharacter(from: numberSet.inverted) == nil) {
            let components = players[currentPlayerValue - 1].components(separatedBy: .whitespaces)
            let currentLives = Int(components.last!)
            players[currentPlayerValue - 1] = "Player \(currentPlayerValue): \(currentLives! + Int(livesToChange.text!)!)"
            playerTable.reloadData()
            addPlayerButton.isEnabled = false
            removePlayerButton.isEnabled = false
        }
    }
    
    @IBAction func removeLife(_ sender: UIButton) {
        let numberSet = CharacterSet.decimalDigits
        if (livesToChange.text!.rangeOfCharacter(from: numberSet.inverted) == nil) {
            let components = players[currentPlayerValue - 1].components(separatedBy: .whitespaces)
            let currentLives = Int(components.last!)
            players[currentPlayerValue - 1] = "Player \(currentPlayerValue): \(currentLives! - Int(livesToChange.text!)!)"
            playerTable.reloadData()
            addPlayerButton.isEnabled = false
            removePlayerButton.isEnabled = false
        }
    }
    
    func checkIfGameOver() -> Bool {
        for player in players {
            let playerLife = Int(player.components(separatedBy: .whitespaces).last!)!
            var eliminatedPlayerCount = 0
            if (playerLife > 0) {
                eliminatedPlayerCount += 1
            }
            if (eliminatedPlayerCount > 1) {
                return false
            }
        }
        return true
    }
}

