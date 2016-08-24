//
//  GameData.swift
//  Anagrams
//
//  Created by Petar Petkov on 8/24/16.
//  Copyright © 2016 Caroline. All rights reserved.
//

class GameData{
    var points:Int = 0{
        didSet{
            points = max(points, 0)
        }
    }
}
