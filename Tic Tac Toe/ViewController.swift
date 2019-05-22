//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by admin on 18/05/2019.
//  Copyright © 2019 durbaezgomez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   
    @IBOutlet var rectangles: [UIButton]!
    
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var winSeq:[Int] = [0,0,0]
    var winner:Int?
    
    @IBAction func restartGame(_ sender: UIButton) {
        resetGameState()
    }
    
    func resetGameState(){
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        winSeq = [0,0,0]
        for rect in rectangles{
            rect.isHidden = false
        }
        for rect in rectangles{
            rect.setImage(UIImage(named: "rect_blank"), for: .normal)
        }
    }
    
    @IBAction func fieldChosen(_ sender: UIButton) {
        
        var count = 0
        for i in gameState{
            if (i != 0) {count += 1}
        }
        
        if(gameState[sender.tag-1] == 0){
            sender.setImage(UIImage(named: "rect_cross"), for: .normal)
            gameState[sender.tag-1] = 1
            
            lookForVictory()
        }
        
        if (count > 7){
            print("DRAW")
        }
        
        else {
            playNextMove()
            print("YOUR MOVE")
            lookForVictory()
        }
//        print(gameState)
    }
    
    func playNextMove(){
        
        var playedSpot:Int
        repeat{
            playedSpot = Int(arc4random_uniform(9))
//            playedSpot = findBestMove()
            print(playedSpot)
        }while(gameState[playedSpot] != 0)
        
        rectangles[playedSpot].setImage(UIImage(named: "rect_circle"), for: .normal)
        gameState[playedSpot] = 2
    }
    
    func lookForVictory(){
        if (checkIfWon()){
            print("WIN")
            print(winSeq)
            showVictory(winner: winner!)
        }
    }
    
    func checkIfWon() -> Bool{
        for p in 1...2{
            var counter: Int
            for i in 0...2{ // rows
                counter = 0
                for j in 0...2{
                    if (gameState[j+i*3] == p){
                        winSeq[j] = j+i*3
                        counter += 1
                    }
                    if (counter == 3){
                        winner = p
                        return true
                    }
                }
            }
            for i in 0...2{ // columns
                counter = 0
                for j in 0...2{
                    if (gameState[j*3+i] == p){
                        winSeq[j] = j*3+i
                        counter += 1
                    }
                    if (counter == 3){
                        winner = p
                        return true
                    }
                }
            }
            // diagonals
            counter = 0
            if (gameState[0] == p && gameState[4] == p && gameState[8] == p){
                winSeq = [0,4,8]
                winner = p
                return true
            }
            if (gameState[2] == p && gameState[4] == p && gameState[6] == p){
                winSeq = [2,4,6]
                winner = p
                return true
            }
        }
        
        return false
    }
    
    func showVictory(winner: Int){
        for rect in rectangles{
            rect.setImage(UIImage(named: "rect_inactive"), for: .normal)
        }
        if (winner == 1){
            for val in winSeq{
                rectangles[val].setImage(UIImage(named: "rect_cross_win"), for: .normal)
            }
        }
        else{
            for val in winSeq{
                rectangles[val].setImage(UIImage(named: "rect_circle_win"), for: .normal)
            }
        }
        
    }

    func checkDanger(){
        
        //       TODO: SPRAWDZANIE ZAGROZEN -> ZWROC INDEX DO BLOKADY
        //       TODO: SZUKANIE MOZLIWOSCI WYGRANEJ -> ZWROC INDEX WYGRANEJ
        
    }
    
    func findBestMove() -> Int{
        
        var occupied: [Int] = []
        var counter: Int
        
        for i in 0...2{ // rows
            counter = 0
            for j in 0...2{
                if (gameState[j+i*3] == 2){
                    counter += 1
                    occupied.append(j+i*3)
                }
                if (counter == 2){
                    return j+6 - occupied.reduce(0,+)
                }
            }
        }
        
        for i in 0...2{ // columns
            counter = 0
            for j in 0...2{
                if (gameState[j*3+i] == 2){
                    counter += 1
                    occupied.append(j+i*3)
                }
                if (counter == 2){
                    return i+6 - occupied.reduce(0,+)
                }
            }
        }
        
        return Int(arc4random_uniform(9))

        // diagonals
        counter = 0
//        let con0:Bool = gameState[0] == 2
//        let con4:Bool = gameState[4] == 2
//        let con8:Bool = gameState[8] == 2
//        let con2:Bool = gameState[2] == 2
//        let con6:Bool = gameState[6] == 2
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

