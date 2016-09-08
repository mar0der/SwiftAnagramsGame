//
//  Level.swift
//  Anagrams
//
//  Created by Petar Petkov on 8/22/16.
//  Copyright © 2016 Caroline. All rights reserved.
//

import Foundation

struct Level {
    let pointsPerTile: Int
    let timeToSolve: Int
    let anagrams: [NSArray]
    
    init(levelNumber:Int){
        let fileName = "level\(levelNumber).plist"
        let levelPath = "\(Bundle.main.resourcePath!)/\(fileName)"
        
        let levelDictionary: NSDictionary? = NSDictionary(contentsOfFile: levelPath)
        
        assert(levelDictionary != nil, "Level configuration file not found")
        
        self.pointsPerTile = levelDictionary!["pointsPerTile"] as! Int
        self.timeToSolve = levelDictionary!["timeToSolve"] as! Int
        self.anagrams = levelDictionary!["anagrams"] as! NSArray as! [NSArray]
    }
}
