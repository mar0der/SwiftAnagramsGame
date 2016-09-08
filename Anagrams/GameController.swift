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
    var hud: HUDView! {
        didSet {
            hud.hintButton.addTarget(self, action: #selector(GameController.actionHint), for: .touchUpInside)
            hud.hintButton.isEnabled = false
        }
    }
    var onAnagramSolved:(() -> ())!
    fileprivate var tiles = [TileView]()
    fileprivate var targets = [TargetView]()
    fileprivate var secondsLeft: Int = 0
    fileprivate var timer: Timer?
    fileprivate var data = GameData()
    fileprivate var audioController: AudioController
    
    init(){
        self.audioController = AudioController()
        self.audioController.preloadAudioEffects(AudioEffectFiles)
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
        
        for(index,letter) in anagram2.characters.enumerated(){
            if(letter != " "){
                let target = TargetView(letter: letter, sideLength: tileSide)
                target.center = CGPoint(x: xOffset + CGFloat(index)*(tileSide + TileMargin), y: ScreenHeight/4)
                gameView.addSubview(target)
                targets.append(target)
            }
        }
        
        tiles = []
        
        for (index, letter) in anagram1.characters.enumerated() {
            if letter != " " {
                let tile = TileView(letter: letter, sideLength: tileSide)
                tile.center = CGPoint(x: xOffset + CGFloat(index)*(tileSide+TileMargin), y: ScreenHeight/4*3)
                tile.randomize()
                tile.dragDelegate = self
                
                gameView.addSubview(tile)
                tiles.append(tile)
            }
        }
        
        self.startStopwatch()
        //enable the hing button right after the game begins
        hud.hintButton.isEnabled = true

    }
    
    func placeTile(_ tileView: TileView, targetView: TargetView){
        tileView.isMatched = true
        targetView.isMatched = true
        
        tileView.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.15,
            delay: 0.00,
            options: UIViewAnimationOptions.curveEaseOut,
            animations:
            {
                tileView.center = targetView.center
                //streighten out the tile
                tileView.transform = CGAffineTransform.identity
            },
            completion:
            {
                (value:Bool) in
                targetView.isHidden = true
            }
        )
        let explode = ExplodeView(frame: CGRect(x: tileView.center.x, y: tileView.center.y, width: 10, height: 10))
        tileView.superview?.addSubview(explode)
        tileView.superview?.sendSubview(toBack: explode)
    }
    
    func pushTileOut(_ tileView: TileView){
        //because we want to rotate and move verticli the tile
        tileView.randomize()
        
        UIView.animate(withDuration: 0.35,
            delay:0.00,
            options:UIViewAnimationOptions.curveEaseOut,
            animations:{
            tileView.center = CGPoint(x: tileView.center.x + CGFloat(randomNumber(0, maxX: 40) - 20),
                y: tileView.center.y + CGFloat (randomNumber(20, maxX: 30)))
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
        
        //disable hint button right before game ends
        hud.hintButton.isEnabled = false
        
        self.stopStopwatch()
        audioController.playEffect(SoundWin)
        let firstTarget = targets[0]
        let startX: CGFloat = 0
        let endX: CGFloat = ScreenWidth + 300
        let startY = firstTarget.center.y
        
        let stars = StardustView(frame: CGRect(x: startX, y: startY, width: 10, height: 10))
        gameView.addSubview(stars)
        gameView.sendSubview(toBack: stars)
        
        UIView.animate(withDuration: 3.0,
                                   delay: 0.0,
                                   options: UIViewAnimationOptions.curveEaseOut,
                                   animations: {
                                    stars.center = CGPoint(x: endX, y: startY)
                                    },
                                   completion: {
                                    (value:Bool) in
                                        stars.removeFromSuperview()
                                        self.clearBoard()
                                        self.onAnagramSolved()
                                    })
    }
    
    func startStopwatch(){
        secondsLeft = level.timeToSolve
        hud.stopwatch.setSeconds(secondsLeft)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameController.tick(_:)), userInfo: nil, repeats: true)
    }
    
    func stopStopwatch(){
        //this is how we stop timer. Insanity?!
        timer?.invalidate()
        timer = nil
    }
    
    func clearBoard(){
        tiles.removeAll(keepingCapacity: false)
        targets.removeAll(keepingCapacity: false)
        
        for view in gameView.subviews {
            view.removeFromSuperview()
        }
    }
    
    @objc func tick(_ timer:Timer){
        secondsLeft -= 1
        hud.stopwatch.setSeconds(secondsLeft)
        if secondsLeft == 0 {
            self.stopStopwatch()
        }
    }
    
    @objc func actionHint(){
        hud.hintButton.isEnabled = false
        
        data.points -= level.pointsPerTile / 2
        hud.gamePoints.setValue(data.points, duration: 1.5)
        
        var foundTarget: TargetView? = nil
        for target in targets {
            if !target.isMatched {
                foundTarget = target
                break
            }
        }
        
        var foundTile:TileView? = nil
        
        for tile in tiles {
            if !tile.isMatched && tile.letter == foundTarget?.letter {
                foundTile = tile
                break
            }
        }
        
        if let target = foundTarget, let tile = foundTile {
            //5 don't want the tile sliding under other tiles
            gameView.bringSubview(toFront: tile)
            
            //6 show the animation to the user
            UIView.animate(withDuration: 1.5,
                                       delay:0.0,
                                       options:UIViewAnimationOptions.curveEaseOut,
                                       animations:{
                                        tile.center = target.center
                }, completion: {
                    (value:Bool) in
                    
   
                    self.placeTile(tile, targetView: target)
                    
                    self.hud.hintButton.isEnabled = true
                    
                    self.checkForSuccess()
                    
            })
        }
    }
    
}

extension GameController:TileDragDelegateProtocol{
    
    func tileView(_ tileView: TileView, didDragToPoint point: CGPoint) {
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
                audioController.playEffect(SoundDing)
                self.checkForSuccess()
            }else{
                self.pushTileOut(tileView)
                data.points -= level.pointsPerTile/2
                hud.gamePoints.setValue(data.points, duration: 0.25)
                audioController.playEffect(SoundWrong)
            }
            
        }
    }
}
