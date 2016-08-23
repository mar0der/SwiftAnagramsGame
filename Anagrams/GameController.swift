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
    private var tiles = [TileView]()
    private var targets = [TargetView]()
    
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
                
                gameView.addSubview(tile)
                tiles.append(tile)
            }
        }

    }
}
