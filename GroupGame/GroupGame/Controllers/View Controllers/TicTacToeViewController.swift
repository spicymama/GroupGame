//
//  TicTacToeViewController.swift
//  GroupGame
//

//  Created by JJB on 5/19/21.

//  Created by Jaymond Richardson on 5/19/21.

//

import UIKit

class TicTacToeViewController: UIViewController {
    
    

    //MARK: - Properties
    //activePlayer = X
    var activePlayer = 1
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    //allow the game to pause after player has won
    var gameIsActive = true
    
    //Setting the winning combinations
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    
    //MARK: - Outlets
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var winnerLabel: UILabel!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - Actions
    @IBAction func playAgainButtonTapped(_ sender: Any) {
        //Reset the gameState to game start state

        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        gameIsActive = true
        activePlayer = 1
        

        //Hide the reset button and winner label
        playAgainButton.isHidden = true
        winnerLabel.isHidden = true
        
        //Reset all the buttons
        for i in 1...9 {

            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControl.State())
        }
    }
    
    @IBAction func gameFunction(_ sender: AnyObject) {
        
        //need this if-statement to allow x's and o's to be set
        if (gameState[sender.tag-1] == 0 && gameIsActive == true) {
            gameState[sender.tag-1] = activePlayer
            
            if (activePlayer == 1) {
                sender.setImage(UIImage(named: "x.png"), for: UIControl.State())
                activePlayer = 2
            } else {
                sender.setImage(UIImage(named: "o.png"), for: UIControl.State())

                activePlayer = 1
            }
        }

        //need to loop through the combinations for the winning combinations
        for combination in winningCombinations {
            //winning logic...
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
              
                //Pauses the game after a winning combination found
                gameIsActive = false
                
                //Declares the winner
                if gameState[combination[0]] == 1 {
                    //X has won
                    winnerLabel.text = "X HAS WON!!!"
                } else {
                    //O has won
                    winnerLabel.text = "O HAS WON!!!"
                }
                
                //Allow user to play again

                playAgainButton.isHidden = false
                winnerLabel.isHidden = false
            }
        }
        
        //Check the game for a Draw
        gameIsActive = false
        
        //If there is still an open spot : break out and keep playing

        for i in gameState {
            if i == 0 {
                gameIsActive = true
                break
            }
        }
        
    //If all spots are full and no person has won declare the draw
        if gameIsActive == false {
            winnerLabel.text = "It was a Draw"

            winnerLabel.isHidden = false
            playAgainButton.isHidden = false
        }
    }
} //End of class

