//
//  TicTacToeViewController.swift
//  GroupGame
//
//  Created by Gavin Woffinden on 5/19/21.
//

import UIKit

class TicTacToeViewController: UIViewController {
    
    //MARK: - Properties
    var count = 1
    var activePlayer = 1
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var gameIsActive = true
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        playAgainButton.isHidden = true
    }
    
    //MARK: - Actions
    
    @IBAction func playAgainButtonTapped(_ sender: Any) {
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        gameIsActive = true
        activePlayer = 1
        playAgainButton.isHidden = true
        winnerLabel.isHidden = true
        
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControl.State())
        }
    }
    
    
    @IBAction func buttonTapped(_ sender: AnyObject) {
        if (gameState[sender.tag-1] == 0 && gameIsActive == true) {
            gameState[sender.tag-1] = activePlayer
            if (activePlayer == 1) {
                sender.setImage(UIImage(named: "x"), for: UIControl.State())
                activePlayer = 2
            } else {
                sender.setImage(UIImage(named: "o"), for: UIControl.State())
                activePlayer = 1
            }
        }
        for combination in winningCombinations {
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
                gameIsActive = false
                
                if gameState[combination[0]] == 1 {
                    winnerLabel.text = "X WINS!"
                } else {
                    winnerLabel.text = "O WINS!"
                }
                if gameIsActive == true {
                    for i in gameState {
                        count = i * count
                    }
                    if count != 0{
                        winnerLabel.isHidden = false
                        winnerLabel.text = "DRAW"
                        playAgainButton.isHidden = false
                    }
                }
                playAgainButton.isHidden = false
                winnerLabel.isHidden = false
            }
        }
        gameIsActive = false
        for i in gameState {
            if i == 0 {
                gameIsActive = true
                break
            }
        }
        if gameIsActive == false {
            winnerLabel.text = "DRAW"
            winnerLabel.isHidden = false
            playAgainButton.isHidden = false
        }
    }
}
