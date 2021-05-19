//
//  TicTacToeViewController.swift
//  GroupGame
//
//  Created by Jaymond Richardson on 5/19/21.
//

import UIKit

class TicTacToeViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winnerLabel.isHidden = true
        view.backgroundColor = .cyan
        
    }
    //MARK: - Properties
    var count = 1
    var activePlayer = 1 //Cross
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var gameIsActive = true
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]] //Winning combos
    
    //MARK: - Outlets
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    //MARK: - Actions
    @IBAction func playAgainButtonTapped(_ sender: UIButton) {
        //Resets game board and sets game Active
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        gameIsActive = true
        activePlayer = 1
        
        //Hides Buttons
        playAgainButton.isHidden = true
        winnerLabel.isHidden = true
        view.backgroundColor = .cyan
        
        //Reset Buttons
        for i in 1...9
        {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControl.State())
        }
    }
    
    @IBAction func action(_ sender: UIButton) {
        
        if (gameState[sender.tag-1] == 0 && gameIsActive == true) {
            
            gameState[sender.tag-1] = activePlayer
            
            if (activePlayer) == 1 {
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
                    winnerLabel.text = "X Wins!"
                } else {
                    winnerLabel.text = "O Wins!"
                }
                
                if gameIsActive == true {
                    for i in gameState {
                        count = i*count
                    }
                    if count != 0 {
                        
                        winnerLabel.text = "DRAW"
                        winnerLabel.isHidden = false
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