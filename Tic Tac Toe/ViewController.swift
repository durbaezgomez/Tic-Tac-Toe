//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by admin on 18/05/2019.
//  Copyright © 2019 durbaezgomez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let rect_blank = UIImage(named: "rect_blank")
    let rect_cross = UIImage(named: "rect_cross")
    let rect_circle = UIImage(named: "rect_circle")
    
    @IBOutlet var rectangles: [UIButton]!
    
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var activePlayer = 1
    var isPlayersMove:Bool = true
    
    @IBAction func restartGame(_ sender: UIButton) {
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        for rect in rectangles{
            rect.setImage(rect_blank, for: .normal)
        }
    }
    @IBAction func fieldChosen(_ sender: UIButton) {
        
        if(gameState[sender.tag-1] == 0){
            sender.setImage(rect_cross, for: .normal)
            gameState[sender.tag-1] = activePlayer
            
            var count = 0
            for i in gameState{
                if (i != 0) {count += 1}
            }
            if (count < 9){
                playNextMove()
            }
            print(gameState)
        }
    }
    
    func playNextMove(){
        
        var playedSpot:UInt32
        repeat{
            playedSpot = arc4random_uniform(9)
        }while(gameState[Int(playedSpot)] != 0)
        
        rectangles[Int(playedSpot)].setImage(rect_circle, for: .normal)
        gameState[Int(playedSpot)] = activePlayer
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

