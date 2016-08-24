//
//  GameController.swift
//  Anagrams
//
//  Created by Petar Petkov on 8/23/16.
//  Copyright © 2016 Caroline. All rights reserved.
//

import UIKit

class GameController {
    var gameView: UIView!
    var level: Level!
    var hud: HUDView!
    private var tiles = [TileView]()
    private var targets = [TargetView]()
    private var secondsLeft: Int = 0
    private var timer: NSTimer?
    private var data = GameData()
    
    init(){
        //self.dealRandomAnagram()
    }
    
    func dealRandomAnagram(){
        assert(level.anagrams.count > 0, "no level loaded")
        
        let randomIndex = randomNumber(0, maxX:UInt32(level.anagrams.count-1))
        let anagramPair = level.anagrams[randomIndex]
        
        let anagram1 = anagramPair[0] as! String
        let anagram2 = anagramPair[1] as! String
        
        let anagram1Length = anagram1.characters.count
        let anagram2Length = anagram2.characters.count
        
        //calculate the tile size
        let tileSide = ceil(ScreenWidth * 0.9 / CGFloat(max(anagram1Length,anagram2Length))) - TileMargin
        //get the left margin for first tile
        var xOffset = (ScreenWidth - CGFloat(max(anagram1Length, anagram2Length)) * (tileSide + TileMargin)) / 2.0
        //adjust for tile center (instead of the tile's origin)
        xOffset += tileSide / 2.0
        
        //Important to add targets before the tiles so the will be under the tiles
        targets = []
        
        for(index,letter) in anagram2.characters.enumerate(){
            if(letter != " "){
                let target = TargetView(letter: letter, sideLength: tileSide)
                target.center = CGPointMake(xOffset + CGFloat(index)*(tileSide + TileMargin), ScreenHeight/4)
                gameView.addSubview(target)
                targets.append(target)
            }
        }
        
        tiles = []
        
        for (index, letter) in anagram1.characters.enumerate() {
            if letter != " " {
                let tile = TileView(letter: letter, sideLength: tileSide)
                tile.center = CGPointMake(xOffset + CGFloat(index)*(tileSide+TileMargin), ScreenHeight/4*3)
                tile.randomize()
                tile.dragDelegate = self
                
                gameView.addSubview(tile)
                tiles.append(tile)
            }
        }
        
        self.startStopwatch()

    }
    
    func placeTile(tileView: TileView, targetView: TargetView){
        targetView.isMatched = true
        targetView.isMatched = true
        
        tileView.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.15,
            delay: 0.00,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations:
            {
                tileView.center = targetView.center
                //streighten out the tile
                tileView.transform = CGAffineTransformIdentity
            },
            completion:
            {
                (value:Bool) in
                targetView.hidden = true
            }
        )
    }
    
    func pushTileOut(tileView: TileView){
        //because we want to rotate and move verticli the tile
        tileView.randomize()
        
        UIView.animateWithDuration(0.35,
            delay:0.00,
            options:UIViewAnimationOptions.CurveEaseOut,
            animations:{
            tileView.center = CGPointMake(tileView.center.x + CGFloat(randomNumber(0, maxX: 40) - 20),
                tileView.center.y + CGFloat (randomNumber(20, maxX: 30)))
            },
            completion: nil
        )
    }
    
    func checkForSuccess(){
        for targetView in targets{
            //if it finds not matched targets it exits the method
            if !targetView.isMatched{
                return
            }
        }
        
        self.stopStopwatch()
        print("Game Over")
    }
    
    func startStopwatch(){
        secondsLeft = level.timeToSolve
        hud.stopwatch.setSeconds(secondsLeft)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(GameController.tick(_:)), userInfo: nil, repeats: true)
    }
    
    func stopStopwatch(){
        //this is how we stop timer. Insanity?!
        timer?.invalidate()
        timer = nil
    }
    
    @objc func tick(timer:NSTimer){
        secondsLeft -= 1
        hud.stopwatch.setSeconds(secondsLeft)
        if secondsLeft == 0 {
            self.stopStopwatch()
        }
    }
    
    
}

extension GameController:TileDragDelegateProtocol{
    
    func tileView(tileView: TileView, didDragToPoint point: CGPoint) {
        var targetView: TargetView?
        for tv in targets {
            if tv.frame.contains(point) && !tv.isMatched {
                targetView = tv
                break
            }
        }
        
        if let targetView = targetView {
            
            if targetView.letter == tileView.letter{
                self.placeTile(tileView, targetView: targetView)
                data.points += level.pointsPerTile
                hud.gamePoints.setValue(data.points, duration: 0.5)
                self.checkForSuccess()
            }else{
                self.pushTileOut(tileView)
                data.points -= level.pointsPerTile/2
                hud.gamePoints.setValue(data.points, duration: 0.25)
            }
            
        }
    }
}
